#!/usr/bin/env python3

from matplotlib.patches import Rectangle,Polygon
import matplotlib.pyplot as plt
import copy as cp
import numpy as np
import math, yaml, json, os, sys
from typing import List, Union

def pause():
    programPause = input("Press the <ENTER> key to continue...")
    if 'e'==programPause:
        raise ValueError('[@py_sram_placer]: Force Exit.')

class SRAM_BASE:
    # sram_lef_dir = '/export/home/yyzhao/vm/shared/workspace/chipyard/.conda-env/lib/python3.9/site-packages/hammer/technology/asap7/sram_compiler/memories/lef'
    sram_lef_dir = '/export/home/yyzhao/vm/shared/workspace/chipyard/.conda-env/lib/python3.9/site-packages/hammer/technology/asap7/sram_compiler/memories/lef'
    #'{}/technology/asap7/sram_compiler/memories/lef'.format(os.environ['HAMMER_VLSI'])

    def __init__(self, 
        sram_list_file:str = None,
        mems_v_file:str = None,
        yaml_path:str = None,
        conf_name_global:str = None,
        sram_lef_dir:str = None,
        arg_list:List[str] = []
    ):
        self.sram_list_file = sram_list_file
        self.mems_v_file = mems_v_file
        self.yaml_path = yaml_path
        self.conf_name_global = conf_name_global # 'SmallBoom', 'MediumBoom', 'LargeBoom', 'MegaBoom', GigaBoom
        if None != sram_lef_dir:
            self.sram_lef_dir = sram_lef_dir
        self.arg_list = arg_list

        self.test_mode = False
        self.floorplan_dir = '.'

        if sram_list_file and mems_v_file and yaml_path and conf_name_global and sram_lef_dir: 
            pass
        else:
            self.read_arguments()

        pos =  self.yaml_path.rfind('/')
        self.floorplan_tcl =  self.yaml_path.replace( self.yaml_path[pos+1:], 'floorplan.tcl')
        self.pin_tcl =  self.yaml_path.replace( self.yaml_path[pos+1:], 'pins.tcl')

        self.spacing_dr={
                    'M6 Width':0.032, 
                    'M6 Spacing':0.032, 
                    'Block to Edge': 9.6, 
                    'Cell Spacing':[0.192, 0.192], 
                    'BUFx24 Width': 1.728, 
                    'BUF Height':0.384, 
                    'Inter-Stage': 48, 
                    'Inter-Instance':24, 
                    'extra offset':[(0.096+0.096)*192, (0.096+0.096)*32], 
                    'offset scaler':[1,4]
        }
        self.slots_template={'x-range':[0,0], 'y-range':[0,0], 'place at':'t'} # place in {'t', 'b', 'l', 'r'}
        self.chip_width_scale = 1 # + 2**(-3)

        self.pins = [
            {'side':'top', 
            'layer':'M7',
            'pin':['axi4_mem_0_clock', 'axi4_mem_0_reset', 'axi4_mem_0_bits_aw*', 'axi4_mem_0_bits_w_ready', 'axi4_mem_0_bits_w_valid','axi4_mem_0_bits_w_bits_strb*', 'axi4_mem_0_bits_w_bits_last']},
            {'side':'bottom',
            'layer':'M7',
            'pin':['axi4_mem_0_bits_b*', 'axi4_mem_0_bits_r_ready', 'axi4_mem_0_bits_r_valid', 'axi4_mem_0_bits_r_bits_id*', 'axi4_mem_0_bits_r_bits_resp*', 'axi4_mem_0_bits_r_bits_last', 'axi4_mem_0_bits_ar*']},
            {'side':'right',
            'layer':'M6',
            'pin':['uart*', 'jtag*', 'serial_tl*', 'custom_boot', 'clock_clock', 'reset']},
            {'side':'left',
            'layer':'M6',
            'pin':['axi4_mem_0_bits_w_bits_data*', 'axi4_mem_0_bits_r_bits_data*']}
        ]

    def check_align(self, config):
        for i in range(1,len(config)):
            x = int(config[i]['x'] * 1000 +0.5)
            y = int(config[i]['y'] * 1000 +0.5)

            if 0 != x%96 or 0 != y%96:
                print('Found a mistake')
                print(config[i]['x']*1000, config[i]['y']*1000)
                print(config[i])
                exit()

    def is_integer_scale_of(self, a,b): # check if a is integer multiply of b
        c = a/b
        is_int = 1e-3 > abs(int(c+0.5) - c)
        return is_int

    def read_arguments(self):
        if [] == self.arg_list and 1 == len(sys.argv):
            raise ValueError('[@py_sram_placer]: No arguments specified.')

        if not self.arg_list:
            argv_ = sys.argv
        else:
            argv_ = self.arg_list
        # breakpoint()
        i=1
        while i<len(argv_):
            #=======Available Arguments=======#
            # -sram_list or -s: str
            #   The file containing list of SRAM instances in the design. It must be a file name
            # -mems_v or -m: str
            #   Verilog file that defines SRAM modules. We use it to find SRAM module names and get the SRAM in the library. Must be 
            #   a file name
            # -yaml or -y: str
            #   The path of the output .yml config file.
            # -config or -c: str
            #   Config name of the design
            # -lef_dir or -lef: str
            #   The directory that holds all the SRAM LEF files. Default directory will be used if not specified
            #=================================#
            if '-sram_list' == argv_[i] or '-s' == argv_[i]:
                i += 1
                if os.path.isfile(argv_[i]):
                    self.sram_list_file = argv_[i]
                else:
                    raise ValueError('[@py_sram_placer]: \"{}\" is not a file or does not exist.'.format(argv_[i]))
            elif '-mems_v' == argv_[i] or '-m' == argv_[i]:
                i += 1
                if os.path.isfile(argv_[i]):
                    self.mems_v_file = argv_[i]
                else:
                    raise ValueError('[@py_sram_placer]: \"{}\" is not a file or does not exist.'.format(argv_[i]))
            elif '-yaml' == argv_[i] or '-y' == argv_[i]:
                i += 1
                pos = argv_[i].rfind('/')
                if -1 != pos:
                    folder = argv_[i][:pos]
                    if not os.path.isdir(folder):
                        raise ValueError('[@py_sram_placer]: \"{}\" is not a valid path for yaml config file.'.format(argv_[i]))

                self.yaml_path = argv_[i]
            elif '-config' == argv_[i] or '-c' == argv_[i]:
                i += 1
                self.conf_name_global = argv_[i]
            elif '-lef_dir' == argv_[i] or '-lef' == argv_[i]:
                i += 1
                self.sram_lef_dir = argv_[i]
            else:
                raise ValueError('[@py_sram_placer]: Invalid option \"{}\"'.format(argv_[i]))
            
            # breakpoint()
            i += 1
        
        #return self.sram_list_file, self.mems_v_file,  self.yaml_path, self.conf_name_global
        if self.test_mode:
            print('^',end='')

    def round_down(self, num):
        # round up to an integer scale of 0.096
        scale = int(num/0.096)
        return 0.096*scale

    def round_up(self, num):
        # round up to an integer scale of 0.096
        scale = math.ceil(num/0.192)
        return 0.192*scale

    def write_floorplan_tcl(self, place_cons: list):
        cons_cnt = len(place_cons)
        with open(self.floorplan_tcl,'w') as fout: #write floorplan
            size_str = '{width:.6f} {height:.6f}'.format(width = place_cons[0]['width'], height = place_cons[0]['height'] )
            fout.write('create_floorplan -core_margins_by die -flip f -die_size_by_io_height max -site asap7sc7p5t -die_size { ' + size_str + '  0 0 0 0 }\n\n')

            for i in range(1,cons_cnt):
                # print(place_cons[i])
                fout.write('place_inst {path} {x} {y} {orientation}\n'.format(path = place_cons[i]['path'].replace('ChipTop/',''), x = place_cons[i]['x'], y = place_cons[i]['y'], orientation = place_cons[i]['orientation']))
                tmp_str = '{0.240 0.240 0.240 0.240}'
                fout.write('create_place_halo -insts {path} -halo_deltas {tmp_str} -snap_to_site\n'.format(path = place_cons[i]['path'].replace('ChipTop/',''), tmp_str = tmp_str))
                fout.write('create_route_halo -bottom_layer M1 -space 0.0 -top_layer M4 -inst {path}\n\n'.format(path = place_cons[i]['path'].replace('ChipTop/','')))

    def write_pin_tcl(self, place_cons: list):
        left_bracket = '{'
        right_bracket = '}'
        with open(self.pin_tcl, 'w') as fout:
            for side in self.pins:
                for pin in side['pin']:
                    fout.write('edit_pin -fixed_pin -pin {pin} -hinst ChipTop -spread_type range -layer {lb} {layer} {rb} -side {side} -pin_width 0.64 -pin_depth 0.64 '.format(pin = pin, layer = side['layer'], side = side['side'], lb = left_bracket, rb = right_bracket))
                    if 'top' == side['side']:
                        fout.write('-start {lb} {left} {top} {rb} -end {lb} {right} {top} {rb}'.format(left = self.spacing_dr['Block to Edge'], right = place_cons[0]['width'] - self.spacing_dr['Block to Edge'], top = place_cons[0]['height'], lb = left_bracket, rb = right_bracket))
                    elif 'bottom' == side['side']:
                        fout.write('-start {lb} {right} {bottom} {rb} -end {lb} {left} {bottom} {rb}'.format(left = self.spacing_dr['Block to Edge'], right = place_cons[0]['width'] - self.spacing_dr['Block to Edge'], bottom = 0, lb = left_bracket, rb = right_bracket))
                    elif 'right' == side['side']:
                        fout.write('-start {lb} {right} {top} {rb} -end {lb} {right} {bottom} {rb}'.format(right = place_cons[0]['width'], top = place_cons[0]['height'], bottom = 0, lb = left_bracket, rb = right_bracket))
                    elif 'left' == side['side']:
                        fout.write('-start {lb} {left} {bottom} {rb} -end {lb} {left} {top} {rb}'.format(left = 0, top = place_cons[0]['height'], bottom = 0, lb = left_bracket, rb = right_bracket))
                    fout.write('\n')
                fout.write('\n\n')

    def write_tcl(self, place_cons: list):
        self.write_floorplan_tcl(place_cons)
        self.write_pin_tcl(place_cons)
