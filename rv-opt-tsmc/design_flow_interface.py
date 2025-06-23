# Version 0.2
# Removed interface of P&R (Innovus) to avoid its internal bugs.
# Final metric analysis includes CPI (RTL), Area, Power and Setup slack. All Read from report files

import numpy as np 
import os,fcntl,shutil,yaml,io
import copy as cp
from typing import List, Union
from datetime import datetime
from lz.reversal import reverse

import yaml_parser

class Design_Flow_Interface(yaml_parser.YAML_Parser):
    # Protected
    # _template_dict_of_result = {'cpi':None, 'power':None, 'area':None, 'setup':None, 'hold':None, 'drc':None}
    _template_dict_of_result = {'power':None, 'area':None, 'setup':None, 'hold':None, 'drc':None}
    # _normalize_factor = {'cpi':1, 'power':1, 'area':1, 'setup':1, 'hold':1, 'drc':1}
    _normalize_factor = {'power':1, 'area':1, 'setup':1, 'hold':1, 'drc':1}
    _global_dataset_file = '{}/vm/shared/workspace/rv-opt-tsmc/boom_opt_data.csv'.format( os.path.expanduser('~') )
    _date_and_time_format = '%Y-%m-%d %H:%M:%S'
    _metric_area_power_drc = None
    _attr_cfg = 'attr.yml'
    _var_bound_file = '{}/vm/shared/workspace/rv-opt-tsmc/var_bound.yml'.format( os.path.expanduser('~') )

    def __init__(self, 
        setting_file:str = "setting.yml", 
        process_ID:int = -1, 
        test_mode:bool = False
    ): #✓
        super().__init__(setting_file,process_ID)
        self.test_mode = test_mode
        self.ExpandSetting()
        # self._normalize_factor['cpi'] = 1/self.setting_root['reference']['cpi']
        self._normalize_factor['power'] = 1/self.setting_root['reference']['power']
        self._normalize_factor['area'] = 1/self.setting_root['reference']['area']
        self._normalize_factor['setup'] = 1
        self._normalize_factor['drc'] = 1/10

    @property
    def attr_cfg(self) -> str: #✓
        return self._attr_cfg

    @property
    def dataset_file(self) -> str:
        return self._global_dataset_file

    @property
    def normalize_factor(self):
        return self._normalize_factor

    @property
    def null_result(self) -> dict: #✓
        result_dict = cp.deepcopy(self._template_dict_of_result)
        del result_dict['hold']
        del result_dict['drc']
        return result_dict
    
    @property
    def random_result(self) -> dict:
        result_dict = cp.deepcopy(self._template_dict_of_result)
        rand_val = np.random.rand( len(result_dict.keys()) )
        i=0
        for key in result_dict.keys():
            result_dict[key] = rand_val[i] * 10
            i+=1
        del result_dict['hold']
        del result_dict['drc']
        return result_dict
    
    @property
    def var_bound_file(self) -> str:
        return self._var_bound_file

    def CheckFailedSim(self) -> list:
        path = self.setting_root['reports']['cpi']
        path = self.SubstituteArgs(path)
        _, failed_sim = self.GetCPIFromLogFiles(path)
        return failed_sim

    def DiscreteVectorEquals(self, int_vec:np.ndarray, float_vec:np.ndarray) -> bool: #✓
        if int_vec.size != float_vec.size:
            raise ValueError('[@py_interface]: Vector \'a\' and \'b\' must have same length, where a = {}, b = {}.'.format(int_vec, float_vec))

        l = len(int_vec)
        i = 0
        no_value_list1 = [43, 45, 47]
        no_value_list2 = [49]
        while i < l:
            if not self.RoundToSameInt(int_vec[i], float_vec[i]):
                return False
            elif i in no_value_list1 and int_vec[i] == 0:
                i += 2
            elif i in no_value_list2 and int_vec[i] == 0:
                i += 3
            else:
                i += 1

        return True

    def ExpandSetting(self): #✓
        # Add 'script_file' under 'arch'
        if 'arch' in self._setting_root.keys():
            self._setting_root['arch']['script_file'] = '{}.scala'.format(self._setting_root['config_name'])

        # Add 'script_file' under 'syn'
        if 'syn' in self._setting_root.keys():
            self._setting_root['syn']['script_file'] = 'syn.tcl'
            
        # Add 'script_file' under 'par'
        if 'par' in self._setting_root.keys():
            self._setting_root['par']['script_file'] = 'par.tcl'

        # Add 'reports' for CPI, power, area, setup, hold and DRC reports
        long_name = 'chipyard.TestHarness.{}'.format(self._setting_root['config_name'])
        self._setting_root['reports'] = {'cpi':'{}/output/{}'.format(self._setting_root['working_dir'], long_name)}
        # Modified for V0.2
        report_dir = '{}/build/{}-ChipTop/syn-rundir/reports'.format(self._setting_root['working_dir'], long_name)
        self._setting_root['reports']['power'] = os.path.join(report_dir, 'power.rpt')
        self._setting_root['reports']['area'] = os.path.join(report_dir, 'area.rpt')
        # self._setting_root['reports']['drc'] = os.path.join(report_dir, 'drc.rpt')
        self._setting_root['reports']['setup'] = os.path.join(report_dir, 'setup.rpt')
        # self._setting_root['reports']['hold'] = os.path.join(report_dir, 'hold.rpt')

    def GetVarInfo(self) -> dict: #✓
        upper_bound, default_vec, var_type = self.GetVarBoundForAll()
        info={
            'upper_bound': upper_bound, 
            'lower_bound':np.zeros(upper_bound.size),
            'default_vec':default_vec, 
            'var_type':var_type,
            'var_dim_each_step':[]}
        for e in self.domain_list:
            info['var_dim_each_step'].append(e['para num'])
            
        return info

    def RoundToSameInt(self, int_num:int, float_num:float) -> bool: #✓
        
        # Check if 2 float numbers are rounded to same integer
        return int_num == self.ToInt(float_num)

    def SampledAlready(self, x_in:np.ndarray, var_type:np.ndarray) -> float: #✓
        # Return loss value if vector is sampled, return -1 otherwise.
        # Var_type:
        # 0 - categorical
        # 1 - discrete
        # 2 - continuous
        feature_vector = cp.deepcopy(x_in)
        X,Y = self.ReadDataFromCSV()
        if (0 != np.where(2 == var_type)[0].size):
            # If there is continuous variables, there must not be same vectors because optimizer will choose different continuous value each iteration.
            return -1

        if (not X.any() or not Y.any()):
            # Also return -1 if cannot read from csv file.
            return -1
        
        for i in range(feature_vector.size):
            feature_vector[i] = self.ToInt(feature_vector[i])

        for i in range(Y.size):
            if self.DiscreteVectorEquals(X[i],feature_vector):
                return Y[i]
                
        return -1

    #========Parsing Reports==========
    def ExtractValue(self) -> dict: #✓
        self._metric_area_power_drc = None

        result = self.null_result
        metrics = list( result.keys() )
        metric_getter = {
            # 'cpi':self.GetCPIFromLogFiles, 
            'power':self.GetPowerFromReport, 
            'area':self.GetAreaFromReport, 
            'setup':self.GetSetupSlackFromReportFile
        }
        metric_value = -1
        for m in metrics:
            if m == 'cpi':
                path = self.setting_root['reports'][m]
                path = self.SubstituteArgs(path)
                metric_value,failed_sim = metric_getter[m](path)
            else:
                path = self.setting_root['reports'][m]
                path = self.SubstituteArgs(path)
                metric_value = metric_getter[m](path)

            result[m] = metric_value

        return result

    def GetAreaFromYmlFile(self,file:str) -> float: #✓
        if None != self._metric_area_power_drc:
            return self._metric_area_power_drc['design.area']

        with open(file, 'r') as fin:
            self._metric_area_power_drc = yaml.safe_load(fin)

        return self._metric_area_power_drc['design.area']

    def GetAreaFromReport(self,file:str,syn_rpt:bool=True) -> float: #✓
        area = '0.0'
        with open(file,'r') as fin:
            if syn_rpt:
                for line in fin:
                    line = line.split()
                    if not line:
                        continue
                    if 'ChipTop' == line[0]:
                        area = line[-1]
                        break
            else:
                for line in fin:
                    line = line.split()
                    if '0' == line[0] and 'ChipTop' == line[1]:
                        area = line[-1]
                        break
        return float(area)

    def GetCPIFromLogFiles(self,dir:str) -> float: #✓
        log_files = []
        for file in os.listdir(dir):
            if file.endswith('.log'):
                # log_files.append(os.path.join(dir,file))
                log_files.append(file)
        
        CPI_measure = []
        failed_sim = []
        for file in log_files:
            mcycle = 0
            minst = 0
            file_path = os.path.join(dir,file)
            with open(file_path, 'r') as fin:
                for line in fin:
                    if 'Error' in line:
                        break
                    elif 'CPI' in line:
                        line=line.split()
                        mcycle=float( line[-2] ) # read CPI to mcycle
                        minst=1.0 # CPI = CPI/1.0
                    elif 'mcycle' in line:
                        line = line.split()
                        mcycle = float(line[2]) #Convert to float
                    elif 'cycles' in line:
                        line = line.split()
                        mcycle = float(line[1])
                    elif 'minstret' in line:
                        line = line.split()
                        minst = float(line[2]) #Convert to float
                    elif 'instructions' in line:
                        line = line.split()
                        minst = float(line[1])
                    else:
                        continue
            try:
                CPI_measure.append(mcycle/minst)
            except ZeroDivisionError:
                file = file.replace('.log','')
                failed_sim.append(file)
        
        return np.mean(CPI_measure), failed_sim

    def GetDRCFromReport(self, file:str) -> int: #*
        drc = '0'
        with open(file,'r') as fin:
            for line in reverse(fin, batch_size=io.DEFAULT_BUFFER_SIZE):
                if 'Total' in line:
                    break
            line = line.split()
            drc = line[-2]
        return int(drc)

    def GetDRCFromYmlFile(self,file:str) -> int: #✓
        # The metric "check.drc" can be found in innovusMetric.json
        if None != self._metric_area_power_drc:
            return self._metric_area_power_drc['check.drc']

        with open(file, 'r') as fin:
            self._metric_area_power_drc = yaml.safe_load(fin)
            
        return self._metric_area_power_drc['check.drc']

    def GetPowerFromReport(self,file:str,syn_rpt:bool=True) -> float: #✓
        internal = 0
        switching = 0
        leakage = 0
        with open(file,'r') as fin:
            if syn_rpt:
                for line in fin:
                    line = line.split()
                    if 2 > len(line):
                        continue
                    if 'Subtotal' == line[0]:
                        leakage = float(line[1]) * 1e3
                        internal = float(line[2]) * 1e3
                        switching = float(line[3]) * 1e3
                        break
                    elif '0' == line[1] and 'ChipTop' == line[0]:
                        leakage = float(line[-3]) * 1e-6
                        switching = float(line[-2]) * 1e-6
                        break
            else:
                for line in fin:
                    if '*' == line[0] or '-' == line[0]:
                        continue
                    if not 'Total' in line:
                        continue
                    if 'Total Power:' in line:
                        break

                    if 'Internal Power:' in line:
                        line = line.split()
                        internal = float(line[-2])
                    elif 'Switching Power:' in line:
                        line = line.split()
                        switching = float(line[-2])
                    elif 'Leakage Power:' in line:
                        line = line.split()
                        leakage = float(line[-2])
            
        return internal + switching + leakage

    def GetPowerFromYmlFile(self,file:str) -> float: #✓
        if None != self._metric_area_power_drc:
            return (self._metric_area_power_drc['power.internal']
                    + self._metric_area_power_drc['power.switching']
                    + self._metric_area_power_drc['power.leakage']
            )

        with open(file, 'r') as fin:
            self._metric_area_power_drc = yaml.safe_load(fin)
            
        return (self._metric_area_power_drc['power.internal']
                    + self._metric_area_power_drc['power.switching']
                    + self._metric_area_power_drc['power.leakage']
            )

    def GetHoldSlackFromReportFile(self,file:str) -> float: #✓
        hold_wns = 0.0
        with open(file, 'r') as fin:
            for line in fin:
                if 'Slack:=' in line:
                    line = line.replace('|','').split()
                    hold_wns = float(line[1])
                    break

        return hold_wns

    def GetSetupSlackFromReportFile(self,file:str,syn_rpt:bool=True) -> float: #✓
        setup_wns = 0.0
        
        with open(file, 'r') as fin:
            if syn_rpt:
                for line in fin:
                    if 'Slack:=' in line:
                        line = line.split()
                        setup_wns = float(line[1])
            else:
                for line in fin:
                    if 'Slack:=' in line:
                        line = line.replace('|','').split()
                        setup_wns = float(line[1])
                        break

        return setup_wns
    
    def SynthesisReportsExists(self) -> bool:
        exists = True
        for m in ['power', 'area', 'setup']:
            path = self.SubstituteArgs( self.setting_root['reports'][m] )
            exists = exists and os.path.exists(path)
        return exists
    #================================

    #========Calculating Loss========
    def HookInverse(self,x:float) -> float: #✓
        a= 1/3; b=5e2; c=20

        x -= c
        y = 1/2 * (a*x + np.sqrt( (a*x)**2 + 4*a/b ))

        return y

    def LossFunc(self,result:dict) -> float: #✓
        norm_met = self.Normalize_Metrics(result)
        
        # Weighted sum of PPA metrics
        loss = np.sum( np.multiply( 
            # [self.setting_root['ppa_weight']['cpi'], self.setting_root['ppa_weight']['power'], self.setting_root['ppa_weight']['area']],
            [self.setting_root['ppa_weight']['power'], self.setting_root['ppa_weight']['area']],
            # [norm_met['cpi'], norm_met['power'], norm_met['area']] 
            [norm_met['power'], norm_met['area']] 
        ))

        # Add constraint violation penalty to loss
        loss += self.HookInverse( -norm_met['setup'] )

        # Add PPA constraints
        for key in self.setting_root['ppa_weight'].keys():
            if 0 < self.setting_root['constraints'][key]:
                loss += self.HookInverse(-(self.setting_root['constraints'][key] - result[key]) * self._normalize_factor[key] )
        return loss

    def Normalize_Metrics(self,result:dict) -> dict: #✓
        # Normalize All metrics
        norm_met = self.null_result
        for key in norm_met.keys():
            norm_met[key] = result[key] * self._normalize_factor[key]
        return norm_met
    #================================

    #========File Read & Write========
    def ClearCSV(self): #✓
        if os.path.exists(self._global_dataset_file):
            os.remove(self._global_dataset_file)

    def CreateDirRecur(self,dir:str): #✓
        # Recursively create the directory if non existent
        if not os.path.exists(dir):
            os.makedirs(dir)        

    def ReadDataFromCSV(self,csv_file = None) -> Union[np.ndarray,np.ndarray]: #✓
        X=np.array([])
        Y=np.array([])
        if not os.path.exists(self._global_dataset_file):
            return X,Y 
            
        data=None
        if not csv_file:
            file = self._global_dataset_file
        else:
            file = csv_file

        with open(file, 'r') as fin:
            fcntl.flock(fin, fcntl.LOCK_EX)
            data = np.loadtxt(fin, delimiter=',',dtype=object)
            fcntl.flock(fin, fcntl.LOCK_UN)
        
        n_metric = len(self._normalize_factor.values()) - 2 # number of metrics (no hold timing and DRC violation during synthesis)
        
        if 1==len(data.shape):
            n_col = data.shape[0]
            X = data[1:n_col-1-n_metric]
            X = X.reshape(1,X.size)
            Y = np.array([data[-1]])
        else:
            n_row = data.shape[0] # number of sample points
            n_col = data.shape[1] # number of columns
            X = data[:, 1:n_col-1-n_metric]
            Y = data[:, -1]
        
        if 2!=len(X.shape) or type(Y)!=np.ndarray:
            raise ValueError('[@py_interface]: Input data X must be 2D array and Y must be 1D array.')

        return X.astype(np.float64), Y.astype(np.float64)

    def ReadVarInfoFromYml(self,file:str) -> dict: #✓
        with open(file, 'r') as fin:
            info = yaml.safe_load(fin)

        for key in info.keys():
            if np.ndarray != type(info[key]):
                info[key] = np.array(info[key])
        return info

    def VerifierExists(self,verifier:str) -> bool: # Not used
        return False

    def WriteScalaConfigs(self,script:List[str]):  #✓
        file_path = os.path.join(
            self.setting_root['config_dir'],
            self.SubstituteArgs(self.setting_root['arch']['script_file'])
        )
        self.CreateDirRecur(self.setting_root['config_dir'])
        with open(file_path,'w') as fout:
            fout.write('\n'.join(script))

    def WriteSynAndParAttrToYml(self, syn_script:List[str], par_script:List[str]):  #✓
        file_path = os.path.join(
            self.SubstituteArgs(self.setting_root['working_dir']),
            self._attr_cfg
        )
        self.CreateDirRecur( self.SubstituteArgs(self.setting_root['working_dir']) )
        dict_to_yml = {
            'synthesis':{
                'genus':{
                    'pre_syn_cmd':syn_script
                }
            },  
            'par':{
                'innovus':{
                    'post_init_cmd':par_script
                }
            }
        }
        with open(file_path,'w') as fout:
            yaml.dump(dict_to_yml,fout)

    def WriteDataToCSV(self, feature_vector:np.ndarray, result:dict, loss:float, var_type:np.ndarray): #✓
        if feature_vector.size != var_type.size:
            raise ValueError('[@py_interface]: Size of feature vector and variable type vector doesn\'t match.')

        line = ''
        for i in range(feature_vector.size):
            if 0==var_type[i] or 1==var_type[i]:
                line += ',{}'.format(self.ToInt(feature_vector[i]))
            else:
                line += ',{}'.format(feature_vector[i])

        for e in (list(result.values()) + [loss]):
            line += ',{}'.format(e)

        current_time = datetime.now().strftime(self._date_and_time_format)
        line = current_time + line

        with open(self._global_dataset_file, 'a') as fout:
            fcntl.flock(fout, fcntl.LOCK_EX)
            fout.write(line +'\n')
            fcntl.flock(fout, fcntl.LOCK_UN)

    def WriteVarInfoToYml(self,file:str) -> dict: #✓
        info = None
        with open(file, 'w') as fout:
            info = self.GetVarInfo()
            for key in info.keys():
                if np.ndarray == type(info[key]):
                    info[key] = info[key].tolist()
            yaml.dump(info,fout)

        return info
    #================================

