# Version 0.2
# Removed interface of P&R (Innovus) to avoid its internal bugs.
# Chipyard updated on Feb 2023

import numpy as np 
import os,yaml,fcntl,shutil,time,random,subprocess
from goto import with_goto
import copy as cp
from typing import List, Union
from datetime import datetime
import sram_placer
from design_flow_interface import Design_Flow_Interface
from yaml_parser import feature_vector_for_test,default_feature_vector
import hammer.tech as hammer_tech
import multiprocessing as mp
import sys
try:
    import hammer.vlsi as hammer_vlsi
except:
    import hammer_vlsi

# !!! Take care of this
global_test_run_all = False
####################################################################
#                    Custom Exception                              #
####################################################################
class HammerFailed(Exception):
    def __init__(self, arg_list, message='Hammer Failed'):
        self.arg_list = arg_list
        self.message = 'Hammer failed to complete. Arguments are {}'.format(self.arg_list)
        super().__init__(self.message)

class SimulationFailed(Exception):
    def __init__(self, failed_sim, message='Simulation Failed'):
        self.failed_sim = failed_sim
        self.message = 'Simulation failed. Binary is: {}'.format(failed_sim)
        super().__init__(self.message)

class BoomGenFailed(Exception):
    def __init__(self, message='Failed to make boom simulator binary.'):
        self.message = message
        super().__init__(self.message)        
####################################################################
#                                                                  #
####################################################################
def ClearProcessStatus(max_processs:int=8,file_path:str = os.path.join(os.environ['DUMP_DIR'], 'process.txt')): #✓
    process_v = np.zeros(max_processs)
    with open(file_path,'w') as fout:
        np.savetxt(fout,process_v,delimiter=',',fmt='%d')

def ClearFile(file:str = os.path.join( os.path.expanduser('~'), 'vm/shared/workspace/rv-opt-tsmc/var_bound.yml')): #✓
    if os.path.exists(file):
        os.remove(file)

def RecordTime(info:str = '@',file:str = os.path.join(os.environ['DUMP_DIR'], 'time.log')): #✓
    with open(file,'a') as fout:
        current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        fout.write('{} -- {}\n'.format(info,current_time))
####################################################################
#                       Extra Hooks                                #
####################################################################
def ExtraHookSynAttr(ht: hammer_vlsi.HammerTool) -> bool: #✓
    pre_syn_cmd = ht.get_setting('synthesis.genus.pre_syn_cmd')
    ht.append('\n#========Synthesis Attributes========')
    if [] != pre_syn_cmd:
        ht.append('\n'.join(pre_syn_cmd))
    ht.append('#========================\n')
    return True

def ExtraHookSynGenSramPathList(ht: hammer_vlsi.HammerTool) -> bool: #✓
    ht.append('\n#========Generate SRAM List========')
    ht.append("\
    vcd root:\n\
    set rv_rtl_path [lindex [exec find \"../../../generated-src\" -name \"chipyard.*\" -type d] 0]\n\
    set mem_conf [exec find $rv_rtl_path -name \"*top.mems.conf\"]\n\
    set mem_conf_fp [open $mem_conf r]\n\
    set mem_conf_content [read $mem_conf_fp]\n\
    set cache_blocks \"\"\n\
    foreach line [split $mem_conf_content \"\\n\"] {\n\
        if {$line eq \"\"} {\n\
            break\n\
        }\n\
        lappend cache_blocks [lindex $line 1]\n\
    }\n\
    close $mem_conf_fp\n\
    set sram_list \"\"\n\
    foreach block $cache_blocks {\n\
        set block_path [vfind ChipTop -hinst $block]\n\
        set block_path [string range $block_path 6 end]\n\
        set sram_blocks [vfind $block_path -inst mem* ]\n\
        foreach sram $sram_blocks {\n\
            set sram [string range $sram 5 end]\n\
            lappend sram_list $sram\n\
        }\n\
    }\n\
    set sram_list_fp [open sram_list.txt w]\n\
    foreach sram_module $sram_list {\n\
        puts $sram_list_fp $sram_module\n\
    }\n\
    close $sram_list_fp"
    )
    ht.append('#========================\n')
    return True

def ExtraHookSynDeleteRTLExceptMems(ht: hammer_vlsi.HammerTool) -> bool: #✓
    if not ht.get_setting('synthesis.genus.reduce_drive_usage'):
        return True
    
    # pos = ht.run_dir.rfind('/build')
    # path = ht.run_dir[ :pos+1] + 'generated-src'
    # ht.append('exec find {} -type f -not \\( -name \"*.top.mems.v\" -or -name \"*.mems.hammer.json\" \\) -delete'.format(path))
    return True

def ExtraHookSynMoreInitEnviron(ht: hammer_vlsi.HammerTool) -> bool:
    ht.append('set_db lp_power_unit mW')
    if ht.get_setting('synthesis.genus.reduce_drive_usage'):
        ht.append('set_db write_verification_files false')
    return True

def ReplaceHookInitEnvironment(ht: hammer_vlsi.HammerTool) -> bool:
    logger = ht.logger
    verbose_append = ht.append
    
    # Clock gating setup
    if ht.get_setting("synthesis.clock_gating_mode") == "auto":
        verbose_append("set_db lp_clock_gating_infer_enable  true")
        verbose_append("set_db lp_clock_gating_prefix  {CLKGATE}")
        verbose_append("set_db lp_insert_clock_gating  true")
        verbose_append("set_db lp_clock_gating_hierarchical true")
        verbose_append("set_db lp_insert_clock_gating_incremental true")
        verbose_append("set_db lp_clock_gating_register_aware true")
    
    # Set up libraries.
    # Read timing libraries.
    mmmc_path = os.path.join(ht.run_dir, "mmmc.tcl")
    logger.info(f"Generating MMMC script: {mmmc_path}")
    ht.write_contents_to_path(ht.generate_mmmc_script(), mmmc_path)
    verbose_append(f"read_mmmc {mmmc_path}")
    
    # Read ILMs.
    if ht.hierarchical_mode.is_nonleaf_hierarchical():
        for ilm in ht.get_input_ilms():
            verbose_append(f"read_ilm -basename {ilm.data_dir}/{ilm.module}_postRoute -module_name {ilm.module}")
    
    # Read LEF layouts.
    lef_files = ht.technology.read_libs([
        hammer_tech.filters.lef_filter
    ], hammer_tech.HammerTechnologyUtils.to_plain_item)
    if ht.hierarchical_mode.is_nonleaf_hierarchical():
        ilm_lefs = list(map(lambda ilm: ilm.lef, ht.get_input_ilms()))
        lef_files.extend(ilm_lefs)
    verbose_append(f"read_physical -lef {{ {' '.join(lef_files)} }}")

    # Load input files and check that they are all Verilog.
    if not ht.check_input_files([".v", ".sv"]):
        return False
    abspath_input_files = [os.path.join(os.getcwd(), name) for name in ht.input_files]

    # If we are in hierarchical, we need to remove hierarchical sub-modules/sub-blocks.
    if ht.hierarchical_mode.is_nonleaf_hierarchical():
        abspath_input_files = list(map(ht.remove_hierarchical_submodules_from_file, abspath_input_files))

    # Add any verilog_synth wrappers (which are needed in some technologies e.g. for SRAMs) which need to be
    # synthesized.
    extra_synth_files = ht.technology.read_libs([
        hammer_tech.filters.verilog_synth_filter
    ], hammer_tech.HammerTechnologyUtils.to_plain_item)
    if extra_synth_files:
        abspath_input_files += extra_synth_files
    
    # Read the RTL.
    verbose_append("read_hdl -sv {{ {} }}".format(" ".join(abspath_input_files)))

    # Elaborate/parse the RTL.
    verbose_append(f"elaborate {ht.top_module}")
    # Preserve submodules
    if ht.hierarchical_mode.is_nonleaf_hierarchical():
        for ilm in ht.get_input_ilms():
            verbose_append(f"set_db module:{ht.top_module}/{ilm.module} .preserve true")
    verbose_append(f"init_design -top {ht.top_module}")

    # Prevent floorplanning targets from getting flattened.
    # TODO: is there a way to track instance paths through the synthesis process?
    verbose_append("set_db root: .auto_ungroup none")

    # Set units to pF and technology time unit.
    # Must be done after elaboration.
    verbose_append("set_units -capacitance 1.0pF")
    verbose_append("set_load_unit -picofarads 1")
    time_unit = ht.get_time_unit()
    verbose_append(f"set_units -time 1.0{time_unit.value_prefix}{time_unit.unit}")
    
    return True

