# --------------------------------------------------------------------------------
# This script was written and developed by HAMMER at UC Berkeley; however, the
# underlying commands and reports are copyrighted by Cadence. We thank Cadence for
# granting permission to share our research to help promote and foster the next
# generation of innovators.
# --------------------------------------------------------------------------------

puts "set_db design_process_node 28" 
set_db design_process_node 28
puts "set_multi_cpu_usage -local_cpu 28" 
set_multi_cpu_usage -local_cpu 28
puts "set_db timing_analysis_cppr both" 
set_db timing_analysis_cppr both
puts "set_db timing_analysis_type ocv" 
set_db timing_analysis_type ocv
puts "set_library_unit -time 1ps" 
set_library_unit -time 1ps

puts "read_physical -lef { /library/tsml28/digital/tsmcn28_10lm5X2Y2ZRDL.lef /library/tsml28/digital/Back_End/lef/tcbn28hpcplusbwp35p140hvt_110a/lef/tcbn28hpcplusbwp35p140hvt.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x12m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x12m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x22m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x22m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x12m4swbso_170a/LEF/ts1n28hpcpuhdhvtb256x12m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x50m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x50m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x26m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x26m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x59m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x59m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x20m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x20m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x64m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x64m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb512x12m4swbso_170a/LEF/ts1n28hpcpuhdhvtb512x12m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x64m4swbso_170a/LEF/ts1n28hpcpuhdhvtb256x64m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x20m4swbso_170a/LEF/ts1n28hpcpuhdhvtb64x20m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x72m4swbso_170a/LEF/ts1n28hpcpuhdhvtb64x72m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x61m4swbso_170a/LEF/ts1n28hpcpuhdhvtb64x61m4swbso_170a.lef /library/sram/DualPort/tsdn28hpcpuhdb32x33m4mwa_170a/LEF/tsdn28hpcpuhdb32x33m4mwa_170a.lef }" 
read_physical -lef { /library/tsml28/digital/tsmcn28_10lm5X2Y2ZRDL.lef /library/tsml28/digital/Back_End/lef/tcbn28hpcplusbwp35p140hvt_110a/lef/tcbn28hpcplusbwp35p140hvt.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x12m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x12m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x22m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x22m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x12m4swbso_170a/LEF/ts1n28hpcpuhdhvtb256x12m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x50m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x50m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x26m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x26m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x59m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x59m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x20m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x20m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x64m4swbso_170a/LEF/ts1n28hpcpuhdhvtb128x64m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb512x12m4swbso_170a/LEF/ts1n28hpcpuhdhvtb512x12m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x64m4swbso_170a/LEF/ts1n28hpcpuhdhvtb256x64m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x20m4swbso_170a/LEF/ts1n28hpcpuhdhvtb64x20m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x72m4swbso_170a/LEF/ts1n28hpcpuhdhvtb64x72m4swbso_170a.lef /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x61m4swbso_170a/LEF/ts1n28hpcpuhdhvtb64x61m4swbso_170a.lef /library/sram/DualPort/tsdn28hpcpuhdb32x33m4mwa_170a/LEF/tsdn28hpcpuhdb32x33m4mwa_170a.lef }

puts "read_mmmc /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/mmmc.tcl" 
read_mmmc /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/mmmc.tcl

puts "read_netlist { /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/syn-rundir/ChipTop.mapped.v } -top ChipTop" 
read_netlist { /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/syn-rundir/ChipTop.mapped.v } -top ChipTop
puts "init_design" 
init_design

puts "read_power_intent -cpf /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/power_spec.cpf" 
read_power_intent -cpf /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/power_spec.cpf
puts "commit_power_intent" 
commit_power_intent
puts "set_db design_flow_effort standard" 
set_db design_flow_effort standard

set_db route_design_bottom_routing_layer 1
set_db route_design_top_routing_layer 10
    