if __name__ == "__main__":
    # For debugging use
    import random as rnd

    dfi = Design_Flow_Interface(
        setting_file = './yaml/setting.yml',
        process_ID = 4,
        test_mode = False
    )
    
    # print('CPI Ref = {}'.format(1/dfi.normalize_factor['cpi']))
    print('Power Ref = {}'.format(1/dfi.normalize_factor['power']))
    print('Area Ref = {}'.format(1/dfi.normalize_factor['area']))
    print('Setup Ref = {}'.format(1/dfi.normalize_factor['setup']))
    
    # Read full dataset (including time and results)
    with open('InitDataset.csv','r') as fin:
        data = np.loadtxt(fin, delimiter=',',dtype=object)

    # cpi_meas = data[:,-5].astype(np.float64)
    power_meas = data[:,-4].astype(np.float64)
    area_meas = data[:,-3].astype(np.float64)
    setup_meas = data[:,-2].astype(np.float64)

    for i in range(data.shape[0]):
        # result = {'cpi':cpi_meas[i], 'power':power_meas[i], 'area':area_meas[i], 'setup':setup_meas[i]}
        result = {'power':power_meas[i], 'area':area_meas[i], 'setup':setup_meas[i]}
        data[i][-1] = str(dfi.LossFunc(result))

    with open('refined.csv','w') as fout:
        np.savetxt(fout,data,delimiter=',',fmt='%s')
    
    # def print_avg_max(metric, values):
    #     avg = values.mean()
    #     max = values.max()
    #     print('{} -- avg: {}, max: {}'.format(metric, avg, max))

    # print_avg_max('CPI', cpi_meas)
    # print_avg_max('Power', power_meas)
    # print_avg_max('Area', area_meas)
    # print_avg_max('Setup Slack', setup_meas)
    