def ReplaceHookSynWriteReports(ht: hammer_vlsi.HammerTool) -> bool:
    ht.append('exec mkdir -p reports')
    # Run power analysis at most 4 times in case of SEGV error.
    ht.append('''
  # Report Power
    for {set i 0} {$i < 4} {incr i} {
        if { [catch {
            report_power > reports/power.rpt
        } err] } {
            puts "Power Analysis Error: $err"
            exec sleep 10m
        } else {
            break
        }
    }
    ''')
    # Same for area analysis
    ht.append('''
  # Report Area
    for {set i 0} {$i < 4} {incr i} {
        if { [catch {
            report_area -depth 2 > reports/area.rpt
        } err] } {
            puts "Area Analysis Error: $err"
            exec sleep 10m
        } else {
            break
        }
    }
    ''')
    # Same for STA
    ht.append('''
  # Report Setup Timing Slack
    for {set i 0} {$i < 4} {incr i} {
        if { [catch {
            report_timing -path_type summary -nworst 2 > reports/setup.rpt
        } err] } {
            puts "STA Error: $err"
            exec sleep 10m
        } else {
            break
        }
    }
    ''')
    # ht.append('report_power > reports/power.rpt')
    # ht.append('report_area -depth 2 > reports/area.rpt')
    # ht.append('report_timing -path_type summary -nworst 2 > reports/setup.rpt')
    
    return True

def ExtraHookParRoutingLayers(ht: hammer_vlsi.HammerTool) -> bool:
    ht.append('set_db route_design_bottom_routing_layer 1')
    ht.append('set_db route_design_top_routing_layer 10')
    return True

def ReplaceHookParRouteDesign(ht: hammer_vlsi.HammerTool) -> bool:
    if ht.hierarchical_mode.is_nonleaf_hierarchical():
        ht.append('flatten_ilm')
    ht.append('set_db design_express_route true')
    ht.append('route_design')
    if ht.hierarchical_mode.is_nonleaf_hierarchical():
        ht.append('unflatten_ilm')
    return True

def ReplaceHookParWriteRegs(ht: hammer_vlsi.HammerTool) -> bool:
    ht.append('''
        set write_cells_ir "./find_regs_cells.json"
        set write_cells_ir [open $write_cells_ir "w"]
        puts $write_cells_ir "["

        set refs [get_db [get_db lib_cells -if .is_sequential==true] .base_name]
        set len [llength $refs]
        for {set i 0} {$i < [llength $refs]} {incr i} {
            if {$i == $len - 1} {
                puts $write_cells_ir "    \"[lindex $refs $i]\""
            } else {
                puts $write_cells_ir "    \"[lindex $refs $i]\",""
            }
        }

        puts $write_cells_ir "]"
        close $write_cells_ir

        set write_regs_ir "./find_regs_paths.json"
        set write_regs_ir [open $write_regs_ir "w"]
        puts $write_regs_ir "["

        set regs [get_db [get_db [all_registers -edge_triggered -output_pins] -if .direction==out] .name]
        set len [llength $regs]
        for {set i 0} {$i < [llength $regs]} {incr i} {
            set myreg [lindex $regs $i]
            if {$i == $len - 1} {
                puts $write_regs_ir "    \"$myreg\""
            } else {
                puts $write_regs_ir "    \"$myreg\",""
            }
        }

        puts $write_regs_ir "]"
        close $write_regs_ir
    ''')
    return True

def RunShellSingle(shell_to_run:mp.Queue): #✓
    while not shell_to_run.empty():
        make_shell = shell_to_run.get_nowait()
        os.system(make_shell)
