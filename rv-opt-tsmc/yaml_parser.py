import numpy as np 
import os,yaml
import copy as cp
from typing import List, Union
from datetime import datetime
from string import Template

class YAML_Parser: #✓
    # Protected
    _template_dict_of_domain_list_element = {'domain':'', 'info node':None, 'config root':None, 'para num': 0}
    _template_dict_of_scripts = {'arch': '', 'syn': '', 'par': ''}
    _variable_types = {'categorical':0, 'discrete':1, 'continuous':2}
    _var_cons_key_word = ['less_than','no_greater_than','greater_than','no_less_than','divisible_by']
    _setting_and_config_status = '{}/vm/shared/workspace/dump/check.yml'.format( os.path.expanduser('~') )
    _domains = ['arch', 'syn', 'par']
    _process_ID_key = 'PROCESS_ID'
    _process_ID_macro = '${'+_process_ID_key+'}'
    _is_checked = False
    _setting_root = None
    
    def __init__(self, setting_file:str = "setting.yml", process_ID:int = -1): #✓
        self.domain_list = []
        self.num_domain=0
        self.test_mode=True
        self.process_ID = process_ID
        # Load settings
        with open(setting_file, 'r') as fin:
            self._setting_root = yaml.safe_load(fin)
        if not self.checked_already:
            self.CheckSettingTree(node=self._setting_root)
            self._is_checked=True
        # Load config files
        for domain in self._domains:
            if not domain in self._setting_root.keys():
                continue
            
            tmp = cp.deepcopy(self._template_dict_of_domain_list_element)
            tmp['domain'] = domain
            tmp['info node'] = self._setting_root[domain]
            
            with open(tmp['info node']['config_file'], 'r') as fin:
                tmp['config root'] = yaml.safe_load(fin)
            if not domain in tmp['config root'].keys():
                raise ValueError('[@py_interface]: Cannot find configs of domain \"{}\" in file {}. '.format(domain, setting_file))

            tmp['config root'] = tmp['config root'][domain]

            self.domain_list.append(tmp)
        
        self.num_domain = len(self.domain_list)
        self._is_checked=False

        # Check loaded domain count
        if 0==self.num_domain:
            raise ValueError('[@py_interface]: No domain is loaded from {}. '.format(setting_file))
        
        if not self.checked_already:
            for domain in self.domain_list:
                self.CheckConfigTree(node=domain['config root'], domain=domain['domain'])
        
        self._is_checked=True
        if self.checked_already:
            pass
    
    @property
    def checked_already(self) -> bool: #✓
        if os.path.exists(self._setting_and_config_status):
            # breakpoint()
            return True
        elif self._is_checked:
            # breakpoint()
            with open(self._setting_and_config_status, 'w') as fout:
                yaml.dump({'is_checked': True},fout)
            return True
        
        return False

    @property
    def setting_root(self) -> dict: #✓
        return self._setting_root

    def AttrHasVarConstraint(self,attribute:dict) -> bool: #✓
        for key in self._var_cons_key_word:
            if key in attribute.keys():
                return True
        return False

    def CheckConfigTree(self, node, depth:int =0, domain=None): #✓
        # breakpoint()
        if 0==depth:
            key_words = []
            if 'arch' == domain or 'syn' == domain or 'par' == domain:
                key_words = ['root', 'design']
            else:
                raise ValueError('[@py_interface]: No valid definition for domain configs in file \"{}\".'.format(node['info node']['config_file']))
            
            for key in node.keys():
                if not key in key_words:
                    raise ValueError('[@py_interface]: Cannot recognize key word {} in config of domain \"{}\". '.format(key, domain))
                elif not node[key]:
                    raise ValueError('[@py_interface]: The config node under key {} is empty.'.format(key))
                else:
                    self.CheckConfigTree(node[key], 1, domain)
        elif 1==depth:
            # The available attributes must be in a list
            if type(node) != list:
                raise ValueError('[@py_interface]: Invalid data format in domain \"{}\".'.format(domain))
            
            # Check key words
            if 'arch' == domain:
                key_words = ['text', 'module', 'prefix', 'default', 'attribute', 'type', 'value', 'relate_to', 'equal_to', 'reverse_search'] + self._var_cons_key_word
            else:
                key_words = ['attribute', 'type', 'value', 'ignore', 'default', 'text']

            for attr in node:
                for key in attr.keys():
                    if not key in key_words:
                        raise ValueError('[@py_interface]: Cannot recognize key word {} in config of domain \"{}\".'.format(key,domain))
                if 'text' in attr.keys():
                    continue

                if 'module' in attr.keys():
                    if not attr['module']:
                        raise ValueError('[@py_interface]: Module list must not be empty.')
                    else:
                        continue

                if not attr['type'] in self._variable_types.keys():
                    raise ValueError('[@py_interface]: Type \"{}\" is invalid. (attribute: \"{}\")'.format(attr['type'], attr['attribute']))
                if 'discrete' == attr['type'] and 3 != len(attr['value']):
                    raise ValueError('[@py_interface]: Element \"value\" of type \"discrete\" must be list of length 3. (attribute: \"{}\")'.format(attr['attribute']))
                if 'continuous' == attr['type'] and 2 != len(attr['value']):
                    raise ValueError('[@py_interface]: Element \"value\" of type \"continuous\" must be list of length 2. (attribute: \"{}\")'.format(attr['attribute']))
        
    def CheckSettingTree(self, node:dict, depth:int =0): #✓
        if 0==depth:
            key_words = ['working_dir','config_dir','config_name','arch','sim','syn','par','reference','constraints','reports','ppa_weight']
            for key in node.keys():
                if not key in key_words:
                    raise ValueError('[@py_interface]: Cannot recognize key word {} in setting file. '.format(key))
                elif not node[key]:
                    raise ValueError('[@py_interface]: The node under key {} is empty.'.format(key))
                elif not key in ['working_dir','config_dir','config_name']:
                    self.CheckSettingTree(node[key], 1)
        elif 1==depth:
            key_words = ['config_file', 'script_file', 'benchmark_dir', 'benchmark_bin', 'cpi', 'power', 'area', 'cpi_dir', 'setup', 'hold', 'drc']
            if type(node)==list:
                #breakpoint()
                pass
            for key in node.keys():
                if not key in key_words:
                    raise ValueError('[@py_interface]: Cannot recognize key word {} in setting file. '.format(key))

    def FeatureVec2ScriptsForAll(self,feature_vector:np.ndarray) -> Union[dict,list]: #✓
        scripts_for_all = cp.deepcopy(self._template_dict_of_scripts)
        lines_for_test = []; #breakpoint()
        idx = 0
        for domain_node in self.domain_list:
            # breakpoint()
            scripts_for_all[ domain_node['domain']], tmp_l = self.FeatureVec2ScriptsForOneDomain(
                config_root = domain_node['config root'],
                feature_vector = feature_vector[idx : idx+domain_node['para num']],
                domain = domain_node['domain']
            )
            idx += domain_node['para num']
            lines_for_test += tmp_l
        return scripts_for_all,lines_for_test

    def FeatureVec2ScriptsForOneDomain(self,config_root:dict,feature_vector:np.ndarray,domain) -> Union[list,list]: #✓         
        scripts_for_one = []
        lines_for_test = []
        idx=0
        if 'arch' == domain:
            config_space = config_root['root']
            for attr in config_space:
                if 'text' in attr.keys():
                    if self._process_ID_macro in attr['text']:
                        scripts_for_one += [self.SubstituteArgs(attr['text'])]
                    else:
                        scripts_for_one += [attr['text']]
                    continue
                elif 'equal_to' in attr.keys():
                    eq_attr = self.GetAttrValue(attribute = attr['equal_to'], config_space = config_space, feature_vector = feature_vector)
                    scripts_for_one += ['{attribute} = {value},'.format(
                        attribute = attr['attribute'],
                        value = eq_attr)]
                    continue
                elif 'relate_to' in attr.keys():
                    related_attr_idx = self.GetAttrIndex(attribute = attr['relate_to'], config_space = config_space, feature_vector = feature_vector)
                    
                    scripts_for_one += ['{attribute} = {value},'.format(
                        attribute = attr['attribute'],
                        value = attr['value'][related_attr_idx])]
                    continue
                
                if 'module' in attr.keys(): # Use integer encoding for 'module'
                    if 'prefix' in attr.keys():
                        prefix = attr['prefix']
                    else:
                        prefix = ''
                    # n_mod = len(attr['module']) # number of modules
                    # ohc = feature_vector[idx : idx + n_mod] # one-hot code
                    # module = attr['module'][ np.argmax(ohc) ]
                    module_idx = self.ToInt( feature_vector[idx] )
                    module = attr['module'][module_idx]
                    scripts_for_one += ['new {prefix}{module} ++'.format(
                        prefix = prefix,
                        module = module
                    )]
                    # idx += n_mod
                    idx += 1
                    continue
                 
                if 'categorical' == attr['type']:
                    val = attr['value'][ self.ToInt(feature_vector[idx]) ]

                    if self.AttrHasVarConstraint(attr):
                        val_idx = self.FixVarConsViolation(attr,val,config_space,feature_vector)
                        if 0 <= val_idx:
                            val = attr['value'][val_idx]
                            feature_vector[idx] = val_idx
                        #breakpoint()
                    scripts_for_one += ['{attribute} = {value},'.format(
                        attribute = attr['attribute'],
                        value = val )]
                elif 'discrete' == attr['type']:
                    val_begin = attr['value'][0]
                    val_step  = attr['value'][2]
                    val = val_begin + val_step * self.ToInt(feature_vector[idx])

                    if self.AttrHasVarConstraint(attr):
                        val_idx = self.FixVarConsViolation(attr,val,config_space,feature_vector)
                        if 0 <= val_idx:
                            val = val_begin + val_step * val_idx
                            feature_vector[idx] = val_idx
                        #breakpoint()
                    scripts_for_one += ['{attribute} = {value},'.format(
                        attribute = attr['attribute'],
                        value = val)]
                elif 'continuous' == attr['type']:
                    val_begin = attr['value'][0]
                    val = val_begin + feature_vector[idx]
                    scripts_for_one += ['{attribute} = {value},'.format(
                        attribute = attr['attribute'],
                        value = val)]
                idx += 1
                if self.test_mode:
                    lines_for_test.append(scripts_for_one[-1])
        else:
            for key in config_root.keys():
                is_root = key == 'root' or 'par' == domain
                for attr in config_root[key]:
                    if 'text' in attr.keys():
                        scripts_for_one.append(attr['text'])
                        continue

                    if 'ignore' in attr.keys():
                        if 0==self.ToInt(feature_vector[idx]):
                            scripts_for_one += [
                                '# Ignored Attribute:',
                                '# set_db {attribute} NULL'.format(attribute = attr['attribute'])
                            ]
                            idx += 2
                            if self.test_mode:
                                lines_for_test.append('ignore this attribute')
                                lines_for_test.append('null attribute')
                            continue
                        else:
                            scripts_for_one += ['#####']
                            idx += 1
                            if self.test_mode:
                                lines_for_test.append('do not ignore this attribute')

                    if 'categorical' == attr['type']:
                        val = self.ToInt(feature_vector[idx])
                                                
                        scripts_for_one += ['set_db {inst}{attribute} {value}'.format( 
                            attribute = attr['attribute'],
                            value = attr['value'][val],
                            inst = '' if is_root else '[vfind /designs -design ChipTop] .')]
                        
                    elif 'discrete' == attr['type']:
                        val_begin = attr['value'][0]
                        val_step  = attr['value'][2]
                        val = val_begin + val_step * self.ToInt(feature_vector[idx])

                        scripts_for_one += ['set_db {inst}{attribute} {value}'.format( 
                            attribute = attr['attribute'],
                            value = round(val,5),
                            inst = '' if is_root else '[vfind /designs -design ChipTop] .')]
                        
                        # if is_root:
                        #     scripts_for_one += ['set_db {attribute} {value}'.format( 
                        #         attribute = attr['attribute'],
                        #         value = round(val,5)
                        #     )]
                        # else:
                        #     scripts_for_one += ['set_db [vfind /designs -design ChipTop] .{attribute} {value}'.format( 
                        #         attribute = attr['attribute'],
                        #         value = round(val,5)
                        #     )]
                    elif 'continuous' == attr['type']:
                        val_begin = attr['value'][0]
                        val = val_begin + feature_vector[idx]
                        scripts_for_one += ['set_db {inst}{attribute} {value}'.format( 
                            attribute = attr['attribute'],
                            value = val,
                            inst = '' if is_root else '[vfind /designs -design ChipTop] .')]
                    
                    idx += 1
                    
                    if self.test_mode:
                        lines_for_test.append(scripts_for_one[-1])
        # breakpoint()
        return scripts_for_one,lines_for_test
    
    def FixVarConsViolation(self, attribute:dict, value:int, config_space:list, feature_vector:np.ndarray) -> int: #✓
        if 'continuous' == attribute['type']:
            raise ValueError('[@py_interface]: The parser currently do not support constraints on continuous variable.')
        attr_keys = list(attribute.keys())
        # If variable constraint violation exists, try to assign it to last legal value. If failed, raise value error.
        constraints = {}

        for key in self._var_cons_key_word:
            if key in attr_keys:
                constrained_val = self.GetAttrValue(attribute = attribute[key], config_space=config_space, feature_vector=feature_vector)
                # Make sure constrained_val is not a string
                constraints[key] = constrained_val + 0
        if self.ValueMeetsConstraint(constraints,value):
            return -1
            
        if 'categorical' == attribute['type']:
            val_list = attribute['value']
        elif 'discrete' == attribute['type']:
            val_list = attribute['value']
            val_list = list(range(start=val_list[0], stop=val_list[1] + val_list[2], step= val_list[2]))
        
        # return value index instead of value
        idx_range = list( range( len(val_list) ) )

        if 'reverse_search' in attribute.keys():
            if attribute['reverse_search']:
                idx_range.reverse()

        for i in idx_range:
            if self.ValueMeetsConstraint(constraints,val_list[i]):
                break
        
        # return value index
        return i
        
    def GetAttrIndex(self,attribute:str,config_space:list,feature_vector:np.ndarray) -> int: #✓
        idx = 0 
        for e in config_space:
            if 'module' in e.keys():
                idx += 1 #len(e['module'])
                
            if 'attribute' in e.keys() and not 'equal_to' in e.keys() and not 'relate_to' in e.keys():
                if attribute == e['attribute']:
                    if 'continuous' == e['type']:
                        raise ValueError('[@py_interface]: Cannot get value index for continuous attribute. (attribute: \"{}\")'.format(attribute))
                    else:
                        break
                idx += 1
        
        return self.ToInt( feature_vector[idx] )

    def GetAttrValue(self,attribute:str,config_space:list,feature_vector:np.ndarray): #✓
        idx = 0 
        for e in config_space:
            if 'module' in e.keys():
                idx += 1 #len( e['module'] )
            if 'attribute' in e.keys() and not 'equal_to' in e.keys() and not 'relate_to' in e.keys():
                if attribute == e['attribute']:
                    break
                idx += 1
    
        return_val = None

        if 'categorical' == e['type']:
            val_idx = self.ToInt(feature_vector[idx])
            return_val = e['value'][val_idx]
        elif 'discrete' == e['type']:
            val_idx = self.ToInt(feature_vector[idx])
            return_val = e['value'][0] + val_idx * e['value'][2]
        elif 'continuous' == e['type']:
            return_val = feature_vector[idx]
        
        return return_val

    def GetVarBoundForAll(self) -> Union[np.ndarray, np.ndarray, np.ndarray]: #✓
        upper_bound = np.array([])
        default_vec = np.array([])
        var_type = np.array([])
        for domain_node in self.domain_list:
            upper_bound_partial, default_vec_partial, var_type_partial = self.GetVarBoundForOneDomain(domain_node['config root'])

            if not (upper_bound_partial.size == default_vec_partial.size and upper_bound_partial.size == var_type_partial.size):
                raise ValueError('[@py_interface]: Dimensionality of upper bound, default vector and type list does not match. (Domain: \"{}\")'.format(domain_node['info node']['domain']))

            domain_node['para num'] = upper_bound_partial.size
            upper_bound = np.hstack( (upper_bound, upper_bound_partial) )
            default_vec = np.hstack( (default_vec, default_vec_partial) )
            var_type    = np.hstack( (var_type,    var_type_partial) )

        return upper_bound, default_vec, var_type

    def GetVarBoundForOneDomain(self,config_space:dict) -> Union[np.ndarray, np.ndarray, np.ndarray]: #✓
        upper_bound = []
        default_vec = []
        var_type = []
        for attr_type in config_space.keys():
            for attr in config_space[attr_type]:
                if 'text' in attr.keys() or 'equal_to' in attr.keys() or 'relate_to' in attr.keys():
                    continue
                # Add one more dimension for option 'ignore'
                if 'ignore' in attr.keys():
                    upper_bound.append(1)
                    default_vec.append(0)
                    var_type.append(self._variable_types['categorical'])
                
                if 'module' in attr.keys(): # Use one-hot encoding for 'module'
                    # n_mod = len(attr['module']) # number of modules
                    # upper_bound += [1] * n_mod
                    # default_vec += [1] + [0] * (n_mod-1)
                    # var_type += [self._variable_types['categorical'] ] * n_mod
                    upper_bound.append( len(attr['module']) - 1 )
                    var_type.append( self._variable_types['categorical'] ) 
                    if 'default' in attr.keys():
                        for i in range( len(attr['module']) ):
                            if attr['default'] == attr['module'][i]:
                                default_vec.append(i)
                    else:
                        default_vec.append(0)
                    continue

                # Get bound of each dimension
                if 'categorical' == attr['type']:
                    upper_bound.append( len(attr['value']) - 1 )
                    default_vec.append( 0 )
                    var_type.append(self._variable_types['categorical'])
                elif 'discrete' == attr['type']:
                    val_begin = attr['value'][0]
                    val_end = attr['value'][1]
                    val_step = attr['value'][2]
                    upper_bound.append( np.ceil((val_end - val_begin)/val_step) )
                    default_vec.append(0)
                    var_type.append(self._variable_types['discrete'])
                elif 'continuous' == attr['type']:
                    upper_bound.append(attr['value'][1] - attr['value'][0])
                    default_vec.append(0)
                    var_type.append(self._variable_types['continuous'])

                # Reset default value if option 'default' exists
                if 'default' in attr.keys():
                    if 'categorical' == attr['type']:
                        for i in range(len(attr['value'])):
                            if attr['default'] == attr['value'][i]:
                                default_vec[-1] = i
                                break
                    elif 'discrete' == attr['type']:
                        val_begin = attr['value'][0]
                        val_step = attr['value'][2]
                        i = (attr['default'] - val_begin)/val_step
                        default_vec[-1] = i
                    elif 'continuous' == attr['type']:
                        default_vec[-1] = attr['default'] - attr['value'][0]

        return np.array(upper_bound), np.array(default_vec), np.array(var_type)

    def SubstituteArgs(self,original:str) -> str: #✓
        arg_dict = {self._process_ID_key: self.process_ID}
        t = Template(original)
        return t.substitute(arg_dict)

    def ToInt(self,float_in:float) -> int: #✓
        # Round to closest integer
        return int( float_in + 0.5 )

    def ValueMeetsConstraint(self, constraints: dict, value:int) -> bool: #✓
        attr_keys = list(constraints.keys())
        meets_cons = True # Used as a switch of considering constraints or not
        if 'less_than' in attr_keys:
            meets_cons = meets_cons and (value < constraints['less_than'])
        if 'no_greater_than' in attr_keys:
            meets_cons = meets_cons and (value <= constraints['no_greater_than'])
        if 'greater_than' in attr_keys:
            meets_cons = meets_cons and (value > constraints['greater_than'])
        if 'no_less_than' in attr_keys:
            meets_cons = meets_cons and (value >= constraints['no_less_than'])
        if 'divisible_by' in attr_keys:
            meets_cons = meets_cons and (0 == value % self.ToInt(constraints['divisible_by']))
        return meets_cons