#=================================================================#
#                                                                 #
#=================================================================#
class SRAM_Module:
    def __init__(self, 
        master='',
        path='', 
        orientation='r0', 
        base:SRAM_BASE =None
        ):
        self.base = base
        self.is_module = True
        self.x = 0
        self.y = 0
        self.master = master # SRAM name, E.g. SRAM1RW256x32
        self.path = path.replace('\n', '')
        self.min_spacing = 0.0
        self.width = 0.1; self.width_no_round = 0.0
        self.height = 0.1; self.height_no_round = 0.0
        self.unique_wire_count=0
        self.symbol = Rectangle( xy=(self.x, self.y),
                                 width=self.width,
                                 height=self.height,
                                 edgecolor='#FFFF33',
                                 linewidth = 0.3,
                                 facecolor='#33FFFF',
                                 fill=True)

        # Denotes SRAM rotation or flipping. Available values are 'r0', 'r90', 'r180', 'r270', 'my', 'mx'
        if orientation not in ['r0', 'r90', 'r180', 'r270', 'my', 'mx']:
            raise ValueError('[@py_sram_placer]: Invalid orientation: {}'.format(orientation))

        self.orientation = orientation #I/O ports on left edge
                                 
        if(master):
            # Get Pin Count and Calculate Spacing
            if '1RW' in master:
                self.set_min_spacing(master)
            elif '2RW' in master:
                self.set_min_spacing(master)

            self.reset_size(master)

        # Denotes SRAM rotation or flipping. Available values are 'r0', 'r90', 'r180', 'r270', 'my', 'mx'
        if orientation not in ['r0', 'r90', 'r180', 'r270', 'my', 'mx']:
            raise ValueError('[@py_sram_placer]: Invalid orientation: {}'.format(orientation))

        self.orientation = orientation #I/O ports on left edge
    
    def check_align(self) -> bool:
        aligned = self.base.is_integer_scale_of(self.x, 0.192) and self.base.is_integer_scale_of(self.width, 0.192) and self.base.is_integer_scale_of(self.height, 0.192)

        aligned = aligned and self.base.is_integer_scale_of(self.y, 0.192)

        if not aligned:
            print('Path:{}\n\t{} {} {} {}'.format(self.path, self.x, self.y, self.width, self.height))
        return aligned

    def flip_hor(self): # Flip horizontally
        if 'r0' == self.orientation:
            self.orientation = 'my'
        elif 'my' == self.orientation:
            self.orientation = 'r0' 
        elif 'r180' == self.orientation:
            self.orientation = 'mx'
        elif 'mx' == self.orientation:
            self.orientation = 'r180'

    def flip_ver(self):
        if 'r0' == self.orientation:
            self.orientation = 'mx'
        elif 'mx' == self.orientation:
            self.orientation = 'r0'
        elif 'my' == self.orientation:
            self.orientation = 'r180'
        elif 'r180' == self.orientation:
            self.orientation = 'my'

    def get_module_placement(self) -> list:
        x = self.x
        y = self.y

        if 'mx' == self.orientation:
            y += self.height - self.height_no_round
        elif 'r180' == self.orientation:
            x += self.width - self.width_no_round
            y += self.height - self.height_no_round
        elif 'my' == self.orientation:
            x += self.width - self.width_no_round
            y += (-0.096)
        elif 'r0' == self.orientation:
            y += (-0.096)

        place = {'path': self.path,
                 'type': 'hardmacro',
                 'x': float('{:.3f}'.format(x)),
                 'y': float('{:.3f}'.format(y)),
                 'orientation': self.orientation,
                 'top_layer': 'M4',
                 'master': self.master
                }
        # place_blockage = {
        #          'path': self.path,
        #          'type': 'obstruction',
        #          'x': (self.x - self.spacing_dr['Cell Spacing'][0]),
        #          'y': (self.y - self.spacing_dr['Cell Spacing'][1]),
        #          'width': (self.width + 2*self.spacing_dr['Cell Spacing'][0]),
        #          'height': (self.height + 2*self.spacing_dr['Cell Spacing'][1]),
        #          'obs_types': ["place"]
        #         }
        # M1_2_3_blockage = {
        #          'path': self.path,
        #          'type': 'obstruction',
        #          'x': (self.x - self.spacing_dr['M2 Spacing']),
        #          'y': (self.y - self.spacing_dr['M2 Spacing']),
        #          'width': (self.width + 2*self.spacing_dr['M2 Spacing']),
        #          'height': (self.height + 2*self.spacing_dr['M2 Spacing']),
        #          'layers': ['M1','M2','M3'],
        #          'obs_types': ["route"]
        #         }
        # return [place, place_blockage, M1_2_3_blockage]
        return [place]

    def get_module_spacing(self, n_unique_wire_set=[0,0], extra_offset=[0,0]) -> list:
        nuws=(max(2,n_unique_wire_set[0]), max(2,n_unique_wire_set[1]))
        if 0 == self.min_spacing:
            self.set_min_spacing(self.master)

        track_width = self.base.spacing_dr['M6 Width'] + self.base.spacing_dr['M6 Spacing']
        n_extra = [nuws[0] - 2, nuws[1] - 2]

        hs = self.min_spacing + extra_offset[0] + n_extra[0] * self.unique_wire_count * track_width
        vs = self.min_spacing + extra_offset[1] + n_extra[1] * self.unique_wire_count * track_width

        h_cell_spacing = 12 * self.base.spacing_dr['BUF Height'] #+ 11 * self.base.spacing_dr['Cell Spacing'][0] # place 10 BUFx2 between horizontal SRAM neighbours. The buffer is cubic
        v_cell_spacing = 3 * self.base.spacing_dr['Cell Spacing'][1] + 2 * self.base.spacing_dr['BUF Height'] # place two buffers between vertial SRAM neighbours

        hs = self.base.round_up(max(hs, h_cell_spacing))
        vs = self.base.round_up(max(vs, v_cell_spacing))
        
        return [hs, vs]

    def place_self(self,xy,orientation=None):
        self.x = self.base.round_up(xy[0])
        self.y = self.base.round_up(xy[1])
        if None != orientation:
            self.orientation = orientation
        
        self_is_rotated_90d = ('r90'==self.orientation or 'r270'==self.orientation)
        new_is_rotated_90d = ('r90'==orientation or 'r270'==orientation)

        if self_is_rotated_90d ^ new_is_rotated_90d:
            tmp = self.width
            self.width=self.height
            self.height=tmp 

        self.update_symbol()

    def plot_self(self,ax):
        ax.add_patch(self.symbol)
        corners = {'top_left':np.array([[self.x, self.y]]),
                   'top_right':np.array([[self.x + self.width, self.y]]),
                   'bottom_left':np.array([[self.x, self.y + self.height]]),
                   'bottom_right':np.array([[self.x + self.width, self.y + self.height]]),
                  }
        edge_length = 10
        # print('{}, orientation: {}'.format(self.path,self.orientation))
        if 'r0' == self.orientation:
            tri_corner1 = np.add([0,edge_length], corners['top_left'])
            tri_corner2 = np.add([edge_length,0],corners['top_left'])
            p = np.concatenate((corners['top_left'],tri_corner1,tri_corner2))
        elif 'r90' == self.orientation or 'mx' == self.orientation:
            tri_corner1 = np.add([0,-edge_length],corners['bottom_left'])
            tri_corner2 = np.add([edge_length,0],corners['bottom_left'])
            p = np.concatenate((corners['bottom_left'],tri_corner1,tri_corner2))
        elif 'r180' == self.orientation:
            tri_corner1 = np.add([0,-edge_length],corners['bottom_right'])
            tri_corner2 = np.add([-edge_length,0],corners['bottom_right'])
            p = np.concatenate((corners['bottom_right'],tri_corner1,tri_corner2))
        elif 'r270' == self.orientation or 'my' == self.orientation:
            tri_corner1 = np.add([0,edge_length], corners['top_right'])
            tri_corner2 = np.add([-edge_length,0],corners['top_right'])
            p = np.concatenate((corners['top_right'],tri_corner1,tri_corner2))
        else:
            return 

        top_left_triangle = Polygon(p, edgecolor='g', facecolor='g', linewidth=0.3)
        ax.add_patch(top_left_triangle)

    def reset_master(self, master:str):
        if(master):
            self.set_min_spacing(master)

            self.reset_size(master)
        else:
            raise ValueError('[@py_sram_placer]: Argument \'master\' is empty string')

    def reset_size(self, master:str):
        with open(self.base.sram_lef_dir+'/'+master+'_x4.lef', 'r') as fin:
                for line in fin:
                    if 'SIZE' in line:
                        line = line.split()
                        if 'r90'==self.orientation or 'r270'==self.orientation:
                            self.width = float(line[3])
                            self.height = float(line[1])
                        else:
                            self.width = float(line[1])
                            self.height = float(line[3])
                        break
        self.width_no_round = self.width
        self.height_no_round = self.height

        self.width = self.base.round_up(self.width)
        self.height = self.base.round_up(self.height)
        self.update_symbol()

    def set_min_spacing(self, master:str):
        extra_pins=0
        IO_group_num=0
        if '1RW' in master:
            sram_cap = master.replace('SRAM1RW','').replace('_x4.lef','')
            IO_group_num = 1
            extra_pins = 4 #{CE,CS',OE',WE'}
        elif '2RW' in master:
            sram_cap = master.replace('SRAM2RW','').replace('_x4.lef','')
            IO_group_num = 2
            extra_pins = 7 #{CE1, CS1',OE1',WE1', CE2, CS2',OE2'},  WE2' assigned to 1
        else:
            raise ValueError('[@py_sram_placer]: Master name \"{}\" is invalid.'.format(master))

        sram_cap = sram_cap.split('x')
        for i in range(len(sram_cap)):
            sram_cap[i] = int(sram_cap[i])

        a_pins = math.ceil(math.log2( sram_cap[0]))
        i_pins = sram_cap[1]
        o_pins = i_pins 

        # ASAP7 SRAM Compiler use one port as write only and the other as read only
        if 1==IO_group_num:
            self.unique_wire_count = 3 + o_pins #{CS',OE',WE',O[WIDTH-1:0]}
        elif 2==IO_group_num:
            self.unique_wire_count = 3 + 2 + o_pins #{CS1',OE1',WE1', CS2',OE2',O[WIDTH-1:0]}

        extra_pins = 4

        total_pins = IO_group_num * a_pins + i_pins + o_pins + extra_pins

        self.min_spacing = (total_pins + self.unique_wire_count) * (self.base.spacing_dr['M6 Width'] + self.base.spacing_dr['M6 Spacing'])

    def update_symbol(self,rect:Rectangle = None):
        if None == rect:
            self.symbol.set_xy((self.x, self.y))
            self.symbol.set_width(self.width)
            self.symbol.set_height(self.height)
        else:
            self.symbol=rect
            self.x = rect.get_x()
            self.y = rect.get_y()
            self.width = rect.get_width()
            self.height = rect.get_height()