####################################################################
#                                                                  #
####################################################################
class VLSI_Observer(hammer_vlsi.CLIDriver):
    # Protected
    _process_status_file = '{}/vm/shared/workspace/dump/process.txt'.format( os.path.expanduser('~') )
    _extra_config_file = 'extra_config.yml'
    _sram_place_file = 'sram_place.yml'
    _interface_test_log = '{}/vm/shared/workspace/dump/interface_test.log'.format( os.path.expanduser('~') )
    _verilator_make_dir = '{}/vm/shared/workspace/chipyard5/sims/verilator'.format(os.path.expanduser('~'))
    _hammer_test_log = '{}/vm/shared/workspace/dump/test.log'.format( os.path.expanduser('~') )
    _make_log = ''
    _max_rerun = 6 # Max times to rerun a step if fails
    # _max_rerun = 0
    _threads_per_process = None #Read this value from "common.yml"

    # Public
    test_call=False
    single_obs=True #!!!Assumes running this class on CentOS VM with 1 process

    def __init__(self,  #✓
        setting_file:str = '{}/vm/shared/workspace/rv-opt-tsmc/yaml/setting0.yml'.format(os.path.expanduser('~')),
        # setting_file:str = '{}/vm/shared/workspace/rv-opt-tsmc/yaml/setting_a.yml'.format(os.path.expanduser('~')),
        env_yml:str = '{}/vm/shared/workspace/rv-opt-tsmc/yaml/env.yml'.format(os.path.expanduser('~')),
        # env_yml:str = '{}/vm/shared/workspace/rv-opt-tsmc/yaml/env_a.yml'.format(os.path.expanduser('~')),
        base_conf:List[str] = ['{}/vm/shared/workspace/rv-opt-tsmc/yaml/tools.yml'.format(os.path.expanduser('~')),
        # base_conf:List[str] = ['{}/vm/shared/workspace/rv-opt-tsmc/yaml/tools_a.yml'.format(os.path.expanduser('~')),
                               '{}/vm/shared/workspace/rv-opt-tsmc/yaml/common.yml'.format(os.path.expanduser('~'))],
                               # '{}/vm/shared/workspace/rv-opt-tsmc/yaml/common_a.yml'.format(os.path.expanduser('~'))],
        my_id:int = 0
    ):
        super().__init__()
        self.interface = Design_Flow_Interface(setting_file, -1)

        self.env_yml = env_yml
        self.base_conf = base_conf
        self.working_dir = self.interface.setting_root['working_dir']
        self.config_name = self.interface.setting_root['config_name']
        # self.config_name = "SmallBoomL1Config"
        # self.config_name = "OptBoomL1Config29"

        self.acquired_process = my_id
        self.sp = None
        self.var_info = None
        self.my_id = my_id

        for file in base_conf:
            self.GetMaxThreadsFromConfYaml(file)
            if None != self._threads_per_process:
                break
        
        if None == self._threads_per_process:
            print('@[py_interface]: Cannot read in max thread count.')
            exit()
            
    @with_goto
    def __call__(self, feature_vector:np.ndarray) -> float: #✓
        self.OccupyProcessID()
        if None == self.var_info:
            self.LoadVarInfo()
        scripts_for_all,_ = self.interface.FeatureVec2ScriptsForAll(feature_vector)
        self._make_log = os.path.join(self.working_dir,'make.log')

      #==============================#
      #========RTL Generation========#
      #==============================#
        print('@[py_interface]: Start RTL Generation. There may be errors of cannot find SRAMs. Ignore them.')
        make_dir = self._verilator_make_dir
        # _verilator_make_dir  = '{}/vm/shared/workspace/chipyard0/sims/verilator'
        make_rerun_times = 0
        make_success = False

        label .make_begin
        # To avoid EICG_wrapper.v not found error, delete 'generated-src' first. The file EICG_wrapper.v will be deleted by mistake if the same config is compiled already
        try:
            if not self.test_call:
                shutil.rmtree(os.path.join(self.working_dir, 'generated-src'))
        except:
            pass

        # Delete simulator binary so that the server will error out instead of simulating with old binary when BOOM failed to make.
        os.system('find {} -maxdepth 1 -name {} -delete'.format(self.working_dir, 'simulator*Config*'))

        make_shell = 'cd {make_dir}; make CONFIG={config} sim_dir={working_dir} -j {n_threads} > {make_log} 2>&1'.format(
            make_dir=make_dir,
            config=self.config_name,
            working_dir=self.working_dir,
            n_threads=self.GetMaxThreads(),
            make_log=self._make_log
        )
        gen_dir = '{}/generated-src/chipyard.TestHarness.{}'.format(self.working_dir,self.config_name)
        self.interface.WriteScalaConfigs(scripts_for_all['arch'])
        if self.test_call:
            # For test use only
            pass
            # source = os.path.join(os.environ['__DIR'], 'sims/verilator/generated-src')
            # source = os.path.abspath(source)
            # print(source)
            # /export/home/yyzhao/vm/shared/workspace/chipyard0/sims/verilator/generated-src
            # dest = os.path.join(self.working_dir,'generated-src')
            # print(dest)
            # /export/home/yyzhao/vm/shared/workspace/dump/p0/generated-src
            # if os.path.exists( dest ):
                # shutil.rmtree( dest )
            # shutil.copytree(source, dest)
        else:
            os.system(make_shell)
            print(self.config_name)
            print(gen_dir)
            find_SEGV = subprocess.getoutput('grep \"Segmentation fault\" {}'.format(self._make_log))
            # /export/home/yyzhao/vm/shared/workspace/dump/p0/generated-src/chipyard.TestHarness.OptBoomConfig0  
            if (not find_SEGV) and os.path.exists( '{}/chipyard.TestHarness.{}.mems.hammer.json'.format(gen_dir, self.config_name)):
                make_rerun_times = 0
                make_success = True
            elif make_rerun_times >= self._max_rerun:
                raise BoomGenFailed()
            else:
                make_success = False
                make_rerun_times += 1
                n_minutes = 5 + random.randint(0,10)
                time.sleep(60 * n_minutes)
                # time.sleep(n_minutes-2)
                goto .make_begin

      #=================================#
      #========Create input yaml========#
      #=================================#
        print('@[py_interface]: Create and write inputs.yml & sram_generator-input.yml .')
        build_dir = '{}/build/chipyard.TestHarness.{}-ChipTop'.format(self.working_dir,self.config_name)
        # print(build_dir)
        # /export/home/yyzhao/vm/shared/workspace/dump/p0/build/chipyard.TestHarness.OptBoomConfig0-ChipTop
        # print(gen_dir)
        # /export/home/yyzhao/vm/shared/workspace/dump/p0/generated-src/chipyard.TestHarness.OptBoomConfig0
        if not os.path.exists(build_dir):
            os.makedirs(build_dir)

        with open(os.path.join(build_dir,'sram_generator-input.yml'), 'w') as fout:
            fout.write('vlsi.inputs.sram_parameters: \"{}/chipyard.TestHarness.{}.mems.hammer.json\"\n'.format(gen_dir, self.config_name))
            fout.write('vlsi.inputs.sram_parameters_meta: [\"transclude\", \"json2list\"]')

        verilog_list = []
        # '/export/home/yyzhao/vm/shared/workspace/dump/p0/generated-src/chipyard.TestHarness.OptBoomConfig0/gen-collateral'
        file_list = os.listdir(os.path.join(gen_dir,'gen-collateral'))
        for vlg in file_list:
            if (vlg.endswith('.v') or vlg.endswith('.sv')) and not 'Sim' in vlg: 
                verilog_list.append( os.path.join(gen_dir,'gen-collateral',vlg) )

        inputs = {
            'synthesis.inputs':{
                'top_module': 'ChipTop',
                'input_files':verilog_list
            }
        }
        with open(os.path.join(build_dir, 'inputs.yml'), 'w') as fout:
            yaml.dump(inputs, fout)
            
      #=====================================#
      #========Hammer SRAM Generator========#
      #=====================================#
        print('@[py_interface]: Call SRAM Generator with Hammer.')
        self.base_conf += [
            # os.path.join(self.working_dir, self.interface.attr_cfg),
            # os.path.join(build_dir, 'inputs.yml'),
            os.path.join(build_dir, 'sram_generator-input.yml')
        ]

        arg_list = ['-e', self.env_yml]
        for file in self.base_conf:
            arg_list = arg_list + ['-p', file]
        arg_list += [
            '--log', '/dev/null'  #We don't need hammer log
        ]
        extra_arg_list = [
            '--obj_dir', gen_dir,
            '--output', os.path.join(build_dir,'sram_generator-output.json'),
            'sram_generator'
        ]
        
        # Run SRAM Generator
        sram_success = False
        for i in range(self._max_rerun):
            sram_success = self.CallHammer(arg_list + extra_arg_list) 
            if sram_success:
                break
        
        if not sram_success:
            raise HammerFailed(arg_list + extra_arg_list)

        try:
            self.SimplifySRAMVerilog( os.path.join(gen_dir,'tech-tsmc-cache') )
        except Exception as e:
            if not self.test_call:
                print(e,type(e))
                raise Exception('Error in SRAM Verilog.')

        # Make again to get simulation binary
        # make_shell = make_shell.replace(' > ', ' >> ')
        # if not self.test_call:
        #     os.system(make_shell)
        #     find_SEGV = subprocess.getoutput('grep \"Segmentation fault\" {}'.format(self._make_log))
        #     if (not find_SEGV) and self.SimulatorBinaryExist(): #Success
        #         make_rerun_times = 0
        #         make_success = True
        #     elif make_rerun_times >= self._max_rerun: #Reached max rerun times, error out
        #         raise BoomGenFailed()
        #     else: #Failed, rerun make
        #         make_success = False
        #         make_rerun_times += 1
        #         make_shell = make_shell.replace(' >> ', ' > ')
        #         n_minutes = 5 + random.randint(0,10)
        #         time.sleep(60 * n_minutes)
        #         goto .make_begin
            
        # make_shell = make_shell.replace(' >> ', ' > ')
        
      #==============================#
      #========RTL Simulation========#
      #==============================#
        print('@[py_interface]: Run RTL Simulation in parallel.')
        # if self.test_call:
        #     pass
            #source = os.path.join(os.environ['HAMMER_HOME'], '../backup/p0/output')
            #source = os.path.abspath(source)
            #dest = os.path.join(self.working_dir,'output')
            #if os.path.exists( dest ):
            #    shutil.rmtree( dest )
            #shutil.copytree(source,dest)
        # else:
        #     sim_success=False
        #     failed_sim=[]
        #     for i in range(self._max_rerun):
        #         self.ParallelSimulation(failed_sim)
        #         failed_sim = self.interface.CheckFailedSim()
        #         if not failed_sim:
        #             sim_success = True
        #             break
        #         n_minutes = 5 + random.randint(0,10)
        #         time.sleep(60 * n_minutes)

        #     if not sim_success:
        #         raise SimulationFailed(failed_sim)

      #============================#
      #========Hammer Build========#
      #============================#
        arg_list += [
            '-p', os.path.join(build_dir, 'inputs.yml'),
            '-p', os.path.join(build_dir,'sram_generator-output.json')
        ]
        extra_arg_list = [
            '--obj_dir', build_dir,
            'build'
        ]
        # Create build file
        self.CallHammer(arg_list + extra_arg_list)

      #===============================#
      #========Logic Synthesis========#
      #===============================#
        if not self.test_call:
            self.interface.WriteSynAndParAttrToYml(scripts_for_all['syn'], scripts_for_all['par'])
            self.FixIOCellHighZ(gen_dir)

        self.base_conf += [
            os.path.join(self.working_dir, self.interface.attr_cfg)
            # os.path.join(build_dir, 'inputs.yml'),
            # os.path.join(build_dir, 'sram_generator-input.yml')
        ]
        arg_list.insert(2,'-p') #insert after '-e env.yml'
        arg_list.insert(3,self.base_conf[-1])

        extra_arg_list = [
            '--obj_dir', build_dir,
            '--output', '{}/syn-rundir/syn-output.json'.format(build_dir), 
            'syn'
        ]

        # Run Logic Synthesis
        syn_success = False
        for i in range(self._max_rerun):
            syn_success = self.CallHammer(arg_list + extra_arg_list)
            syn_success = syn_success and self.interface.SynthesisReportsExists()
            if syn_success:
                break
            else:
                # Rerun synthesis after random minutes
                # os.system('sleep $(( $RANDOM % 16 + 14 ))m')
                n_minutes = 15 + random.randint(0,15)
                time.sleep(60 * n_minutes)


        if not syn_success:
            raise HammerFailed(arg_list + extra_arg_list)

      #===============================#
      #==== Run place-and-route =====#
      #===============================#
        # Prepare Innovus run
        parprep_args = [
            '-e', self.env_yml,
            '-p', f'{build_dir}/syn-rundir/syn-output-full.json',
            '-o', f'{build_dir}/par-input.json',
            '--log', '/dev/null',
            '--obj_dir', build_dir
        ]
        parprep_success = False
        for _ in range(self._max_rerun):
            parprep_success = self.CallHammer(parprep_args + ['syn-to-par'])
            if parprep_success:
                break
            n_minutes = 15 + random.randint(0,15)
            time.sleep(60 * n_minutes)

        if not parprep_success:
            raise HammerFailed(parprep_args + ['syn-to-par'])

        self.interface.WriteSynAndParAttrToYml(scripts_for_all['syn'], scripts_for_all['par'])
        self.base_conf += [
            os.path.join(self.working_dir, self.interface.attr_cfg),
            os.path.join(build_dir, 'inputs.yml'),
            os.path.join(build_dir, 'sram_generator-input.yml')
        ]

        par_args = ['-e', self.env_yml]
        for file in self.base_conf:
            par_args += ['-p', file]
        par_args += [
            '--log', '/dev/null',
            '--obj_dir', build_dir
        ]
        extra_par_args = ['-p', f'{build_dir}/par-input.json', 'par']

        par_success = False
        for _ in range(self._max_rerun):
            par_success = self.CallHammer(par_args + extra_par_args)
            if par_success:
                break
            n_minutes = 15 + random.randint(0,15)
            time.sleep(60 * n_minutes)

        if not par_success:
            raise HammerFailed(par_args + extra_par_args)

      #========================#
      #========Get Loss========#
      #========================#
        result = self.interface.ExtractValue()
        loss = self.interface.LossFunc(result)

      #========================================#
        # self.interface.WriteDataToCSV(feature_vector, result, loss, self.var_info['var_type'])
        syn_rundir = os.path.join(build_dir,'syn-rundir')
        self.MoveReportsAway(syn_rundir) 
        self.ReleaseProcessID()

        return loss,result

    @property
    def max_threads(self) -> int:
        return self._threads_per_process

    # Hammer hook getter from CLIDriver
    def get_extra_par_hooks(self) -> List[hammer_vlsi.HammerToolHookAction]:
        extra_hooks = [
            hammer_vlsi.HammerTool.make_post_insertion_hook('init_design', ExtraHookParRoutingLayers),
            hammer_vlsi.HammerTool.make_replacement_hook('route_design', ReplaceHookParRouteDesign),
            hammer_vlsi.HammerTool.make_replacement_hook('write_regs', ReplaceHookParWriteRegs)
        ]
        return extra_hooks

    def get_extra_synthesis_hooks(self) -> List[hammer_vlsi.HammerToolHookAction]: #✓
        extra_hooks = [
            # Insertion Hooks
            # Replacement Hooks
            hammer_vlsi.HammerTool.make_replacement_hook('init_environment', ReplaceHookInitEnvironment),
            # Insertion Hooks
            # hammer_vlsi.HammerTool.make_post_insertion_hook('init_environment', ExtraHookSynGenSramPathList),
            # hammer_vlsi.HammerTool.make_post_insertion_hook('init_environment', ExtraHookSynMoreInitEnviron),
            hammer_vlsi.HammerTool.make_pre_insertion_hook('syn_generic', ExtraHookSynGenSramPathList),
            hammer_vlsi.HammerTool.make_pre_insertion_hook('syn_generic', ExtraHookSynMoreInitEnviron),
            hammer_vlsi.HammerTool.make_pre_insertion_hook('syn_generic', ExtraHookSynAttr),
            # Replacement Hooks
            hammer_vlsi.HammerTool.make_replacement_hook('generate_reports', ReplaceHookSynWriteReports),
            # Removal Hooks
            hammer_vlsi.HammerTool.make_pre_insertion_hook('syn_generic', ExtraHookSynDeleteRTLExceptMems)
        ]
        return extra_hooks

    # Member Func
    def CallHammer(self,arg_list) -> bool:
        if self.test_call:
            return True
            
        try:
            #cwd = os.getcwd()
            #os.chdir(os.path.join(os.environ['HAMMER_HOME'],'..'))
            self.main(arg_list)
            #os.chdir(cwd)
        except SystemExit:
            # Prevent Hammer from calling sys.exit()
            pass
        except Exception as e:
            self.WriteTestLog(self._hammer_test_log, '[@py_interface]: Error from process #{}\n{}\n{}'.format(self.acquired_process,str(e),type(e)))
            return False

        return True

    def DeleteWontUsedSrc(self,del_dir:str,except_file:List[str]): #*  Not used
        for root, dirs, files in os.walk(del_dir):
            for f in files:
                if f not in except_file:
                    os.remove(os.path.join(root,f))
        
    def FindFile(self, name:str, path:str) -> str: #*  Not used
        for root, dirs, files in os.walk(path):
            if name in files:
                return os.path.join(root,name)

    def FixIOCellHighZ(self,gen_dir:str): #✓
        # ASAP7 don't have tri-state or transmission gate.
        # Change 1'bz to 1'b0
        IO_cell_file = 'IOCell.v'
        file = os.path.join(gen_dir,'gen-collateral',IO_cell_file)
        with open(file, 'r+') as fp:
            content = fp.readlines()

            for i in range(len(content)):
                if '1\'bz' in content[i]:
                    content[i] = content[i].replace('1\'bz', '1\'b0')

            fp.seek(0)
            fp.write( ''.join(content) )

    def GetMaxThreads(self) -> int: #✓
        return self._threads_per_process

    def GetMaxThreadsFromConfYaml(self, file_path):
        with open(file_path,'r') as fin:
            for line in fin:
                if "max_threads" in line and not '#' in line:
                    line=line.split()
                    self._threads_per_process=int(line[-1])
                    break 

    def GetLatestLogPath(self, create_new:bool = True) -> str: #*  Not used
        latest_log = ''
        for i in range(30):
            if os.path.exists('{}{}'.format(self._interface_test_log, i)):
                if create_new:
                    latest_log = '{}{}'.format(self._interface_test_log, i+1)
                else:
                    latest_log = '{}{}'.format(self._interface_test_log, i)
                break
        if 29==i and '' == latest_log:
            latest_log = '{}{}'.format(self._interface_test_log, 0)

        return latest_log

    def LoadVarInfo(self): #✓
        if os.path.exists(self.interface.var_bound_file):
            self.var_info = self.interface.ReadVarInfoFromYml(self.interface.var_bound_file)
            for i in range(len(self.interface.domain_list)):
                self.interface.domain_list[i]['para num'] = self.var_info['var_dim_each_step'][i]
        else:
            self.var_info = self.interface.WriteVarInfoToYml(self.interface.var_bound_file)
            for key in self.var_info.keys():
                if np.ndarray != type(self.var_info[key]):
                    self.var_info[key] = np.array(self.var_info[key])

    def MoveReportsAway(self, run_dir):
        cwd = os.getcwd()
        os.chdir(run_dir)
        # Default reports folder
        old_dir = 'reports'
        new_dir = 'reports_backup'
        if os.path.exists(new_dir):
            shutil.rmtree(new_dir)
        os.rename(old_dir, new_dir)
        os.chdir(cwd)

    def OccupyProcessID(self): #✓
        self.interface.process_ID = self.acquired_process
        self.working_dir = self.interface.SubstituteArgs(self.working_dir)
        self.config_name = self.interface.SubstituteArgs(self.config_name)
    
    def ParallelSimulation(self,failed_sim=[]): #✓
        shell_to_run = mp.Queue()
        sim_sub_procs = []

        sim_shell_part = 'make run-binary CONFIG={config} sim_dir={working_dir}'.format(
            working_dir = self.working_dir,
            config = self.config_name
        )
        
        binary_list = self.interface.setting_root['sim']['benchmark_bin']
        if failed_sim:
            tmp_list = []
            for fs in failed_sim:
                for sim_bin in binary_list:
                    if fs in sim_bin:
                        tmp_list.append(sim_bin)
            binary_list = tmp_list

        # self.WriteTestLog(self._hammer_test_log, 'Make Shell:')
        for sim_bin in binary_list:
            make_shell = 'cd {}; {} BINARY={}'.format(self._verilator_make_dir, sim_shell_part, sim_bin)
            shell_to_run.put(make_shell)
            # self.WriteTestLog(self._hammer_test_log, make_shell)

        n_proc = self._threads_per_process if self._threads_per_process <= shell_to_run.qsize() else shell_to_run.qsize()
        for i in range(n_proc):
            sub_p = mp.Process(target=RunShellSingle, args=(shell_to_run,))
            sim_sub_procs.append(sub_p)
            sub_p.start()
        
        for sub_p in sim_sub_procs:
            sub_p.join()

    def ReleaseProcessID(self): #✓
        pass

    def RunOneStepForTest(self, feature_vector:np.ndarray, step:str): #✓
        self.OccupyProcessID(); 
        self.LoadVarInfo()
        scripts_for_all,_ = self.interface.FeatureVec2ScriptsForAll(feature_vector)
        latest_log = self._hammer_test_log
        make_dir = self._verilator_make_dir
        # make -s > /dev/null
        # cd '{}/vm/shared/workspace/chipyard0/sims/verilator'
        # make CONFIG= sim_dir=
        make_shell = 'cd {make_dir}; make CONFIG={config} sim_dir={working_dir} -j {n_threads}'.format(
            make_dir=make_dir,
            config=self.config_name,
            working_dir=self.working_dir,
            n_threads=self.GetMaxThreads()
        )
        gen_dir = '{}/generated-src/chipyard.TestHarness.{}'.format(self.working_dir,self.config_name)
        build_dir = '{}/build/chipyard.TestHarness.{}-ChipTop'.format(self.working_dir,self.config_name)

        if 'rtl_gen' == step: #✓
            ClearFile(os.path.join(os.environ['DUMP_DIR'], 'test.log'))
            self.interface.WriteScalaConfigs(scripts_for_all['arch']); 
            
            self.WriteTestLog(latest_log,
                'Step: {0}\nStart building RTL modules.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.\nMake shell: {2}'.format(step, self.acquired_process, make_shell)
            )
            os.system(make_shell)
            self.WriteTestLog(latest_log, 'Complete building RTL modules.')
        
        elif 'create_input' == step: #✓
            self.WriteTestLog(latest_log,
                'Step: {0}\nStart creating input yaml.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.'.format(step, self.acquired_process)
            )
            if not os.path.exists(build_dir):
                os.makedirs(build_dir)
            with open(os.path.join(build_dir,'sram_generator-input.yml'), 'w') as fout:
                fout.write('vlsi.inputs.sram_parameters: \"{}/chipyard.TestHarness.{}.mems.hammer.json\"\n'.format(gen_dir, self.config_name))
                fout.write('vlsi.inputs.sram_parameters_meta: [\"transclude\", \"json2list\"]')

            inputs = {
                'sim.inputs':{
                    'input_files':[
                        '{}/chipyard.TestHarness.{}.top.v'.format(gen_dir,self.config_name),
                        '{}/chipyard.TestHarness.{}.top.mems.v'.format(gen_dir,self.config_name),
                        '{}/EICG_wrapper.v'.format(gen_dir)
                    ],
                    'input_files_meta':"append"
                }, 
                'synthesis.inputs':{
                    'top_module': 'ChipTop',
                    'input_files':[
                        '{}/chipyard.TestHarness.{}.top.v'.format(gen_dir,self.config_name),
                        '{}/chipyard.TestHarness.{}.top.mems.v'.format(gen_dir,self.config_name),
                        '{}/EICG_wrapper.v'.format(gen_dir),
                        '{}/ClockDividerN.sv'.format(gen_dir),
                        '{}/IOCell.v'.format(gen_dir),
                        '{}/plusarg_reader.v'.format(gen_dir),
                    ]
                }
            }
            with open(os.path.join(build_dir, 'inputs.yml'), 'w') as fout:
                yaml.dump(inputs, fout)

            self.WriteTestLog(latest_log, 'Complete creating input yaml.')
        
        elif 'sram_gen' == step: #✓
            gen_dir = '{}/generated-src/chipyard.TestHarness.{}'.format(self.working_dir,self.config_name)
            build_dir = '{}/build/chipyard.TestHarness.{}-ChipTop'.format(self.working_dir,self.config_name)
            # Call sram_generator
            self.base_conf += [
                # os.path.join(self.working_dir, self.interface.attr_cfg),
                os.path.join(build_dir, 'inputs.yml'),
                os.path.join(build_dir, 'sram_generator-input.yml')
            ]

            arg_list = ['-e', self.env_yml]
            for file in self.base_conf:
                arg_list = arg_list + ['-p', file]
            arg_list += [
                '--log', '/dev/null', #We don't need hammer log
                '--obj_dir', gen_dir
            ]
            extra_arg_list = [
                '--output', os.path.join(build_dir,'sram_generator-output.json'),
                'sram_generator'
            ]
            self.WriteTestLog(latest_log,
                'Step: {0}\nCalling SRAM generator.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.\nHammer args: {2}'.format(step, self.acquired_process, ' '.join(arg_list + extra_arg_list))
            )
            # Call Hammer
            try:
                self.main(arg_list + extra_arg_list)
            except SystemExit:
                # Prevent Hammer from calling sys.exit()
                pass
            except Exception as e:
                print(type(e))
                print(e)
                raise NameError('Hammer Error')

            self.SimplifySRAMVerilog( os.path.join(gen_dir,'tech-asap7-cache') )

            # Make again to get simulation binary
            os.system(make_shell)
            self.WriteTestLog(latest_log, 'Complete SRAM generator execution.')
        
        elif 'sim' == step: #✓
            # Make RTL source to generate simulation binary
            os.system(make_shell) 
            self.WriteTestLog(latest_log,
                'Step: {0}\nStart simulation.\nAssigned Process ID: {1}'.format(step, self.acquired_process)
            )
            # RTL Simulation
            self.ParallelSimulation()

            self.WriteTestLog(latest_log, 'Complete simulation.')
        
        elif 'build' == step: #✓
            # Call buildfile
            self.base_conf += [
                # os.path.join(self.working_dir, self.interface.attr_cfg),
                os.path.join(build_dir, 'inputs.yml'),
                os.path.join(build_dir, 'sram_generator-input.yml')
            ]

            arg_list = ['-e', self.env_yml]
            for file in self.base_conf:
                arg_list = arg_list + ['-p', file]
            arg_list += [
                '--log', '/dev/null', #We don't need hammer log
                '--obj_dir', build_dir
            ]
            extra_arg_list = [
                '-p', os.path.join(build_dir,'sram_generator-output.json'),
                'build'
            ]
            self.WriteTestLog(latest_log,
                'Step: {0}\nCalling SRAM generator.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.\nHammer args: {2}'.format(step, self.acquired_process, ' '.join(arg_list + extra_arg_list))
            )
            # Call Hammer
            try:
                self.main(arg_list + extra_arg_list)
            except SystemExit:
                # Prevent Hammer from calling sys.exit()
                pass
            except Exception as e:
                print(type(e))
                print(e)
                raise NameError('Hammer Error')

            self.WriteTestLog(latest_log, 'Complete building hammer.d\n')

        elif 'syn' == step: #✓
            
            self.interface.WriteSynAndParAttrToYml(scripts_for_all['syn'], scripts_for_all['par'])
            self.FixIOCellHighZ(gen_dir)
            self.base_conf += [
                os.path.join(self.working_dir, self.interface.attr_cfg),
                os.path.join(build_dir, 'inputs.yml'),
                os.path.join(build_dir, 'sram_generator-input.yml')
            ]

            arg_list = ['-e', self.env_yml]
            for file in self.base_conf:
                arg_list = arg_list + ['-p', file]
            arg_list += [
                '--log', '/dev/null', #We don't need hammer log
                '--obj_dir', build_dir
            ]
            extra_arg_list = [
                '-p', os.path.join(build_dir,'sram_generator-output.json'),
                '--output', '{}/syn-rundir/syn-output.json'.format(build_dir), 
                'syn']
            self.WriteTestLog(latest_log,
                'Step: {0}\nStart logic synthesis.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.\nHammer arguments: {2} syn'.format(step, self.acquired_process, ' '.join(arg_list))
            )
            # Call Hammer for Logic Synthesis
            try:
                self.main(arg_list + extra_arg_list)
            except SystemExit:
                # Prevent Hammer from calling sys.exit()
                pass
            except Exception as e:
                print(type(e))
                print(e)
                raise NameError('Hammer Error')

            self.WriteTestLog(latest_log, 'Complete logic synthesis.\n')

        elif 'place_sram' == step: #✓
            self.WriteTestLog(latest_log,
                'Step: {0}\nStart placing SRAMs.\nAssigned Process ID: {1}\n'.format(step, self.acquired_process)
            )
            self.WriteFloorplan(verbose=True)
            self.WriteTestLog(latest_log, 'Placed SRAMs.\n')
        
        elif 'syn_to_par' == step: #✓
            arg_list = [
                '-e', self.env_yml,
                '-p', '{build_dir}/syn-rundir/syn-output-full.json'.format(build_dir=build_dir),
                '-o', '{build_dir}/par-input.json'.format(build_dir=build_dir),
                '--log', '/dev/null',
                '--obj_dir', build_dir
            ]
            
            self.WriteTestLog(latest_log,
                'Step: {0}\nStart placement preparation.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.\nHammer arguments: {2} syn-to-par'.format(step, self.acquired_process, ' '.join(arg_list))
            )
            # Call Hammer 
            try:
                self.main(arg_list + ['syn-to-par'])
            except SystemExit:
                # Prevent Hammer from calling sys.exit()
                pass
            except Exception as e:
                print(type(e))
                print(e)
                raise NameError('Hammer Error')

            self.WriteTestLog(latest_log, 'Complete placement preparation.\n')

        elif 'par' == step: #✓
            self.interface.WriteSynAndParAttrToYml(scripts_for_all['syn'], scripts_for_all['par'])
            self.base_conf += [
                os.path.join(self.working_dir, self.interface.attr_cfg),
                os.path.join(build_dir, 'inputs.yml'),
                os.path.join(build_dir, 'sram_generator-input.yml')
            ]

            arg_list = ['-e', self.env_yml]
            for file in self.base_conf:
                arg_list = arg_list + ['-p', file]
            arg_list += [
                '--log', '/dev/null', #We don't need hammer log
                '--obj_dir', build_dir
            ]
            extra_arg_list = ['-p', '{}/par-input.json'.format(build_dir), 'par']

            self.WriteTestLog(latest_log,
                'Step: {0}\nStart placement & routing.\nAssigned Process ID: {1}\nGenerated scripts from feature vector.\nHammer arguments: {2} par'.format(step, self.acquired_process, ' '.join(arg_list))
            )
            # Call Hammer for Placement & Routing
            try:
                self.main(arg_list + extra_arg_list)
            except SystemExit:
                # Prevent Hammer from calling sys.exit()
                pass
            except Exception as e:
                print(type(e))
                print(e)
                raise NameError('Hammer Error')

            self.WriteTestLog(latest_log, 'Complete placement & routing.\n')
        
        elif 'get_loss' == step: #✓
            self.WriteTestLog(latest_log, 'Extract metrics and calculate loss.')
            result = self.interface.ExtractValue()
            loss = self.interface.LossFunc(result) 
            self.WriteTestLog(latest_log, 'Complete placement & routing. \nLayout metrics: {}\nLoss is {}.'.format(result, loss))

            self.interface.WriteDataToCSV(feature_vector, result, loss, self.var_info['var_type']) 
            self.WriteTestLog(latest_log, 'Write data to .csv.\n')
        else:
            pass
        previous_process_ID = self.acquired_process
        self.ReleaseProcessID()
        self.WriteTestLog(latest_log, 'Process {} released'.format(previous_process_ID))

    def SimplifySRAMVerilog(self, sram_v_dir:str): #✓
        # Get SRAM Verilog list
        sram_v = os.listdir(sram_v_dir)

        for verilog in sram_v:
            if '.v' not in verilog:
                continue
            line=[]
            with open(os.path.join(sram_v_dir, verilog), 'r+') as fp:
                line = fp.readlines()
                l_begin = line.index('specify\n')
                l_end = line.index('endspecify\n')
                del line[l_begin:l_end+1]

                fp.seek(0)
                fp.truncate()
                fp.write(''.join(line))

    def SimulatorBinaryExist(self):
        sim_exist = False
        for i in os.listdir(self.working_dir):
            if 'simulator' in i:
                sim_exist = True
                break
        return sim_exist

    def WriteFloorplan(self,verbose:bool=False): #✓
        config = self.config_name
        sram_list = '{}/build/chipyard.TestHarness.{}-ChipTop/syn-rundir/sram_list.txt'.format(
            self.working_dir, 
            self.config_name
            )
        mem_v = '{0}/generated-src/chipyard.TestHarness.{1}/chipyard.TestHarness.{1}.top.mems.v'.format(
            self.working_dir, 
            self.config_name
            )
        yaml_file = os.path.join(self.working_dir, self._sram_place_file)

        lef_dir = '{}/technology/asap7/sram_compiler/memories/lef'.format(os.environ['hammer_vlsi'])

        sp = sram_placer.SRAM_PLACER([
            'sram_placer.py',
            '-s', sram_list,
            '-m', mem_v,
            '-y', yaml_file,
            '-c', config,
            '-lef', lef_dir
        ])
        if verbose:
            sp.set_test_mode()

        json_file = '{}/build/chipyard.TestHarness.{}-ChipTop/syn-rundir/syn-output-full.json'.format(
            self.working_dir, 
            self.config_name
            )
        sp.run_placer(for_opt = True,json_file=json_file)
        sp.unset_test_mode()

        # There will be no floorplan.tcl because the floorplan is written to par-output.json
        # move_shell = 'mv {0} {1}/build/chipyard.TestHarness.{2}-ChipTop'.format(sp.base.floorplan_tcl, self.working_dir, config)
        # os.system(move_shell)
        # shutil.move(sp.base.floorplan_tcl, '{}/build/chipyard.TestHarness.{}-ChipTop'.format(self.working_dir, config))

    def WriteExtraConfigs(self): #*
        with open(self._extra_config_file, 'w') as fout:
            fout.write('par.innovus.generate_only: false')

    def WriteTestLog(self, latest_log:str, line:str): #*
        with open(latest_log, 'a') as fout:
            fcntl.flock(fout, fcntl.LOCK_EX)
            fout.write(line+'\n')
            fcntl.flock(fout, fcntl.LOCK_UN)