feature_vector_for_test = np.array([   
          0.773,    0.721,    0.819,    0.312,    1.774,    3.405,
          2.117,    0.068,    0.528,    2.818,    0.289,    0.178,
          0.637,    1.495,    0.66 ,    0.35 ,    0.058,    1.04 ,
          0.615,    0.889,    0.054,    1.904,    0.578,    0.903,
          1.706,    0.122,    0.2  ,    1.463,    0.106,    0.808,
          0.715,    0.486,    0.998,    1.334,    0.427,    0.434,
          0.314,    0.163,    1.341,    1.307,    1.208,    1.881,
          1.105,    0.954,  140.352,    0.027,   58.012,    0.354,
          0.907,    0.418,    5.577, 2125.205,  147.83 ])
default_feature_vector = np.array([
       1., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
       0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0., 0.,
       0., 0., 1., 0., 1., 2., 2., 0., 1., 0., 0., 0., 0., 0., 0., 0., 0.,
       0., 0.])
if __name__ == "__main__":
    # For debugging use
    yp = YAML_Parser('./yaml/setting.yml',15)
    yp.test_mode = 0

    upper_bound, default_vec, var_type = yp.GetVarBoundForAll()
    arr = np.vstack((upper_bound, default_vec, var_type, np.zeros(var_type.size)))
    arr = np.transpose(arr)
    
    # with open('{}/workspace/dump/a.csv'.format(os.environ['HOME']), 'w') as fout:
    #     fout.write('upper bound,default vector,var type,line#\n')
    #     np.savetxt(fout,arr,delimiter=',',fmt='%.3f')

    # exit()
    
    rnd_x = np.multiply(
        upper_bound,
        np.random.rand(upper_bound.size)
    )
    np.set_printoptions(precision=3,suppress=True)
    print(repr(rnd_x))
    print(repr(default_vec))
    exit()
    # rnd_x = feature_vector_for_test
    scripts_for_all,_ = yp.FeatureVec2ScriptsForAll(feature_vector_for_test)
    
    
    with open('{}/workspace/dump/chisel_config.scala'.format(os.environ['HOME']), 'w') as fout:
        fout.write( '\n'.join(scripts_for_all['arch']) )
        
    # with open('{}/workspace/dump/syn_attr.tcl'.format(os.environ['HOME']), 'w') as fout:
    #     fout.write( '\n'.join(scripts_for_all['syn']) )

    # with open('{}/workspace/dump/par_attr.tcl'.format(os.environ['HOME']), 'w') as fout:
    #     fout.write( '\n'.join(scripts_for_all['par']) )
    exit()
    
    # breakpoint()

    col_name = np.array(['upper bound', 'default vector', 'var type', 'input vector', 'converted script'])

    with open('{}/vm/shared/workspace/dump/b.csv'.format(os.environ['HOME']), 'w') as fout:
        fout.write(','.join(col_name) + '\n')
        for i in range(upper_bound.size):
            fout.write('{ub},{dv},{vt},{iv},{scr}\n'.format(ub=upper_bound[i], dv=default_vec[i], vt=var_type[i], iv=rnd_x[i], scr=lines_for_test[i]))
    
"""

"""