#=================================================================#
#                                                                 #
#=================================================================#
class SRAM_Array:
    def __init__(self,
        path_str,
        parent,
        orientation='r0',
        base:SRAM_BASE =None
    ):
        self.base = base
        self.inst_list = [[]] # list for sram modules in this sram array
        self.sram_master = ''
        self.is_module = False # Denotes if this is basic SRAM module
        self.x = 0
        self.y = 0
        self.spacing = {'top':0, 'bottom':0, 'left':0, 'right':0}
        self.slots = None 
        self.width = 0
        self.height = 0
        self.orientation = orientation
        self.mems_v = self.base.mems_v_file

        tmp_str = path_str.replace(parent+'/', '')
        tmp_str = tmp_str.split('/')
        self.name = tmp_str[0]
        self.path = parent + '/' + self.name
        self.parent = parent

        # if 'cc_banks_3' in path_str:
        #     print('{}\n{}\n{}'.format(self.name, self.path,  self.parent))
        #     pause()

        # Get SRAM module name
        with open(self.mems_v, 'r') as fin:
            block_found = False
            for line in fin:
                if -1 != line.find('module {}('.format(self.name)):
                    block_found = True

                if ('SRAM' in line) and block_found:
                    line = line.split()
                    self.sram_master = line[0]
                    break

                if ('endmodule' in line) and block_found:
                    raise Exception('Error: Cannot find SRAM in module {}.'.format(self.name))

        self.add_sram(path_str = path_str)

    def add_sram(self, path_str:str):
        idx = [0,0]
        mem_str = path_str.replace(self.path, '')
        mem_str = mem_str.split('_')[1:]
        # if 'cc_banks_3' in self.path or 'tag_array' in self.path:
        #     print('path_str: {}\nmem_str: {}'.format(path_str,mem_str))
        #     pause()
                
        idx[0] = int(mem_str[0])
        idx[1] = int(mem_str[1])

        self.inst_list = self.expand2Dlist(self.inst_list, idx)

        self.inst_list[idx[0]][idx[1]] = SRAM_Module(self.sram_master, path_str, self.orientation, self.base) 

    def check_align(self) -> bool:
        for row in self.inst_list:
            for sram in row:
                if not sram.check_align():
                    print('Path:{}\n\t{} {} {} {}'.format(self.path, self.x, self.y, self.width, self.height))
                    return False
        return True

    def expand2Dlist(self,old_list:list,target_idx:list) -> list:
        if type(old_list[0]) != list:
            raise ValueError('[@py_sram_placer]: The input list is not 2-dimensional.')

        rows = len(old_list)
        cols = len(old_list[0])
        
        if target_idx[0] >= rows:
            diff = target_idx[0] - rows + 1
            extra_rows = [[None] * cols] * diff
            old_list = old_list + extra_rows
            rows = len(old_list)

        if target_idx[1] >= cols:
            diff = target_idx[1] - cols + 1
            for i in range(rows):
                old_list[i] = old_list[i] + [None]*diff
        return old_list  

    def flip_hor(self):
        if 'r0' == self.orientation:
            self.orientation = 'my'
        elif 'my' == self.orientation:
            self.orientation = 'r0' 
        elif 'r180' == self.orientation:
            self.orientation = 'mx'
        elif 'mx' == self.orientation:
            self.orientation = 'r180'

        for row in self.inst_list:
            for sram in row:
                sram.flip_hor()

    def flip_ver(self):
        if 'r0' == self.orientation:
            self.orientation = 'mx'
        elif 'mx' == self.orientation:
            self.orientation = 'r0'
        elif 'my' == self.orientation:
            self.orientation = 'r180'
        elif 'r180' == self.orientation:
            self.orientation = 'my'

        for row in self.inst_list:
            for sram in row:
                sram.flip_ver()

    def get_inst_count(self) -> int:
        shape = self.get_sram_array_shape()
        return shape[0] * shape[1]

    def get_inst_placement(self) -> list:
        sram_place_cons = []
        for row in self.inst_list:
            for sram in row:
                sram_place_cons += sram.get_module_placement() 

        return sram_place_cons 
    
    def get_inst_spacing(self) -> dict:
        return self.spacing

    def get_sram_array_shape(self): # not size of array layout
        rows = len(self.inst_list)
        cols = len(self.inst_list[0])
        return [rows,cols]

    def place_inst(self):
        reshaped = False
        shape = self.get_sram_array_shape()
        nrows = shape[0]
        ncols = shape[1]

        if 'cc_banks_0_ext' == self.name :
            if nrows/ncols > 8:
                tmp_idx = int((nrows * ncols)/8)
                tmp_arr = np.array(self.inst_list).reshape((tmp_idx,8))
                self.inst_list = tmp_arr.tolist()
                nrows = tmp_arr.shape[0]
                ncols = tmp_arr.shape[1]
            else:
                tmp_arr = np.array(self.inst_list).reshape((ncols,nrows))
                self.inst_list = tmp_arr.tolist()
                nrows = tmp_arr.shape[0]
                ncols = tmp_arr.shape[1]
            
            reshaped = (0==nrows%2)
        if 'l2/mods_0/directory' in self.path:
            if 1 != ncols:
                tmp_idx = ncols
                tmp_arr = np.array(self.inst_list).reshape((ncols, 1))
                self.inst_list = tmp_arr.tolist()
                nrows = tmp_arr.shape[0]
                ncols = tmp_arr.shape[1]
            if 0!=self.height:
                self.slots=[]
                slot_spacing = max( 2 * self.base.spacing_dr['Cell Spacing'][1] + self.base.spacing_dr['BUF Height'],
                                    100* (self.base.spacing_dr['M6 Width'] + self.base.spacing_dr['M6 Spacing']))
                slot_height = self.height - (nrows - 1) * slot_spacing
                slot_height = slot_height / nrows
                slot_begin = self.y
                slot_end = slot_begin + slot_height
                for i in range(nrows):
                    self.slots.append({'y-range':[slot_begin,slot_end], 'x-range':[0,0], 'place at':'t'})
                    if 1==i%2:
                        self.slots[-1]['place at'] = 'b'
                    slot_begin = slot_end + slot_spacing
                    slot_end = slot_begin + slot_height
        if 'tag_array_ext' == self.name or 'hi_us_' in self.name:
            # if 1 != nrows:
            #     tmp_arr = np.array(self.inst_list).reshape((1,nrows))
            #     self.inst_list = tmp_arr.tolist()
            #     nrows = tmp_arr.shape[0]
            #     ncols = tmp_arr.shape[1]
            if 0!= self.width:
                self.slots=[]
                slot_spacing = 2 * self.base.spacing_dr['Cell Spacing'][1] + self.base.spacing_dr['BUF Height']
                slot_width = self.width - (ncols-1) * slot_spacing
                slot_width = slot_width / ncols 
                slot_begin = self.x 
                slot_end = slot_begin + slot_width
                for i in range(ncols):
                    self.slots.append({'x-range':[slot_begin,slot_end], 'y-range':[0,0], 'place at':'l'})
                    if 1==i%2:
                        self.slots[-1]['place at'] = 'r'
                    slot_begin = slot_end + slot_spacing
                    slot_end = slot_begin + slot_width
                reshaped = (0==nrows%2) and 'hi_us/hi_us_' in self.path
        if 'dcache/data' in self.path:
            reshaped = (0==nrows%2)

        is_dcache = ('dcache/data' in self. path)
        # Place SRAMs in the array
        sram_x = self.x 
        sram_y = self.y
        row_idx=0; col_idx=0
        nuws = [0,0]
        if None == self.slots:
            n_unique_wire_set = max(nrows,ncols)

            n_unique_wire_set *= 2

            if nrows > ncols:
                nuws = [n_unique_wire_set,2]
            else:
                nuws = [2,n_unique_wire_set]

            for row in self.inst_list:
                for sram in row:
                    # print('{} ({},{}) col_idx%2 = {}'.format(self.name, row_idx, col_idx, col_idx%2))
                    sram.place_self([sram_x, sram_y], self.orientation)
                    if 0 == row_idx%2:
                        sram.flip_ver()

                    if 1 == col_idx%2:
                        sram.flip_hor()
                        sram_x += sram.width + 2 * self.base.spacing_dr['Cell Spacing'][0] + self.base.spacing_dr['BUF Height'] # BUFx2 is cubic
                    else:
                        sram_x += sram.width + sram.get_module_spacing(nuws,self.base.spacing_dr['extra offset'])[0]
                    col_idx += 1
                    # print('SRAM orientation: {}'.format(sram.orientation))
                
                sram_x = self.x 
                if 1 == row_idx%2:
                    sram_y += 2 * self.base.spacing_dr['Cell Spacing'][1] + self.base.spacing_dr['BUF Height'] + sram.height
                else:
                    if '_l2_' in self.path:
                        eo = np.multiply(self.base.spacing_dr['extra offset'], self.base.spacing_dr['offset scaler'])
                    else:
                        eo = self.base.spacing_dr['extra offset']
                    sram_y += sram.get_module_spacing(nuws,eo)[1] + sram.height
                row_idx += 1
                col_idx = 0
        else:
            # tmp_list = self.inst_list
            # self.inst_list = sum(self.inst_list,[])
            if [0,0] != self.slots[0]['x-range'] and ncols==len(self.slots):
                for row in self.inst_list:
                    for sram in row:
                        sram_y = self.base.round_up(sram_y)
                        if 'l' == self.slots[col_idx]['place at']:
                            sram_x = self.slots[col_idx]['x-range'][0]
                            sram_x = self.base.round_up(sram_x)
                        elif 'r' == self.slots[col_idx]['place at']:
                            sram_x = self.slots[col_idx]['x-range'][1] - sram.width
                            sram_x = self.base.round_down(sram_x)
                        sram.place_self([sram_x, sram_y],self.orientation)
                        if 1 == col_idx%2:
                            sram.flip_hor()
                        if 0 == row_idx%2:
                            sram.flip_ver()
                        col_idx += 1
                
                    if 1 == row_idx%2:
                        sram_y += 2 * self.base.spacing_dr['Cell Spacing'][1] + self.base.spacing_dr['BUF Height'] + sram.height
                    else:
                        eo = self.base.spacing_dr['extra offset']
                        nuws = [2,2]
                        sram_y += sram.get_module_spacing(nuws,eo)[1] + sram.height
                    col_idx = 0
                    row_idx += 1

            elif [0,0] != self.slots[0]['y-range'] and nrows==len(self.slots):
                # Placing single column of SRAMs
                sram_x = self.base.round_up(sram_x)
                for row in self.inst_list:
                    if list == type(row):
                        sram = row[0]
                    else:
                        sram = row
                    if 't' == self.slots[row_idx]['place at']:
                        sram_y = self.slots[row_idx]['y-range'][0]
                        sram_y = self.base.round_up(sram_y)
                    elif 'b' == self.slots[row_idx]['place at']:
                        sram_y = self.slots[row_idx]['y-range'][1] - sram.height
                        sram_y = self.base.round_down(sram_y)                        
                    sram.place_self([sram_x, sram_y],self.orientation)
                    if 0 == row_idx%2:
                        sram.flip_ver()
                    row_idx += 1
            else:
                raise ValueError('[@py_sram_placer]: Invalid instance list shape')
            # self.inst_list = tmp_list
            # del tmp_list
                     
        # Update self.width and self.height
        bottom_right = self.inst_list[nrows-1][ncols-1]

        self.width = bottom_right.x + bottom_right.width - self.x
        self.height = bottom_right.y + bottom_right.height - self.y

        space_tmp = self.inst_list[0][0].get_module_spacing(nuws, self.base.spacing_dr['extra offset'])
        if reshaped:
            space_tmp[1] = 2 * self.base.spacing_dr['Cell Spacing'][0] + self.base.spacing_dr['BUF Height']
        
        self.spacing = {'top':space_tmp[1], 'bottom':space_tmp[1], 'left':space_tmp[0], 'right':space_tmp[0]}

    def place_self(self,xy,orientation,slots = None):
        # Update coordinate of self
        self.x = xy[0]
        self.y = xy[1]
        self.orientation = orientation
        if None != slots:
            self.slots = slots

        # Update coordinate of sram modules
        self.place_inst()

    def plot_self(self, ax):
        for row in self.inst_list:
            for sram in row:
                sram.plot_self(ax)

    def reset_horizontal_spacing(self,edge:str):
        closer_spacing = 2 * self.base.spacing_dr['Cell Spacing'][0] + self.base.spacing_dr['BUFx24 Width'] # BUFx2 is cubic

        if 0 == self.get_sram_array_shape()[1]%2:
            if 'left' == edge or 'right' == edge:
                self.spacing[edge] = closer_spacing
            else:
                raise ValueError('[@py_sram_placer]: Invalid index for spacing dict.')

    def reset_sram_master(self, master:str):
        if any(self.inst_list):
            for row in self.inst_list:
                for sram in row:
                    sram.reset_master(master)

            self.place_inst()

    def shift_inst(self,shift:list):
        if len(shift) != 2 or not any(shift):
            raise ValueError('[@py_sram_placer]: Error. The shift vector is empty or invalid.')

        self.x += shift[0]
        self.y += shift[1] 
        for row in self.inst_list:
            for sram in row:
                sram.place_self([sram.x + shift[0], sram.y + shift[1]])

    def test_print_info(self):
        print('SRAM Array: {0}, Position: {1}, Size: {2:.2f} by {3:.2f}, #SRAMs: {4}'.format(self.name, [self.x, self.y], self.width, self.height, self.get_inst_count()))