####################################################################
#                                                                  #
####################################################################
def ObjFunc(feature_vector) -> float: #*
    # Convert feature vector to numpy.ndarray
    if type(feature_vector) != np.ndarray:
        feature_vector = np.array(feature_vector)
    
    shape = feature_vector.shape
    if len(shape) > 1:
        feature_vector = feature_vector.flatten()

    home = os.path.expanduser('~')
    opt_obj = VLSI_Observer(
        # setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting0.yml'.format(home),
        setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting_a.yml'.format(home),
        # env_yml = '{}/workspace/rv-opt-tsmc/yaml/env.yml'.format(home),
        env_yml = '{}/workspace/rv-opt-tsmc/yaml/env_a.yml'.format(home),
        base_conf = [
            # '{}/workspace/rv-opt-tsmc/yaml/tools.yml'.format(home),
            '{}/workspace/rv-opt-tsmc/yaml/tools_a.yml'.format(home),
            # '{}/workspace/rv-opt-tsmc/yaml/common.yml'.format(home)
            '{}/workspace/rv-opt-tsmc/yaml/common_a.yml'.format(home)
        ]
    )
    opt_obj.LoadVarInfo()
    loss,_ = opt_obj.interface.SampledAlready( feature_vector, opt_obj.var_info['var_type'] )

    # loss is -1 if feature vector is not sampled
    if loss >= 0:
        return loss
    
    loss = opt_obj(feature_vector)
    return loss

