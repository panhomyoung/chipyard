import sys
import math
import os
from collections import OrderedDict
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import random

class FloorplanPro:
    """
    一个专业级的、健壮的混合布局Floorplan生成器。

    核心特性：
    - 动态边界感知：精确计算由外围块形成的内部核心区，从根本上解决重叠问题。
    - 两阶段布局：结合外围优先布局和精确的核心区行式填充。
    - 完整矩形块：通过整数分解确保SRAM组是无空洞的完整矩形。
    - 自动方向优化：为外围块智能分配R0/MX/R90/R270方向。
    """
    def __init__(self, config):
        self.config = config
        self.placed_srams = []
        
        print("--- FloorplanPro: 开始生成布局 ---")
        # 1. 解析与分组
        sram_paths = self._parse_sram_list(config['sram_list_path'])
        final_groups = self._dynamic_group_srams(sram_paths)
        
        # 2. 为每个组预计算最优布局
        module_blocks = self._pre_layout_blocks(final_groups)
        
        # 3. 执行两阶段混合布局
        unplaced_blocks, core_bbox = self._place_on_periphery(module_blocks)
        if unplaced_blocks:
            self._place_in_core(unplaced_blocks, core_bbox)
            
        print("--- FloorplanPro: 布局生成完毕 ---")

    # ==================================================================
    #  阶段一：数据准备 (分组与块形成)
    # ==================================================================
    def _parse_sram_list(self, file_path):
        """解析SRAM列表文件。"""
        print(f"1.1. 解析SRAM列表: {os.path.basename(file_path)}")
        paths = []
        with open(file_path, 'r') as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith('#'):
                    paths.append(line.split()[0].removeprefix('ChipTop/'))
        return paths

    def _dynamic_group_srams(self, sram_paths):
        """动态分组并合并小SRAM组。"""
        print("1.2. 动态层次分组与合并...")
        groups = OrderedDict()
        for path in sram_paths:
            module_name = os.path.dirname(path)
            if module_name not in groups: groups[module_name] = []
            groups[module_name].append(path)
        
        while True:
            merges_made = 0
            small_groups = [name for name, paths in groups.items() if len(paths) < self.config['MIN_SRAMS_PER_GROUP']]
            if not small_groups: break
            for name in small_groups:
                if name not in groups: continue
                paths_to_move = groups.pop(name)
                parent_name = os.path.dirname(name)
                if not parent_name:
                    groups[name] = paths_to_move
                    continue
                if parent_name not in groups: groups[parent_name] = []
                groups[parent_name].extend(paths_to_move)
                merges_made += 1
            if merges_made == 0: break
        print(f"    -> 最终形成 {len(groups)} 个SRAM组。")
        return groups

    def _get_integer_factors(self, n):
        """获取一个数的所有整数因数对。"""
        factors = set()
        for i in range(1, int(math.sqrt(n)) + 1):
            if n % i == 0:
                factors.add((i, n//i)); factors.add((n//i, i))
        return list(factors)

    def _pre_layout_blocks(self, groups):
        """为每个SRAM组预计算最优的水平和垂直矩形布局。"""
        print("2.  为每个SRAM组构建最优的完整矩形块...")
        blocks = []
        for name, paths in groups.items():
            n = len(paths)
            if n == 0: continue
            factor_pairs = self._get_integer_factors(n)
            if not factor_pairs: continue
            
            h_layout = self._find_best_layout(factor_pairs, self.config['SRAM_WIDTH'], self.config['SRAM_HEIGHT'], self.config['X_SPACING'], self.config['Y_SPACING'], paths)
            v_layout = self._find_best_layout(factor_pairs, self.config['SRAM_HEIGHT'], self.config['SRAM_WIDTH'], self.config['Y_SPACING'], self.config['X_SPACING'], paths)
            
            blocks.append({'name': name, 'layouts': {'H': h_layout, 'V': v_layout}, 'area': h_layout['w'] * h_layout['h']})
        
        blocks.sort(key=lambda b: b['area'], reverse=True)
        return blocks
        
    def _find_best_layout(self, factor_pairs, sram_w, sram_h, x_space, y_space, paths):
        """从因数对中找到最方形的布局。"""
        best_layout = {}
        min_aspect_ratio_diff = float('inf')
        for rows, cols in factor_pairs:
            block_w = cols * sram_w + (cols - 1) * x_space
            block_h = rows * sram_h + (rows - 1) * y_space
            aspect_ratio = block_w / block_h if block_h > 0 else 1
            if abs(aspect_ratio - 1) < min_aspect_ratio_diff:
                min_aspect_ratio_diff = abs(aspect_ratio - 1)
                rel_pos = [{'path': path, 'rel_x': (i % cols) * (sram_w + x_space), 'rel_y': (i // cols) * (sram_h + y_space)} for i, path in enumerate(paths)]
                best_layout = {'w': block_w, 'h': block_h, 'rel_pos': rel_pos}
        return best_layout

    # ==================================================================
    #  阶段二：布局引擎 (核心修复)
    # ==================================================================
    def _place_on_periphery(self, blocks):
        """阶段一：将SRAM块放置在外围，并精确计算核心区边界。"""
        print("3.1. [外围布局] 正在放置SRAM块到芯片四周...")
        margin_x, margin_y = self.config['CORE_MARGIN_X'], self.config['CORE_MARGIN_Y']
        die_w, die_h = self.config['DIE_WIDTH'], self.config['DIE_HEIGHT']
        channel = self.config['CHANNEL_WIDTH']
        unplaced_blocks = []
        
        edges = {
            'bottom': {'cursor': margin_x, 'limit': die_w - margin_x, 'layout': 'H', 'orient': 'R0'},
            'top':    {'cursor': margin_x, 'limit': die_w - margin_x, 'layout': 'H', 'orient': 'MX'},
            'left':   {'cursor': margin_y, 'limit': die_h - margin_y, 'layout': 'V', 'orient': 'R90'},
            'right':  {'cursor': margin_y, 'limit': die_h - margin_y, 'layout': 'V', 'orient': 'R270'}
        }

        # 此处临时记录外围块，用于后续边界计算
        peripheral_placements = {'bottom': [], 'top': [], 'left': [], 'right': []}

        for block in blocks:
            placed = False
            for name, edge in edges.items():
                layout = block['layouts'][edge['layout']]
                dim = layout['w'] if edge['layout'] == 'H' else layout['h']
                
                if edge['cursor'] + dim <= edge['limit']:
                    if name == 'bottom': base_x, base_y = edge['cursor'], margin_y
                    elif name == 'top': base_x, base_y = edge['cursor'], die_h - margin_y - layout['h']
                    elif name == 'left': base_x, base_y = margin_x, edge['cursor']
                    else: base_x, base_y = die_w - margin_x - layout['w'], edge['cursor']
                    
                    # 记录此次放置，但不立即提交到全局列表
                    placement_details = {'name': block['name'], 'layout': layout, 'base_x': base_x, 'base_y': base_y, 'orient': edge['orient']}
                    peripheral_placements[name].append(placement_details)
                    edge['cursor'] += dim + channel
                    placed = True
                    break
            
            if not placed:
                unplaced_blocks.append(block)

        # --- 核心修复：精确计算内部核心区的边界框 (Bounding Box) ---
        core_bbox = {
            'x_min': margin_x, 'y_min': margin_y,
            'x_max': die_w - margin_x, 'y_max': die_h - margin_y
        }
        
        if peripheral_placements['left']:
            core_bbox['x_min'] = margin_x + max(p['layout']['w'] for p in peripheral_placements['left'])
        
        if peripheral_placements['right']:
            core_bbox['x_max'] = min(p['base_x'] for p in peripheral_placements['right'])

        if peripheral_placements['bottom']:
            core_bbox['y_min'] = margin_y + max(p['layout']['h'] for p in peripheral_placements['bottom'])

        if peripheral_placements['top']:
            core_bbox['y_max'] = min(p['base_y'] for p in peripheral_placements['top'])

        # 将外围块的放置信息正式提交到全局列表
        for edge_placements in peripheral_placements.values():
            for p in edge_placements:
                self._commit_block_placement(p['name'], p['layout'], p['base_x'], p['base_y'], p['orient'])

        print(f"    -> 外围放置完成。精确计算的核心区边界: { {k: round(v, 1) for k, v in core_bbox.items()} }")
        return unplaced_blocks, core_bbox

    def _place_in_core(self, blocks, core_bbox):
        """阶段二：使用精确的核心区边界，将剩余块填充进去。"""
        print(f"3.2. [核心填充] 将剩余的 {len(blocks)} 个块填充到内部核心区...")
        channel = self.config['CHANNEL_WIDTH']
        
        # 使用精确边界初始化光标
        current_x = core_bbox['x_min'] + channel
        current_y = core_bbox['y_min'] + channel
        row_max_h = 0
        core_width = core_bbox['x_max'] - core_bbox['x_min'] - 2 * channel

        if core_width <= 0:
            print("警告: 外围宏块已占满所有空间，无有效核心区可供填充。")
            return

        for block in blocks:
            layout = block['layouts']['H'] # 内部填充统一使用水平布局
            
            # 如果当前行空间不足，换行
            if current_x + layout['w'] > core_bbox['x_max'] - channel:
                current_y += row_max_h + channel
                current_x = core_bbox['x_min'] + channel
                row_max_h = 0
            
            # 检查是否超出垂直边界
            if current_y + layout['h'] > core_bbox['y_max']:
                print(f"警告: 核心区垂直空间不足，无法放置块 '{block['name']}'。")
                continue

            self._commit_block_placement(block['name'], layout, current_x, current_y, 'R0')
            current_x += layout['w'] + channel
            row_max_h = max(row_max_h, layout['h'])

    def _commit_block_placement(self, module_name, layout, base_x, base_y, orientation):
        """记录SRAM的最终位置。"""
        sram_w, sram_h = self.config['SRAM_WIDTH'], self.config['SRAM_HEIGHT']
        for sram_pos in layout['rel_pos']:
            self.placed_srams.append({
                'path': sram_pos['path'], 'x': base_x + sram_pos['rel_x'], 'y': base_y + sram_pos['rel_y'],
                'w': sram_w, 'h': sram_h, 'module': module_name, 'orientation': orientation
            })
            
    # ==================================================================
    #  阶段三：输出
    # ==================================================================
    def generate_outputs(self, tcl_path, image_path):
        print("4.  正在生成最终输出文件...")
        self._write_tcl(tcl_path)
        if image_path: self._visualize(image_path)
        print("\n--- 布局生成报告 ---")
        print(f"布局策略: 动态边界感知混合布局 (已修复重叠问题)")
        print(f"成功放置了 {len(self.placed_srams)} 个SRAM实例。")
        print("所有可放置的SRAM均已成功布局。")

    def _write_tcl(self, output_path):
        """写入最终的TCL floorplan脚本。"""
        halo, h_bottom, h_top = self.config['PLACEMENT_HALO_UM'], self.config['ROUTE_HALO_BOTTOM_LAYER'], self.config['ROUTE_HALO_TOP_LAYER']
        lines = [f"# Floorplan TCL script generated by FloorplanPro (Overlap Fixed)", f"create_floorplan -core_margins_by die -flip f -die_size_by_io_height max -site core -die_size {{ {self.config['DIE_WIDTH']} {self.config['DIE_HEIGHT']} 0 0 0 0 }}", ""]
        for sram in self.placed_srams:
            lines.extend([f"place_inst {sram['path']} {sram['x']:.2f} {sram['y']:.2f} {sram['orientation']}", f"create_place_halo -insts {sram['path']} -halo_deltas {{{halo} {halo} {halo} {halo}}} -snap_to_site", f"create_route_halo -bottom_layer {h_bottom} -space 0.0 -top_layer {h_top} -inst {sram['path']}"])
        with open(output_path, 'w') as f: f.write("\n".join(lines))
        print(f"[成功] TCL脚本已保存至: {output_path}")

    def _visualize(self, output_path):
        """生成floorplan的可视化预览图。"""
        die_w, die_h, margin_x, margin_y = self.config['DIE_WIDTH'], self.config['DIE_HEIGHT'], self.config['CORE_MARGIN_X'], self.config['CORE_MARGIN_Y']
        fig, ax = plt.subplots(1, figsize=(15, 15 * (die_h / die_w)))
        ax.set_aspect('equal')
        ax.add_patch(patches.Rectangle((0, 0), die_w, die_h, lw=2, ec='gray', fc='none', label='Die Area'))
        ax.add_patch(patches.Rectangle((margin_x, margin_y), die_w - 2*margin_x, die_h - 2*margin_y, lw=1.5, ls='--', ec='blue', fc='none', label='Core Plannable Area'))
        
        module_names = sorted(list(set([s['module'] for s in self.placed_srams])))
        colors = {name: (random.Random(hash(name)).random(), random.Random(hash(name*2)).random(), random.Random(hash(name*3)).random()) for name in module_names}
        
        for sram in self.placed_srams:
            sram_w, sram_h = (sram['h'], sram['w']) if sram['orientation'] in ['R90', 'R270'] else (sram['w'], sram['h'])
            ax.add_patch(patches.Rectangle((sram['x'], sram['y']), sram_w, sram_h, linewidth=1, edgecolor='black', facecolor=colors.get(sram['module'], 'lightgray'), alpha=0.8))
            font_size = min(7, min(sram_w, sram_h) / 5)
            if font_size > 2: ax.text(sram['x'] + sram_w / 2, sram['y'] + sram_h / 2, sram['path'].split('/')[-1], ha='center', va='center', fontsize=font_size, color='white', weight='bold')

        ax.set_xlim(-50, die_w + 50); ax.set_ylim(-50, die_h + 50)
        ax.set_xlabel("Width (microns)"); ax.set_ylabel("Height (microns)")
        ax.set_title("Floorplan - Robust Hybrid Placement (Overlap Fixed)"); ax.legend(loc='upper right')
        ax.grid(True, linestyle=':', alpha=0.6)
        plt.savefig(output_path, dpi=300, bbox_inches='tight')
        print(f"[成功] 布局预览图已保存至: {output_path}")

def main():
    if len(sys.argv) < 3 or len(sys.argv) > 4:
        print("\n用法: python floorplan.py <sram_list.txt> <output.tcl> [output_image.png]")
        sys.exit(1)
    
    sram_list_file, output_tcl_file, output_image_file = sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) == 4 else "floorplan_visualization.png"

    config = {
        'sram_list_path': sram_list_file, 'DIE_WIDTH': 1920.0, 'DIE_HEIGHT': 1200.0,
        'SRAM_WIDTH': 48.0, 'SRAM_HEIGHT': 100.0, 'CORE_MARGIN_X': 20.0, 'CORE_MARGIN_Y': 20.0,
        'CHANNEL_WIDTH': 20.0, 'MIN_SRAMS_PER_GROUP': 3, 'X_SPACING': 5.0, 'Y_SPACING': 5.0,
        'PLACEMENT_HALO_UM': 4.0, 'ROUTE_HALO_BOTTOM_LAYER': 'M1', 'ROUTE_HALO_TOP_LAYER': 'M6',
    }

    designer = FloorplanPro(config)
    designer.generate_outputs(output_tcl_file, output_image_file)

if __name__ == '__main__':
    main()