#=================================================================#
#                                                                 #
#=================================================================#
class Hie_Inst: # Hierachical Instance
    def __init__(self, path_str, parent, orientation='r0', base:SRAM_BASE =None
    ):
        self.base = base
        self.inst_list = []
        self.is_module = False
        self.x = 0
        self.y = 0
        self.spacing = {'top':0, 'bottom':0, 'left':0, 'right':0}
        self.width = 0
        self.height = 0
        self.orientation = orientation        
        self.slots = None

        tmp_str = path_str.replace((parent+'/'), '')
        tmp_str = tmp_str.split('/')
        self.name = tmp_str[0]
        self.path = parent + '/' + self.name
        self.parent = parent
        
        # print('{}, {}, {}, {}'.format(self.name, self.path, orientation))
        # if 'tile' in path_str:
        #     print('{}\n{}\n{}'.format(self.name, self.path,  self.parent))
        #     pause()

        # try:
        self.add_sram(path_str = path_str)
        # except:
        #     print('An error occured.')
        #     print('Name: {}\nPath: {}\nParent: {}'.format(self.name, self.path,  self.parent))
        #     pause()
        #     exit()

    def add_sram(self, path_str:str): #recursively add instances and sram modules in hierarchy
        tmp_str = path_str.replace(self.path+'/', '')
        tmp_str = tmp_str.split('/')
        inst_name = tmp_str[0]
        # print('From Instance {}:\n{} ++ {}, {}\n-----'.format(self.name, self.path, tmp_str, inst_name))
        # if 'cc_banks_3' in self.path:
        #     pause()

        # Create new instance if does not exist
        inst = self.find_inst(inst_name)
        if None == inst:
            if 2 == len(tmp_str):
                self.inst_list.append( SRAM_Array(path_str, self.path, self.orientation, self.base) )
            else:
                self.inst_list.append( Hie_Inst(path_str, self.path, self.orientation, self.base) )
            # print('====Create New Inst and then Add SRAM')
            # print(self.inst_list[-1].name)
        else:
            # print('====Add to Existing Inst')
            inst.add_sram(path_str)
        #     print(inst.name)
        # print('==========')
    
    def check_align(self) -> bool:
        for inst_ite in self.inst_list:
            if not inst_ite.check_align():
                print('Path:{}\n\t{} {} {} {}'.format(self.path, self.x, self.y, self.width, self.height))
                return False
        return True

    def expand2Dlist(self,old_list:list,target_idx:list) -> list:
        if type(old_list[0]) != list:
            raise ValueError('[@py_sram_placer]: The input list is not 2-dimensional.')

        rows = len(old_list)
        cols = len(old_list[0])
        
        if target_idx[0] >= rows:
            diff = target_idx[0] - rows + 1
            extra_rows = [[None] * cols] * diff
            old_list = old_list + extra_rows
            rows = len(old_list)

        if target_idx[1] >= cols:
            diff = target_idx[1] - cols + 1
            for i in range(rows):
                old_list[i] = old_list[i] + [None]*diff
        return old_list        
        
    def flip_hor(self):
        if 'r0' == self.orientation:
            self.orientation = 'my'
        elif 'my' == self.orientation:
            self.orientation = 'r0' 
        elif 'r180' == self.orientation:
            self.orientation = 'mx'
        elif 'mx' == self.orientation:
            self.orientation = 'r180'


        for row in self.inst_list:
            if type(row) == list:
                for inst_ite in row:
                    inst_ite.flip_hor()
            else:
                inst_ite = row
                inst_ite.flip_hor()

    def flip_ver(self):
        if 'r0' == self.orientation:
            self.orientation = 'mx'
        elif 'mx' == self.orientation:
            self.orientation = 'r0'
        elif 'my' == self.orientation:
            self.orientation = 'r180'
        elif 'r180' == self.orientation:
            self.orientation = 'my'

        for row in self.inst_list:
            if type(row) == list:
                for inst_ite in row:
                    inst_ite.flip_ver()
            else:
                inst_ite = row
                inst_ite.flip_ver()

    def find_inst(self,inst_name:str):
        if any(self.inst_list):
            for inst_ite in self.inst_list:
                if(inst_name == inst_ite.name):
                    return inst_ite

        return None

    def get_inst_count(self) -> int:
        cnt = 0
        for inst_ite in self.inst_list:
            cnt += inst_ite.get_inst_count()
        
        return cnt

    def get_inst_placement(self) -> list:
        sram_place_cons = []
        for inst_ite in self.inst_list:
                sram_place_cons = sram_place_cons + inst_ite.get_inst_placement() 

        return sram_place_cons 

    def get_inst_spacing(self):
        return self.spacing

    def place_arrays(self):
        is_l2 = ('bankedStore' == self.name)
        is_dcache = ('dcache/data' in self. path and 'data' == self.name)
        # place data block in rows
        if is_dcache:
            tmp_list=[[]]
            idx = [0,0]
            for inst_ite in self.inst_list:
                idx_str = inst_ite.name.split('_')[1:]
                idx[0] = int(idx_str[1])
                idx[1] = int(idx_str[0])
                tmp_list = self.expand2Dlist(tmp_list,idx)
                tmp_list[idx[0]][idx[1]] = inst_ite
            self.inst_list = tmp_list
            del tmp_list            
        elif is_l2:
            tmp_arr = np.array([self.inst_list])
            tmp_shape = tmp_arr.shape
            tmp_arr = tmp_arr.reshape([tmp_arr.shape[1],1])
            self.inst_list = tmp_arr.tolist()
        
            del tmp_arr
            del tmp_shape

        inst_x = self.x 
        inst_y = self.y 
        row_idx = 0; col_idx = 0
        self.slots = []
        # print(self.path, len(self.inst_list))
        for row in self.inst_list:
            for inst_ite in row:
                inst_ite.place_self([inst_x, inst_y], self.orientation)
                if 0 == col_idx:
                    inst_ite.reset_horizontal_spacing('right')
                elif col_idx + 1 == len(row):
                    inst_ite.reset_horizontal_spacing('left')
                else:
                    inst_ite.reset_horizontal_spacing('left')
                    inst_ite.reset_horizontal_spacing('right')
                
                if is_l2 and 1==row_idx%2:
                    if 0 != inst_ite.inst_list[0].get_sram_array_shape()[0]%2:
                        inst_ite.inst_list[0].flip_ver()

                inst_x += inst_ite.spacing['right'] + inst_ite.width

                col_idx += 1

            inst_x = self.x
            inst_y += inst_ite.height
            if is_l2 and 1==row_idx%2:
                inst_y += 2 * self.base.spacing_dr['Cell Spacing'][0] + self.base.spacing_dr['BUF Height']
            else:
                inst_y += inst_ite.spacing['bottom']
            row_idx += 1

        nrows = len(self.inst_list)
        ncols = len(self.inst_list[0])

        bottom_right = self.inst_list[nrows-1][ncols-1]

        self.width = bottom_right.x + bottom_right.width - self.x
        self.height = bottom_right.y + bottom_right.height - self.y

        # if is_l2:
        #     slot_spacing = self.inst_list[0][0].spacing['bottom']
        #     slot_height = (self.height - 7*slot_spacing) / 8
            
        
        if type(self.inst_list[0]) == list:
            self.inst_list = sum(self.inst_list,[])

        self.spacing = self.inst_list[0].spacing

    def place_dcache(self):
        self.place_vertically([self.x, self.y], self.inst_list)

        tmp_w = self.find_inst('data').width
        for inst_ite in self.inst_list:
            if 'data' != inst_ite.name:
                inst_ite.width = tmp_w
                inst_ite.place_inst()

                idx_str = inst_ite.name.replace('meta_','')
                if 1 == int(idx_str)%2 and 0 != inst_ite.inst_list[0].inst_list[0].get_sram_array_shape()[0]%2:
                    inst_ite.flip_ver()

    def place_front_end(self):
        inst_dict = {'icache':self.find_inst('icache'), 'bpd':self.find_inst('bpd'), 'ftq':self.find_inst('ftq')}

        # Place I-cache
        inst_dict['icache'].place_self((self.x, self.y), self.orientation)
        inst_dict['icache'].spacing['right']  += self.base.spacing_dr['Inter-Instance'] 

        # Place Branch Predictor
        inst_x = self.x + inst_dict['icache'].width
        inst_dict['bpd'].place_self((inst_x, self.y), self.orientation)
        inst_dict['bpd'].shift_inst([ max(inst_dict['icache'].spacing['right'], inst_dict['bpd'].spacing['left']) ,0])

        # Place Fetch Target Queue
        inst_x = inst_dict['icache'].x + inst_dict['icache'].width
        inst_y = inst_dict['icache'].y + inst_dict['icache'].height
        inst_dict['ftq'].place_self((inst_x, inst_y), self.orientation)
        sh_x = -inst_dict['ftq'].width
        sh_y = max( self.base.spacing_dr['Inter-Instance'], 
                    inst_dict['bpd'].height-inst_dict['icache'].height-inst_dict['ftq'].height,
                    inst_dict['icache'].spacing['bottom'],
                    inst_dict['ftq'].spacing['top'])
        inst_dict['ftq'].shift_inst([sh_x, sh_y])

    def place_horizontally(self, origin_xy:list, inst_list_arg:list):
        if not origin_xy:
            raise ValueError('[@py_sram_placer]: Error. Empty origin coordinate.')
        if not any(inst_list_arg):
            raise ValueError('[@py_sram_placer]: Error. Empty list.')
        if len(origin_xy)<2:
            raise ValueError('[@py_sram_placer]: Error. Not a 2D coordinate.')
            
        inst_x = origin_xy[0]
        inst_y = origin_xy[1]
        right_spacing = 1e6
        tmp_h=0
        for inst_ite in inst_list_arg:
            inst_ite.height = tmp_h
            inst_ite.place_self([inst_x, inst_y], self.orientation)
            if 'bpd' == self.name:
                inst_ite.spacing['left'] += self.base.spacing_dr['Inter-Instance']
            if 'mods_' in self.name:
                tmp_h = inst_ite.height
            if inst_ite.spacing['left'] > right_spacing:
                diff = inst_ite.spacing['left'] - right_spacing
                inst_x += diff
                inst_ite.shift_inst([diff,0])
            inst_x += inst_ite.spacing['right'] + inst_ite.width
            right_spacing = inst_ite.spacing['right']

    def place_icache(self): # place icache data instances horizontally
        inst_in_array=[[]]
        inst_out_of_array = []
        idx=[0,0]
        self.slots=[]
        for inst_ite in self.inst_list:
            if 'dataArrayB' in inst_ite.name:
                tmp_str = inst_ite.name.replace('dataArrayB', '').split('Way_')
                idx = [int(tmp_str[0]), int(tmp_str[1])]
                inst_in_array = self.expand2Dlist(inst_in_array,idx)
                inst_in_array[idx[0]][idx[1]] = inst_ite
            elif 'dataArrayWay_' in inst_ite.name:
                tmp_str = inst_ite.name.replace('dataArrayWay_', '')
                idx = [0,int(tmp_str)]
                inst_in_array = self.expand2Dlist(inst_in_array,idx)
                inst_in_array[idx[0]][idx[1]] = inst_ite
            elif 'tag_array' == inst_ite.name:
                inst_out_of_array.append(inst_ite)
            else:
                raise ValueError('[@py_sram_placer]: Cannot recognize instance name \"{}\"'.format(inst_ite.name))

        inst_x = self.x; inst_y = self.y
        row_idx=0; col_idx=0
        for row in inst_in_array:
            for inst_ite in row:
                inst_ite.place_self([inst_x, inst_y], self.orientation)

                if 1 == col_idx%2:
                    inst_ite.flip_hor()
                
                if 1 == row_idx%2:
                    sram_array_shape = inst_ite.inst_list[0].get_sram_array_shape()
                    if sram_array_shape[0]%2 !=0:
                        inst_ite.flip_ver()
                
                if len(self.slots) < len(row):
                    tmp_slot = {'x-range':[0,0], 'y-range':[0,0], 'place at':'t'}
                    tmp_slot['x-range'] = [inst_x, inst_x + inst_ite.width]
                    if 1 == col_idx%2:
                        tmp_slot['place at'] = 'r'
                    else:
                        tmp_slot['place at'] = 'l'
                    self.slots.append(cp.deepcopy(tmp_slot))

                if 1 == col_idx%2:
                    inst_x += inst_ite.width + 2 * self.base.spacing_dr['Cell Spacing'][0] + self.base.spacing_dr['BUF Height'] # BUFx2 is cubic
                else:
                    inst_x += inst_ite.spacing['right'] + inst_ite.width
                    
                col_idx += 1


            inst_x = self.x
            if 1 == row_idx%2:
                inst_y += inst_ite.height + 2 * self.base.spacing_dr['Cell Spacing'][1] + self.base.spacing_dr['BUF Height']
            else:
                inst_y += inst_ite.spacing['bottom'] + inst_ite.height
            row_idx += 1
            col_idx=0

        inst_x = self.x

        tag_array = inst_out_of_array[0]
        tag_array.slots = self.slots
        tag_array.place_self([inst_x, inst_y], 'my')

    def place_inst(self):        
        if 'tile_' in self.name or 'directory' in self.path:
            self.inst_list[0].height = self.height
        elif 'dcache/meta_' in self.path:
            self.inst_list[0].width = self.width

        if 'mods_' in self.name and 'subsystem_l2_wrapper' in self.path:
            self.inst_list.reverse()
            self.inst_list[0].reset_horizontal_spacing('right')
            self.inst_list[1].reset_horizontal_spacing('left')
            self.place_horizontally([self.x,self.y], self.inst_list)
        elif 'dcache' == self.name:
            self.place_dcache()
        elif ('bankedStore' == self.name) or ('dcache' in self. path and 'data' == self.name):
            self.place_arrays()
        elif ('icache' == self.name):
            self.place_icache()
        elif ('ftq' == self.name):
            self.place_mixed_arrays()
        elif 'tables_' in self.name and 'components_1' in self.path:
            self.place_tage_table()
        elif 'components_1' == self.name:
            self.place_tage_predictor()
        elif 'banked_predictors_' in self.name:
            self.place_predictors()
        elif self.name == 'bpd':
            for inst_ite in self.inst_list:
                inst_ite.spacing['right'] = max(inst_ite.spacing['right'], self.base.spacing_dr['Inter-Instance'])
            self.place_horizontally([self.x, self.y], self.inst_list)
        elif self.name == 'frontend':
            self.place_front_end()
        elif self.name == 'boom_tile':
            self.place_tile()
        elif self.name == 'system':
            self.place_system()
        else:
            self.place_vertically([self.x, self.y], self.inst_list)

        # Update self.width and self.height
        for inst_ite in self.inst_list:
            if (self.x + self.width) < (inst_ite.x + inst_ite.width):
                self.width = (inst_ite.x + inst_ite.width) - self.x 
            
            if (self.y + self.height) < (inst_ite.y + inst_ite.height):
                self.height = (inst_ite.y + inst_ite.height) - self.y

        self.set_inst_spacing()

    def place_mixed_arrays(self):
        inst_in_array=[[]]
        inst_out_of_array = []
        idx=[0,0]
        if('icache' == self.name):
            for inst_ite in self.inst_list:
                if 'dataArrayB' in inst_ite.name:
                    tmp_str = inst_ite.name.replace('dataArrayB', '').split('Way_')
                    idx = [int(tmp_str[1]), int(tmp_str[0])]
                    inst_in_array = self.expand2Dlist(inst_in_array,idx)
                    inst_in_array[idx[0]][idx[1]] = inst_ite
                elif 'dataArrayWay_' in inst_ite.name:
                    tmp_str = inst_ite.name.replace('dataArrayWay_', '')
                    idx = [int(tmp_str),0]
                    inst_in_array = self.expand2Dlist(inst_in_array,idx)
                    inst_in_array[idx[0]][idx[1]] = inst_ite
                elif 'tag_array' == inst_ite.name:
                    inst_out_of_array.append(inst_ite)
        elif('ftq' == self.name):
            for inst_ite in self.inst_list:
                if 'ghist_' in inst_ite.name:
                    tmp_str = inst_ite.name.replace('ghist_', '')
                    idx = [int(tmp_str),0]
                    inst_in_array = self.expand2Dlist(inst_in_array,idx)
                    inst_in_array[idx[0]][idx[1]] = inst_ite
                elif 'meta' == inst_ite.name:
                    inst_out_of_array.append(inst_ite)

        inst_x = self.x; inst_y = self.y
        bottom_spacing = 1e6

        for inst_ite in inst_out_of_array:
            if inst_ite.spacing['top'] > bottom_spacing:
                diff = inst_ite.spacing['top'] - bottom_spacing
                inst_y += diff
            inst_ite.place_self([inst_x, inst_y], self.orientation)
            inst_y += inst_ite.spacing['bottom'] + inst_ite.height
            bottom_spacing = inst_ite.spacing['bottom']
        
        try:
            if inst_in_array[0][0].spacing['top'] > bottom_spacing:
                diff = inst_in_array[0][0].spacing['top'] - bottom_spacing
                inst_y += diff
        except:
            if not any(inst_in_array):
                n1=0
            else:
                n1 = len(inst_in_array) * len(inst_in_array[0])

            if not any(inst_out_of_array):
                n2 = 0
            else: 
                n2 = len(inst_out_of_array)
            print('Error. Path: {}\n{} instances in array. {} instances out of array'.format(self.path, n1,n2))

        # tmp_arr = np.array(inst_in_array)
        # tmp_shape = tmp_arr.shape
        # if ('icache' == self.name) and (max(tmp_shape[0],tmp_shape[1]) / min(tmp_shape[0],tmp_shape[1]) > 2):
        #     ncols = int(np.sqrt(tmp_shape[0] * tmp_shape[1]))
        #     nrows = int((tmp_shape[0] * tmp_shape[1]) / ncols)
        #     tmp_arr = tmp_arr.reshape([nrows, ncols])
        #     inst_in_array = tmp_arr.tolist()
        # del tmp_arr
        # del tmp_shape

        for row in inst_in_array:
            for inst_ite in row:
                inst_ite.place_self([inst_x, inst_y], self.orientation)
                inst_x += inst_ite.spacing['right'] + inst_ite.width

            inst_y += inst_ite.spacing['bottom'] + inst_ite.height
            inst_x = self.x

    def place_predictors(self):
        self.place_horizontally([self.x, self.y], self.inst_list)
        # inst_dict = {'Tage': self.find_inst('components_1'), 'BTB': self.find_inst('components_2'), 'BIM': self.find_inst('components_4')}
        
        # inst_dict['Tage'].place_self((self.x,self.y),self.orientation)

        # inst_x = inst_dict['Tage'].x + inst_dict['Tage'].width #+ self.base.spacing_dr['Inter-Instance'] 
        # inst_y = self.y
        # inst_dict['BTB'].place_self((inst_x,inst_y),self.orientation)
        # sh_x = max(inst_dict['Tage'].spacing['right'], inst_dict['BTB'].spacing['left']) + inst_dict['BTB'].width
        # inst_dict['BTB'].shift_inst([sh_x ,0])
        
        # inst_x = inst_dict['BTB'].x # + inst_dict['BTB'].width
        # inst_y = inst_dict['BTB'].y + inst_dict['BTB'].height
        # inst_dict['BIM'].place_self((inst_x,inst_y),self.orientation)
        # sh_x = inst_dict['BTB'].width - inst_dict['BIM'].width
        # sh_y = max(inst_dict['BTB'].spacing['bottom']+self.base.spacing_dr['Inter-Instance'], inst_dict['BIM'].spacing['top']+self.base.spacing_dr['Inter-Instance'], inst_dict['Tage'].height - inst_dict['BTB'].height - inst_dict['BIM'].height)

        # inst_dict['BIM'].shift_inst([sh_x,sh_y])

    def place_self(self,xy,orientation):
        self.x = xy[0]
        self.y = xy[1]
        self.orientation = orientation

        self.place_inst()

    def place_system(self):
        L2_cache = self.find_inst('subsystem_l2_wrapper')
        inst_x = self.x
        inst_y = self.y
        L2_cache.place_self([inst_x, inst_y], self.orientation)
        L2_cache.spacing['right'] += self.base.spacing_dr['Inter-Stage']

        tile = self.find_inst('tile_prci_domain')
        inst_x = L2_cache.x + L2_cache.width + L2_cache.spacing['right']
        tile.height = L2_cache.height # + 2*self.base.spacing_dr['Block to Edge']
        tile.place_self([inst_x, inst_y], self.orientation)

    def place_tage_predictor(self):
        table_col0 = []
        table_col1 = []
        for inst_ite in self.inst_list:
            if '_2' in inst_ite.name or '_3' in inst_ite.name:
                table_col1.append(inst_ite)
            else:
                table_col0.append(inst_ite)

        self.place_vertically([self.x, self.y],table_col0)
        inst_x = self.x + table_col0[0].width + table_col0[0].spacing['right']
        inst_y = self.y
        self.place_vertically([inst_x, inst_y],table_col1)

    def place_tage_table(self):
        inst_dict = {'hi_us':self.find_inst('hi_us'), 'lo_us':self.find_inst('lo_us'), 'table_':self.find_inst('table_')}
        inst_dict['table_'].place_self([self.x, self.y], self.orientation)

        inst_dict['hi_us'].width = inst_dict['table_'].width
        inst_dict['hi_us'].inst_list[0].width = inst_dict['table_'].width

        inst_x = self.x
        inst_y = self.y + inst_dict['table_'].height + inst_dict['table_'].spacing['bottom']
        inst_dict['hi_us'].place_self([inst_x, inst_y], self.orientation)
        if 0==inst_dict['hi_us'].inst_list[0].get_sram_array_shape()[0]%2:
            inst_dict['hi_us'].reset_vertical_spacing('bottom')
        # else:            
        #     inst_dict['hi_us'].flip_ver()

        inst_dict['lo_us'].width = inst_dict['table_'].width
        inst_dict['lo_us'].inst_list[0].width = inst_dict['table_'].width

        inst_x = self.x
        inst_y = inst_dict['hi_us'].y + inst_dict['hi_us'].height + inst_dict['hi_us'].spacing['bottom']
        inst_dict['lo_us'].place_self([inst_x, inst_y], self.orientation)
        if 0!=inst_dict['lo_us'].inst_list[0].get_sram_array_shape()[0]%2:
            inst_dict['lo_us'].flip_ver()

    def place_tile(self):
        # Use self.height to denote chip height
        if 0 == self.height:
            raise ValueError('[@py_sram_placer]: Error. In {}, chip height is set to 0.'.format(self.name))
        
        inst_dict = {'dcache':self.find_inst('dcache'),'frontend':self.find_inst('frontend'),'core':self.find_inst('core'),'ptw':self.find_inst('ptw')}

        # Place D-cache
        inst_dict['dcache'].place_self([self.x, self.y], self.orientation)
        inst_y = self.y + self.height - inst_dict['dcache'].height
        inst_dict['dcache'].shift_inst([0,inst_y])

        # Place FrontEnd
        inst_dict['frontend'].place_self([self.x, self.y], self.orientation)

        # Place Page Table Walker
        inst_x = self.x + self.base.spacing_dr['Inter-Instance']
        inst_y = inst_dict['dcache'].y - self.base.spacing_dr['Inter-Stage']
        inst_dict['ptw'].place_self([self.x, inst_y], self.orientation)
        inst_dict['ptw'].shift_inst([inst_dict['ptw'].width + self.base.spacing_dr['Inter-Instance'], -inst_dict['ptw'].height - max(inst_dict['dcache'].spacing['top'], inst_dict['ptw'].spacing['bottom']) ])

        # Place Reorder Buffer
        inst_x = inst_dict['frontend'].x + self.base.round_up(inst_dict['frontend'].width/2)
        inst_y = inst_dict['frontend'].y + inst_dict['frontend'].height + 4*self.base.spacing_dr['Inter-Stage'] 
        inst_dict['core'].place_self([inst_x, inst_y], self.orientation)
        # inst_dict['core'].shift_inst([-inst_dict['core'].width, 0])

    def place_vertically(self, origin_xy:list, inst_list_arg:list):
        if not origin_xy:
            raise ValueError('[@py_sram_placer]: Error. Empty origin coordinate.')
        if not any(inst_list_arg):
            raise ValueError('[@py_sram_placer]: Error. Empty list.')
        if len(origin_xy)<2:
            raise ValueError('[@py_sram_placer]: Error. Not a 2D coordinate.')

        inst_x = origin_xy[0]
        inst_y = origin_xy[1]
        bottom_spacing = 1e6
        tmp_w=self.width
        for inst_ite in inst_list_arg:
            inst_ite.width = tmp_w
            if None != self.slots:
                inst_ite.slots = self.slots
            # if 'components_1'== self.name and 'tables_2' == inst_ite.name:
            #     inst_y += self.base.spacing_dr['Inter-Instance']
            if 'dcache' == self.name:
                inst_y += 3 * self.base.spacing_dr['Cell Spacing'][0] + 2 * self.base.spacing_dr['BUF Height']
            inst_ite.place_self([inst_x, inst_y], self.orientation)
            if inst_ite.spacing['top'] > bottom_spacing:
                diff = inst_ite.spacing['top'] - bottom_spacing
                inst_y += diff
                inst_ite.shift_inst([0, diff])
            inst_y += inst_ite.spacing['bottom'] + inst_ite.height
            bottom_spacing = inst_ite.spacing['bottom']
            if 'dcache' in self.path:
                tmp_w=inst_ite.width

    def plot_self(self,ax):
        if 'components_1' == self.name:
            self.plot_self_symbol(ax,'#B0B0B0')
        elif 'components_2' == self.name:
            self.plot_self_symbol(ax,'#B0B0B0')
        elif 'components_4' == self.name:
            self.plot_self_symbol(ax,'#B0B0B0')
        elif self.name in ['l2', 'dcache', 'icache', 'ftq', 'rob', 'ptw'] or 'banked_predictors_' in self.name:
            self.plot_self_symbol(ax,'#C0C0C0')

        for inst_ite in self.inst_list:
            inst_ite.plot_self(ax)

    def plot_self_symbol(self, ax, color):
        rect = Rectangle( xy=(self.x, self.y),
                                 width=self.width,
                                 height=self.height,
                                 edgecolor=color,
                                 linestyle='--',
                                 fill=False)
        ax.add_patch(rect)

    def set_inst_spacing(self):
        self.spacing = {'top':0, 'bottom':0, 'left':0, 'right':0}
        for inst_ite in self.inst_list:
            if (inst_ite.y-inst_ite.spacing['top']) < (self.y - self.spacing['top']):
                self.spacing['top'] = inst_ite.spacing['top']

            if (inst_ite.y + inst_ite.height + inst_ite.spacing['bottom']) > (self.y + self.height + self.spacing['bottom']):
                self.spacing['bottom'] = inst_ite.spacing['bottom']

            if (inst_ite.x-inst_ite.spacing['left']) < (self.x - self.spacing['left']):
                self.spacing['left'] = inst_ite.spacing['left']

            if (inst_ite.x + inst_ite.width + inst_ite.spacing['right']) > (self.x + self.width + self.spacing['right']):
                self.spacing['right'] = inst_ite.spacing['right']        
    
    def reset_horizontal_spacing(self,edge:str):
        closer_spacing = 2 * self.base.spacing_dr['Cell Spacing'][0] + self.base.spacing_dr['BUFx24 Width'] # BUFx2 is cubic

        if 'left' == edge or 'right' == edge:
            self.spacing[edge] = closer_spacing
            if 1==len(self.inst_list):
                if list==type(self.inst_list[0]):
                    if 1==len(self.inst_list[0]):
                        self.inst_list[0][0].reset_horizontal_spacing(edge)
                else:
                    self.inst_list[0].reset_horizontal_spacing(edge)
        else:
            raise ValueError('[@py_sram_placer]: Invalid index for spacing dict.')

    def reset_vertical_spacing(self,edge:str):
        closer_spacing = 2 * self.base.spacing_dr['Cell Spacing'][1] + self.base.spacing_dr['BUFx24 Width'] # BUFx2 is cubic

        if 'top' == edge or 'bottom' == edge:
            self.spacing[edge] = closer_spacing
        else:
            raise ValueError('[@py_sram_placer]: Invalid index for spacing dict.')

    def shift_inst(self,shift:list):
        if len(shift) != 2 or not any(shift):
            raise ValueError('[@py_sram_placer]: Error. The shift vector is empty or invalid.')

        self.x += shift[0]
        self.y += shift[1] 
        for inst_ite in self.inst_list:
            inst_ite.shift_inst(shift)

    def test_print_info(self):
        print('Instance: {0}, Position: {1}, Size: {2:.2f} by {3:.2f}, #Sub-Inst: {4}'.format(self.name, [self.x, self.y], self.width, self.height, self.get_inst_count()))
        for inst_ite in self.inst_list:
            inst_ite.test_print_info()
            
        if 'dataArrayWay_' in self.name:
            print('Name: {}; Spacing: {}'.format(self.name, self.spacing))