def TestFunc_1(): #✓
    ClearProcessStatus()
    ClearFile() # Default is var_info.yml
    ClearFile(os.path.join(os.environ['DUMP_DIR'], 'time.log'))
    ClearFile(os.path.join(os.environ['DUMP_DIR'], 'test.log'))    
    home = os.path.expanduser('~')
    opt_obj = VLSI_Observer(
        setting_file = '{}/vm/shared/workspace/rv-opt-tsmc/yaml/setting0.yml'.format(home),
        # setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting_a.yml'.format(home),
        env_yml = '{}/vm/shared/workspace/rv-opt-tsmc/yaml/env.yml'.format(home),
        # env_yml = '{}/workspace/rv-opt-tsmc/yaml/env_a.yml'.format(home),
        base_conf = [
            '{}/vm/shared/workspace/rv-opt-tsmc/yaml/tools.yml'.format(home),
            # '{}/workspace/rv-opt-tsmc/yaml/tools_a.yml'.format(home),
            '{}/vm/shared/workspace/rv-opt-tsmc/yaml/common.yml'.format(home)
            # '{}/workspace/rv-opt-tsmc/yaml/common_a.yml'.format(home)
        ]
    ) 
    gen_dir = '{}/p0/generated-src/chipyard.TestHarness.{}'.format(os.environ['DUMP_DIR'],'OptBoomConfig0')
    # opt_obj.FixIOCellHighZ(gen_dir)
    
    RecordTime('@[rtl_gen] Start')
    opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'rtl_gen')
    RecordTime('@[rtl_gen] End')
    
    RecordTime('@[create_input] Start')
    opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'create_input')
    RecordTime('@[create_input] End')
    
    RecordTime('@[sram_gen] Start')
    opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'sram_gen')
    RecordTime('@[sram_gen] End')
    
    # RecordTime('@[sim] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'sim')
    # RecordTime('@[sim] End')
    
    # RecordTime('@[build] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'build')
    # RecordTime('@[build] End')
    
    # RecordTime('@[synthesis] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'syn')
    # RecordTime('@[synthesis] End')
    
    # RecordTime('@[place_sram] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'place_sram')
    # RecordTime('@[place_sram] End')
    
    # RecordTime('@[syn_to_par] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'syn_to_par')
    # RecordTime('@[syn_to_par] End')
    
    # RecordTime('@[par] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'par')
    # RecordTime('@[par] End')
    
    # RecordTime('@[get_loss] Start')
    # opt_obj.RunOneStepForTest(feature_vector = feature_vector_for_test, step = 'get_loss')
    # RecordTime('@[get_loss] End')


    # return