puts "write_db pre_floorplan_design" 
write_db pre_floorplan_design
puts "ln -sfn pre_floorplan_design latest" 
ln -sfn pre_floorplan_design latest

puts "source -echo -verbose /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/floorplan.tcl" 
source -echo -verbose /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/floorplan.tcl

puts "write_db pre_place_tap_cells" 
write_db pre_place_tap_cells
puts "ln -sfn pre_place_tap_cells latest" 
ln -sfn pre_place_tap_cells latest

set_db add_well_taps_cell TAPCELLBWP35P140
add_well_taps -cell_interval 50 -in_row_offset 10.564

puts "write_db pre_power_straps" 
write_db pre_power_straps
puts "ln -sfn pre_power_straps latest" 
ln -sfn pre_power_straps latest

puts "source -echo -verbose /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/power_straps.tcl" 
source -echo -verbose /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/power_straps.tcl

puts "write_db pre_place_pins" 
write_db pre_place_pins
puts "ln -sfn pre_place_pins latest" 
ln -sfn pre_place_pins latest
puts "set_db assign_pins_edit_in_batch true" 
set_db assign_pins_edit_in_batch true
puts "edit_pin -fixed_pin -pin * -hinst ChipTop -pattern fill_optimised -layer { M7 M9 } -side bottom -start { 3200 0 } -end { 0 0 }   " 
edit_pin -fixed_pin -pin * -hinst ChipTop -pattern fill_optimised -layer { M7 M9 } -side bottom -start { 3200 0 } -end { 0 0 }   
puts "set_db assign_pins_edit_in_batch false" 
set_db assign_pins_edit_in_batch false
puts "write_db pre_place_opt_design" 
write_db pre_place_opt_design
puts "ln -sfn pre_place_opt_design latest" 
ln -sfn pre_place_opt_design latest
puts "place_opt_design" 
place_opt_design
puts "write_db pre_clock_tree" 
write_db pre_clock_tree
puts "ln -sfn pre_clock_tree latest" 
ln -sfn pre_clock_tree latest
puts "create_clock_tree_spec" 
create_clock_tree_spec
puts "ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts" 
ccopt_design -hold -report_dir hammer_cts_debug -report_prefix hammer_cts
puts "write_db pre_add_fillers" 
write_db pre_add_fillers
puts "ln -sfn pre_add_fillers latest" 
ln -sfn pre_add_fillers latest
set_db add_fillers_cells "DCAP16BWP35P140HVT DCAP32BWP35P140HVT DCAP4BWP35P140HVT DCAP64BWP35P140HVT DCAP8BWP35P140HVT DCCKBD12BWP35P140HVT DCCKBD16BWP35P140HVT DCCKBD20BWP35P140HVT DCCKBD4BWP35P140HVT DCCKBD8BWP35P140HVT DCCKND12BWP35P140HVT DCCKND16BWP35P140HVT DCCKND20BWP35P140HVT DCCKND4BWP35P140HVT DCCKND8BWP35P140HVT GDCAP10BWP30P140HVT GDCAP12BWP30P140HVT GDCAP2BWP30P140HVT GDCAP3BWP30P140HVT GDCAP4BWP30P140HVT GDCAPBWP30P140HVT OD18DCAP16BWP35P140 OD18DCAP32BWP35P140 OD18DCAP64BWP35P140"
puts "add_fillers" 
add_fillers
set_db add_fillers_cells "FILL16BWP35P140HVT FILL2BWP35P140HVT FILL32BWP35P140HVT FILL3BWP35P140HVT FILL4BWP35P140HVT FILL64BWP35P140HVT FILL8BWP35P140HVT GFILL10BWP30P140HVT GFILL12BWP30P140HVT GFILL2BWP30P140HVT GFILL3BWP30P140HVT GFILL4BWP30P140HVT GFILLBWP30P140HVT"
puts "add_fillers" 
add_fillers
puts "write_db pre_route_design" 
write_db pre_route_design
puts "ln -sfn pre_route_design latest" 
ln -sfn pre_route_design latest
puts "set_db design_express_route true" 
set_db design_express_route true
puts "route_design" 
route_design
puts "write_db pre_opt_design" 
write_db pre_opt_design
puts "ln -sfn pre_opt_design latest" 
ln -sfn pre_opt_design latest
puts "opt_design -post_route -setup -hold -expanded_views" 
opt_design -post_route -setup -hold -expanded_views