#=================================================================#
#                                                                 #
#=================================================================#
class SRAM_PLACER:
    # Protected
    _system_parent = 'ChipTop'
    _system_inst = None
    _system_top = 'system'

    def __init__(self, arg_list:List[str] = []):
        #=======Available Arguments=======#
        # -sram_list or -s: str
        #   The file containing list of SRAM instances in the design. It must be a file name
        # -mems_v or -m: str
        #   Verilog file that defines SRAM modules. We use it to find SRAM module names and get the SRAM in the library. Must be 
        #   a file name
        # -yaml or -y: str
        #   The path of the output .yml config file.
        # -config or -c: str
        #   Config name of the design
        # -lef_dir or -lef: str
        #   The directory that holds all the SRAM LEF files. Default directory will be used if not specified
        #=================================#
        self.base = SRAM_BASE(arg_list = arg_list)
        # breakpoint()
        # Instance for test. 'tu' => Test Unit
        if self.base.test_mode:
            self.tu_parent = 'ChipTop/system/tile_prci_domain/tile_reset_domain/boom_tile/frontend/bpd/banked_predictors_0'
            self.tu_inst = None
            self.tu_top = 'components_1'
        else:
            self.tu_parent = self._system_parent
            self.tu_inst = None
            self.tu_top = self._system_top

        self.brp = [0,0]

    def build_hierarchy_tree(self):
        with open(self.base.sram_list_file,'r') as fin:
            # Initialize tree with SRAM list
            for line in fin:
                line = line.replace('\n','')
                if self.tu_top in line:
                    # print('-@-@-{}'.format(line))
                    if None == self.tu_inst:
                        self.tu_inst = Hie_Inst(line, self.tu_parent, 'my', self.base)
                    else:
                        self.tu_inst.add_sram(path_str=line)

    def place_srams(self):
        # print(tu_inst.get_inst_count())
        self.tu_inst.place_self([self.base.spacing_dr['Block to Edge'], self.base.spacing_dr['Block to Edge']], 'my')

        if not self.tu_inst.check_align():
            raise ValueError('[@py_sram_placer]: Existing unaligned SRAM')

        # Bottom Right Point (brp)
        self.brp = [ 
            self.tu_inst.x + self.base.chip_width_scale * self.tu_inst.width + self.base.spacing_dr['Block to Edge'], 
            self.tu_inst.y + self.tu_inst.height + self.base.spacing_dr['Block to Edge']
        ]

    def write_placement_to_file(self, for_opt:bool = False):
        place_cons = [{
                        'path': "ChipTop",
                        'type': 'toplevel',
                        'x':0,
                        'y':0,
                        'width':self.base.chip_width_scale * self.brp[0],
                        'height':self.brp[1],
                        'margins': {'top':0, 'bottom':0, 'left':0, 'right':0}
                    }] + self.tu_inst.get_inst_placement()

        vlsi_config = {'vlsi.inputs.placement_constraints': place_cons}
                        
        with open( self.base.yaml_path,'w') as fout:
            yaml.dump(vlsi_config, fout)
            del vlsi_config

        self.base.write_floorplan_tcl(place_cons)

        if not for_opt:
            self.base.write_pin_tcl(place_cons)
        del place_cons

        if self.base.test_mode:
            print('Tcl and YAML written out.')

    def replace_placement_in_json(self,json_file:str):
        place_cons = [{
            'path': "ChipTop",
            'type': 'toplevel',
            'x':0,
            'y':0,
            'width':round(self.base.chip_width_scale * self.brp[0], 3),
            'height':round(self.brp[1], 3),
            'margins': {'top':0, 'bottom':0, 'left':0, 'right':0}
        }] + self.tu_inst.get_inst_placement()

        with open(json_file,'r+') as fp:
            hammer_config = json.load(fp)
            hammer_config['vlsi.inputs.placement_constraints'] = place_cons
            fp.seek(0)
            json.dump(hammer_config,fp)

    def plot_placement_and_save(self):
        fig, ax = plt.subplots()
        plt.plot([self.brp[0]], [self.brp[1]],'b+')
        plt.plot([self.brp[1]], [self.brp[1]],'k.')
        self.tu_inst.plot_self(ax)
        plt.gca().invert_yaxis()

        if self.base.test_mode:
            plt.savefig('{}_{}.pdf'.format(self.base.conf_name_global, self.tu_top))
        else:
            plt.savefig('{}_{}.png'.format(self.base.conf_name_global, self.tu_top), dpi=400)

        print('SRAM Layout saved.')

    def run_placer(self, for_opt:bool = False, json_file:str = ''):
        if for_opt and [] == self.base.arg_list:
            raise ValueError('[@py_sram_placer]: No argument string specified.')
        elif not for_opt and 1 == len(sys.argv):
            raise ValueError('[@py_sram_placer]: No command line arguments specified.')

        self.build_hierarchy_tree()
        self.place_srams()

        if not json_file:
            self.write_placement_to_file(for_opt)
        else:
            self.replace_placement_in_json(json_file)

        if self.base.test_mode:
            self.plot_placement_and_save()

    def set_test_mode(self):
        self.base.test_mode = True

    def unset_test_mode(self):
        self.base.test_mode = False