"""
    print(dfi.HookInverse(-0.89), dfi.HookInverse(2))

    result = {'cpi':rnd.uniform(0.5,2), 'power':rnd.uniform(50,160), 'area':rnd.uniform(4601974.39123,6681747.6265), 'setup':rnd.uniform(-50,200), 'hold':rnd.uniform(-50,200), 'drc':rnd.randint(0,9)}
    loss = dfi.LossFunc(result)
    print(loss)

    var_file = '{}/var_info.yml'.format(os.environ['DUMP_DIR'])
    info_to_write = dfi.WriteVarInfoToYml(var_file)
    info_read_in = dfi.ReadVarInfoFromyml(var_file)
    for key in info_read_in.keys():
        print(key, (info_read_in[key] == info_to_write[key]).all())

    upper_bound, _, _ = dfi.GetVarBoundForAll()
    
    rnd_x = np.multiply(
        upper_bound,
        np.random.rand(upper_bound.size)
    )

    scripts_for_all, _ = dfi.FeatureVec2ScriptsForAll(rnd_x)
    
    dfi.WriteScalaConfigs(scripts_for_all['arch'])
    dfi.WriteSynAndParAttrToYml(syn_script=scripts_for_all['syn'], par_script=scripts_for_all['par'])
    
    dfi.WriteDataToCSV(feature_vector=rnd_x, result=result, loss=loss, var_type = var_type)
    
    result = dfi.ExtractValue()
    print(result)
"""