def TestFunc_2(i_fv):
    #ClearProcessStatus()
    fv = np.array([[1,0,2,0,0,1,1,3,0,4,1,0,1,2,1,0,1,0,0,1,2,1,1,1,1,1,1,2,2,1,1,1,1,0,0,0,1,1,1,2,1,1,2,1,266,0,20,0,0,0,1,486,301],[1,0,2,0,1,1,1,1,0,4,2,0,1,2,1,0,1,0,0,1,1,1,1,1,1,1,1,2,2,1,1,1,1,0,0,0,1,1,1,1,1,2,1,0,266,0,56,1,1,0,1,70,596],[1,0,3,0,0,1,1,2,0,2,1,0,1,2,0,0,2,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,2,0,2,1,1,2,0,0,266,0,21,1,1,0,1,70,254],[1,0,3,0,0,1,1,1,0,2,1,0,1,2,1,2,2,0,0,1,1,1,1,1,1,1,1,2,2,1,1,1,1,1,0,0,2,0,1,1,1,2,1,0,266,0,20,1,1,0,1,70,301],[1,0,4,0,0,2,1,0,0,1,1,0,1,2,0,0,2,0,1,2,1,1,0,1,1,1,1,2,0,1,0,1,1,1,0,0,2,1,1,1,1,2,1,0,355,0,20,1,1,0,1,70,301],[0,0,3,0,0,1,1,1,0,1,1,0,1,2,0,0,2,0,0,1,1,1,1,1,1,1,1,2,2,1,1,1,1,2,0,0,1,1,0,1,1,2,1,0,161,0,18,1,1,0,1,70,301],[1,0,3,1,0,1,1,0,0,1,1,0,1,2,0,0,2,1,0,1,1,1,1,1,1,1,0,1,2,1,1,1,1,1,0,0,2,1,1,1,1,2,1,1,266,0,20,1,1,0,1,402,301],[1,0,3,0,0,1,1,1,0,1,1,0,0,1,0,0,2,0,0,1,2,2,1,0,2,1,1,1,2,1,1,1,1,1,0,0,2,1,1,1,1,1,1,0,266,0,35,0,1,0,1,70,779],[1,0,3,0,0,1,1,1,0,1,1,1,1,1,0,0,2,0,0,2,1,2,1,1,2,1,1,1,1,1,1,1,1,1,0,0,2,1,1,1,0,2,1,0,266,0,35,1,1,0,1,70,567],[1,0,4,0,1,1,1,2,0,2,1,0,1,1,0,0,1,1,0,1,1,2,1,1,2,1,1,1,2,1,1,1,0,1,0,0,2,1,1,1,1,2,1,0,266,0,35,0,0,0,1,70,400],[0,1,1,0,0,1,1,1,0,2,1,0,1,1,1,0,0,0,0,1,1,1,1,0,1,1,0,1,1,1,1,1,1,1,0,0,1,1,2,2,1,2,1,1,295,0,28,0,1,1,1,570,932],[0,1,1,0,0,1,2,1,0,2,0,0,1,1,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,1,1,1,1,1,0,0,1,0,1,2,1,2,1,1,268,0,38,0,2,1,0,570,932],[0,1,1,0,0,1,1,0,0,1,1,0,1,1,1,0,1,0,0,1,0,1,1,0,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,2,1,2,0,1,260,0,37,0,1,1,0,570,689],[0,1,1,0,0,1,1,1,0,1,1,0,1,2,1,0,0,0,0,1,1,1,1,0,1,1,0,1,0,1,1,1,1,1,0,1,1,0,1,2,1,2,0,1,422,0,28,1,2,0,0,570,932],[0,1,1,0,0,1,1,1,0,2,1,0,1,1,1,0,0,0,0,1,0,1,1,0,2,1,0,1,1,1,0,1,0,1,0,1,1,1,1,2,1,2,0,1,268,0,28,0,2,1,0,570,921],[0,1,1,0,0,1,1,1,0,3,1,0,1,1,1,0,0,0,1,1,0,1,1,0,1,1,0,1,0,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,446,0,28,1,2,1,0,570,932],[0,1,1,0,0,2,1,1,0,2,2,0,1,1,1,0,0,0,0,1,0,1,1,0,1,1,0,1,0,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,268,0,28,1,2,1,0,570,598],[0,1,1,0,0,1,0,1,0,2,1,0,1,1,0,0,1,0,1,1,0,1,1,0,1,1,0,1,0,1,1,1,1,1,0,1,2,1,1,2,2,2,0,1,268,0,28,0,1,1,1,570,654],[0,1,0,0,1,1,0,1,0,2,1,0,1,1,1,0,0,0,0,1,0,1,1,0,2,0,0,1,0,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,376,0,28,1,1,1,0,570,932],[0,1,1,1,0,1,0,1,0,2,1,0,1,2,1,0,0,0,0,1,0,0,1,0,2,0,0,1,1,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,224,0,13,0,1,1,0,570,932],[0,1,1,0,0,0,1,1,0,1,1,0,1,2,1,0,0,0,0,1,0,1,0,0,2,1,0,1,0,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,395,0,35,1,2,0,2,570,677],[0,1,2,0,0,1,1,1,0,2,1,0,1,1,1,0,0,0,0,1,0,1,1,0,1,1,1,1,0,1,0,1,1,1,0,0,1,1,1,2,1,2,0,1,325,0,28,0,1,0,0,357,932],[0,1,1,0,1,1,1,1,0,2,1,0,1,1,1,0,0,0,0,1,0,0,0,0,2,1,0,1,0,1,1,1,0,1,0,1,1,1,2,2,1,2,0,1,268,0,28,0,2,1,3,448,932],[0,1,0,0,0,1,0,2,0,3,1,0,1,1,1,0,0,0,0,1,0,0,1,0,1,0,0,2,0,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,268,0,49,0,2,1,0,102,597],[0,1,1,0,0,1,1,1,0,3,1,0,1,1,1,0,0,0,0,1,0,0,1,0,1,1,0,1,0,1,1,1,1,0,0,1,1,1,2,2,1,2,0,1,337,0,28,1,2,0,3,570,803],[0,1,1,1,0,2,1,1,0,2,1,0,1,2,1,0,0,0,0,1,0,1,1,0,1,1,0,1,1,1,1,1,1,1,0,1,1,1,1,2,1,2,0,1,461,0,25,0,1,1,0,570,888],[0,1,2,0,0,1,1,1,0,2,1,0,1,1,1,0,0,0,0,0,0,0,1,0,1,1,0,1,0,1,1,1,0,0,0,1,1,1,1,2,1,2,0,1,268,0,43,1,1,1,1,266,932],[2,0,2,0,0,1,1,4,1,0,0,0,1,1,0,0,1,2,2,2,1,1,1,0,2,0,1,2,1,1,1,1,1,0,1,0,1,1,1,0,1,2,2,1,198,0,25,0,1,1,6,1301,257],[1,1,2,2,1,0,0,3,1,0,1,0,1,0,2,3,2,1,0,2,0,2,1,0,0,0,1,2,2,1,0,1,0,2,1,0,0,0,0,2,1,0,1,0,381,0,25,1,2,1,3,413,81],[1,1,0,0,1,0,3,0,1,2,2,1,1,1,1,2,2,2,1,2,2,0,1,0,0,0,1,2,1,0,1,0,1,1,1,0,1,1,0,2,2,1,2,0,204,0,9,1,2,1,2,569,901]])
    fv = fv[i_fv]
    fv = fv.flatten()

    # home = "/export/home/yyzhao/vm/shared"
    home = "/export/home/yyzhao/vm/shared"
    opt_obj = VLSI_Observer(
        # setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting0.yml'.format(home),
        setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting_a.yml'.format(home),
        # env_yml = '{}/workspace/rv-opt-tsmc/yaml/env.yml'.format(home),
        env_yml = '{}/workspace/rv-opt-tsmc/yaml/env_a.yml'.format(home),
        base_conf = [
            # '{}/workspace/rv-opt-tsmc/yaml/tools.yml'.format(home),
            '{}/workspace/rv-opt-tsmc/yaml/tools_a.yml'.format(home),
            # '{}/workspace/rv-opt-tsmc/yaml/common.yml'.format(home)
            '{}/workspace/rv-opt-tsmc/yaml/common_a.yml'.format(home)
        ],
        my_id=i_fv
    ) 
    opt_obj.LoadVarInfo()
    opt_obj.test_call = False #!!! Take care of this
    # x = feature_vector_for_test #!!! Take care of this
    x = fv
    #!!!
    RecordTime('{}: --Run VLSI flow:'.format(i_fv))
    #RecordTime('{}: --Start VLSI flow before sim:'.format(i_fv))
    loss, result = opt_obj(x) # This one works
    RecordTime('{}: --Get Loss={} Reusult={}'.format(i_fv,loss, result))
    #RecordTime('{}: --end VLSI flow before sim:'.format(i_fv))