def preset_args(empty:bool):
    if empty:
        return []

    CONF="MegaBoom" # 'SmallBoom', 'MediumBoom', 'LargeBoom', 'MegaBoom', 'GigaBoom'
    # BACKUP_DIR="/export/home/yyzhao/vm/shared/workspace/chipyard/vlsi/backup"
    BACKUP_DIR="/export/home/yyzhao/vm/shared/workspace/chipyard/vlsi/backup"
    SRAM_List="{0}/{1}-run-backup/build/chipyard.TestHarness.{1}Config-ChipTop/syn-rundir/sram_list.txt".format(BACKUP_DIR,CONF)
    MEMS_V="{0}/{1}-run-backup/generated-src/chipyard.TestHarness.{1}Config/chipyard.TestHarness.{1}Config.top.mems.v".format(BACKUP_DIR,CONF)
    YAML="./{}_sram_place0.yml".format(CONF)
    # LEF_DIR='/export/home/yyzhao/vm/shared/workspace/chipyard/.conda-env/lib/python3.9/site-packages/hammer/technology/asap7/sram_compiler/memories/lef'
    LEF_DIR='/export/home/yyzhao/vm/shared/workspace/chipyard/.conda-env/lib/python3.9/site-packages/hammer/technology/asap7/sram_compiler/memories/lef'
    #'{}/technology/asap7/sram_compiler/memories/lef'.format(os.environ['HAMMER_VLSI'])
    return [
        os.path.basename(__file__),
        '-s', SRAM_List,
        '-m', MEMS_V,
        '-y', YAML,
        '-c', CONF,
        '-lef', LEF_DIR
    ]

if __name__ == "__main__":
    arg_list=[] #preset_args(0)
    sp = SRAM_PLACER(arg_list)
    sp.run_placer([]!=arg_list)