"""
    dfi.ClearCSV(); X,Y=dfi.ReadDataFromCSV()
    if (not X.any() or not Y.any()):
        print('cannot find csv')
    upper_bound, default_vec, var_type = dfi.GetVarBoundForAll()

    dim = upper_bound.size

    target_vec = np.multiply(upper_bound, np.random.rand(dim))
    print(target_vec); exit()

    test_X = np.vstack((
        np.multiply(upper_bound, np.random.rand(dim)),
        np.multiply(upper_bound, np.random.rand(dim)),
        np.multiply(upper_bound, np.random.rand(dim)),
        default_vec,
        np.multiply(upper_bound, np.random.rand(dim)),
        np.multiply(upper_bound, np.random.rand(dim)),
        np.multiply(upper_bound, np.random.rand(dim)),
        target_vec,
        np.multiply(upper_bound, np.random.rand(dim)),
        np.multiply(upper_bound, np.random.rand(dim))
    ))

    n_samples = test_X.shape[0]

    test_Y = np.random.rand(n_samples)

    for i in range(n_samples):
        dfi.WriteDataToCSV(
            feature_vector = test_X[i],
            result = dfi.random_result,
            loss = test_Y[i],
            var_type = var_type
        )
    # target_vec = [3.19429464e-01,3.35176783e+00,8.53125628e-01,1.88001070e+00,2.85777525e+00,2.93590083e-01,3.54547392e+00,4.17772295e-01,1.45256213e+00,2.75100088e+00,7.36750519e-01,9.09337602e-03,1.48539895e+00,5.94815560e-01,4.35779337e-01,4.21700076e-01,3.93342019e-01,1.23160335e+00,6.33547590e-01,2.88568446e-01,1.85409558e-01,1.69341692e+00,1.92024524e+00,7.12247970e-01,1.83495979e-01,5.45604813e-03,7.71104228e-04,2.85832819e-01,2.96473938e-01,5.75540017e-02,8.51577476e-02,1.87877044e+00,3.72607615e-01,1.28217658e+00,2.04628662e+00,1.72396807e+00,5.83470691e-02,9.00966142e-01,1.34059338e+00,6.06106791e-01,2.33363253e+02,4.76631513e-01,7.52157824e+01,4.75940973e-01,2.02342624e+01,4.96630260e-01,6.48701395e+00,1.31430404e+01,2.24285421e-01,4.59501592e-01,1.42341541e-01,3.72500862e-01,3.56093874e-01,4.11321764e+02,9.48546241e-01,1.51815369e+00,4.83531488e-01,4.87142059e-01,5.16844955e-01,5.62868612e-01,8.48245062e-01,1.77117188e-01,4.61716312e-01,5.64272921e-01,3.23217097e+01,4.41027614e-01,1.57440241e-01,2.59350011e-01,7.05064634e-01,7.74730510e-01,7.11908046e-02,1.61087163e+00,2.57887027e-01,2.74310909e-01,1.05233481e+01,5.08294915e-01,1.26284737e+00,5.62967972e-01,7.12699226e-01,1.07378936e+00,1.83410530e+00,7.08642852e-01,1.35881553e+00,3.48679678e-01,7.10925808e-02,3.67515379e-01]
    # target_vec = np.array(target_vec)
    # print(target_vec)
    loss = dfi.SampledAlready(target_vec,var_type)
    if loss < 0:
        print('target_vec not sampled')
    else:
        print('target_vec sampled, loss={}'.format(loss))

    # print(default_vec)
    loss = dfi.SampledAlready(default_vec,var_type)
    if loss < 0:
        print('default_vec not sampled')
    else:
        print('default_vec sampled, loss={}'.format(loss))

    other_vec = np.multiply(upper_bound, np.random.rand(dim))
    # print(other_vec)
    loss = dfi.SampledAlready(other_vec,var_type)
    if loss < 0:
        print('other_vec not sampled')
    else:
        print('other_vec sampled, loss={}'.format(loss))
"""