puts "write_db pre_write_regs" 
write_db pre_write_regs
puts "ln -sfn pre_write_regs latest" 
ln -sfn pre_write_regs latest

        set write_cells_ir "./find_regs_cells.json"
        set write_cells_ir [open $write_cells_ir "w"]
        puts $write_cells_ir "\["

        set refs [get_db [get_db lib_cells -if .is_sequential==true] .base_name]

        set len [llength $refs]

        for {set i 0} {$i < [llength $refs]} {incr i} {
            if {$i == $len - 1} {
                puts $write_cells_ir "    \"[lindex $refs $i]\""
            } else {
                puts $write_cells_ir "    \"[lindex $refs $i]\","
            }
        }

        puts $write_cells_ir "\]"
        close $write_cells_ir
        set write_regs_ir "./find_regs_paths.json"
        set write_regs_ir [open $write_regs_ir "w"]
        puts $write_regs_ir "\["

        set regs [get_db [get_db [all_registers -edge_triggered -output_pins] -if .direction==out] .name]

        set len [llength $regs]

        for {set i 0} {$i < [llength $regs]} {incr i} {
            #regsub -all {/} [lindex $regs $i] . myreg
            set myreg [lindex $regs $i]
            if {$i == $len - 1} {
                puts $write_regs_ir "    \"$myreg\""
            } else {
                puts $write_regs_ir "    \"$myreg\","
            }
        }

        puts $write_regs_ir "\]"

        close $write_regs_ir
        
puts "write_db pre_write_design" 
write_db pre_write_design
puts "ln -sfn pre_write_design latest" 
ln -sfn pre_write_design latest
puts "write_db ChipTop_FINAL -def -verilog" 
write_db ChipTop_FINAL -def -verilog

puts "set_db write_stream_virtual_connection false" 
set_db write_stream_virtual_connection false
puts "write_netlist /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.lvs.v -top_module_first -top_module ChipTop -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELLBWP35P140 FILL16BWP35P140HVT FILL2BWP35P140HVT FILL32BWP35P140HVT FILL3BWP35P140HVT FILL4BWP35P140HVT FILL64BWP35P140HVT FILL8BWP35P140HVT GFILL10BWP30P140HVT GFILL12BWP30P140HVT GFILL2BWP30P140HVT GFILL3BWP30P140HVT GFILL4BWP30P140HVT GFILLBWP30P140HVT } " 
write_netlist /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.lvs.v -top_module_first -top_module ChipTop -exclude_leaf_cells -phys -flat -exclude_insts_of_cells { TAPCELLBWP35P140 FILL16BWP35P140HVT FILL2BWP35P140HVT FILL32BWP35P140HVT FILL3BWP35P140HVT FILL4BWP35P140HVT FILL64BWP35P140HVT FILL8BWP35P140HVT GFILL10BWP30P140HVT GFILL12BWP30P140HVT GFILL2BWP30P140HVT GFILL3BWP30P140HVT GFILL4BWP30P140HVT GFILLBWP30P140HVT } 
puts "write_netlist /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.sim.v -top_module_first -top_module ChipTop -exclude_leaf_cells -exclude_insts_of_cells { TAPCELLBWP35P140 FILL16BWP35P140HVT FILL2BWP35P140HVT FILL32BWP35P140HVT FILL3BWP35P140HVT FILL4BWP35P140HVT FILL64BWP35P140HVT FILL8BWP35P140HVT GFILL10BWP30P140HVT GFILL12BWP30P140HVT GFILL2BWP30P140HVT GFILL3BWP30P140HVT GFILL4BWP30P140HVT GFILLBWP30P140HVT } " 
write_netlist /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.sim.v -top_module_first -top_module ChipTop -exclude_leaf_cells -exclude_insts_of_cells { TAPCELLBWP35P140 FILL16BWP35P140HVT FILL2BWP35P140HVT FILL32BWP35P140HVT FILL3BWP35P140HVT FILL4BWP35P140HVT FILL64BWP35P140HVT FILL8BWP35P140HVT GFILL10BWP30P140HVT GFILL12BWP30P140HVT GFILL2BWP30P140HVT GFILL3BWP30P140HVT GFILL4BWP30P140HVT GFILLBWP30P140HVT } 