def TestFunc_3(i_fv):
    fv = np.loadtxt(str(i_fv)+".input")
    fv = fv.flatten()

    # home = "/export/home/yyzhao/vm/shared"
    home = "/export/home/yyzhao/vm/shared"
    opt_obj = VLSI_Observer(
        setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting0.yml'.format(home),
        # setting_file = '{}/workspace/rv-opt-tsmc/yaml/setting_a.yml'.format(home),
        env_yml = '{}/workspace/rv-opt-tsmc/yaml/env.yml'.format(home),
        # env_yml = '{}/workspace/rv-opt-tsmc/yaml/env_a.yml'.format(home),
        base_conf = [
            '{}/workspace/rv-opt-tsmc/yaml/tools.yml'.format(home),
            # '{}/workspace/rv-opt-tsmc/yaml/tools_a.yml'.format(home),
            '{}/workspace/rv-opt-tsmc/yaml/common.yml'.format(home)
            # '{}/workspace/rv-opt-tsmc/yaml/common_a.yml'.format(home)
        ],
        my_id=i_fv
    ) 
    opt_obj.LoadVarInfo()
    opt_obj.test_call = False
    x = fv
    RecordTime('{}: --Run VLSI flow:'.format(i_fv))
    loss, result = opt_obj(x) # This one works
    RecordTime('{}: --Get Loss={} Result={}'.format(i_fv,loss, result))
    list_result = list(result.values())
    list_result.append(loss)
    np.savetxt(str(i_fv)+".output", list_result)

if __name__ == "__main__":
    # TestFunc_1()
    my_id = sys.argv[1]
    print(int(my_id))
    TestFunc_3(int(my_id))
    # x=feature_vector_for_test
    # y=ObjFunc(x)
    exit()