puts "write_stream -mode ALL -map_file /library/tsml28/digital/Back_End/cdk/tcbn28hpcplusbwp35p140hvt_110a/tcbn28hpcplusbwp35p140hvt/tcbn28hpcplusbwp35p140hvt.layermap -uniquify_cell_names -merge { /library/tsml28/digital/Back_End/gds/tcbn28hpcplusbwp35p140hvt_110a/tcbn28hpcplusbwp35p140hvt.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x12m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x12m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x22m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x22m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x12m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb256x12m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x50m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x50m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x26m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x26m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x59m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x59m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x20m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x20m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x64m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x64m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb512x12m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb512x12m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x64m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb256x64m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x20m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb64x20m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x72m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb64x72m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x61m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb64x61m4swbso_170a.gds /library/sram/DualPort/tsdn28hpcpuhdb32x33m4mwa_170a/GDSII/tsdn28hpcpuhdb32x33m4mwa_170a.gds }  /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.gds" 
write_stream -mode ALL -map_file /library/tsml28/digital/Back_End/cdk/tcbn28hpcplusbwp35p140hvt_110a/tcbn28hpcplusbwp35p140hvt/tcbn28hpcplusbwp35p140hvt.layermap -uniquify_cell_names -merge { /library/tsml28/digital/Back_End/gds/tcbn28hpcplusbwp35p140hvt_110a/tcbn28hpcplusbwp35p140hvt.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x12m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x12m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x22m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x22m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x12m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb256x12m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x50m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x50m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x26m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x26m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x59m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x59m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x20m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x20m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb128x64m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb128x64m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb512x12m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb512x12m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb256x64m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb256x64m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x20m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb64x20m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x72m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb64x72m4swbso_170a.gds /library/sram/SinglePort/ts1n28hpcpuhdhvtb64x61m4swbso_170a/GDSII/ts1n28hpcpuhdhvtb64x61m4swbso_170a.gds /library/sram/DualPort/tsdn28hpcpuhdb32x33m4mwa_170a/GDSII/tsdn28hpcpuhdb32x33m4mwa_170a.gds }  /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.gds

puts "write_sdf /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.par.sdf" 
write_sdf /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.par.sdf

puts "set_db extract_rc_coupled true" 
set_db extract_rc_coupled true
puts "extract_rc" 
extract_rc
puts "write_parasitics -spef_file /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.PVT_0P99V_0C.par.spef -rc_corner PVT_0P99V_0C.setup_rc" 
write_parasitics -spef_file /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.PVT_0P99V_0C.par.spef -rc_corner PVT_0P99V_0C.setup_rc
puts "write_parasitics -spef_file /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.PVT_0P77V_0C.par.spef -rc_corner PVT_0P77V_0C.hold_rc" 
write_parasitics -spef_file /dump/p5/build/chipyard.TestHarness.OptBoomL1Config5-ChipTop/par-rundir/ChipTop.PVT_0P77V_0C.par.spef -rc_corner PVT_0P77V_0C.hold_rc

puts "write_db post_scale_final_gds" 
write_db post_scale_final_gds
puts "ln -sfn post_scale_final_gds latest" 
ln -sfn post_scale_final_gds latest
puts "exit" 
exit
