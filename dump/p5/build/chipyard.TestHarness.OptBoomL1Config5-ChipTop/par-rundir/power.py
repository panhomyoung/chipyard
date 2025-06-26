import sys
import re


def parse_layer_info(lef_path: str, layer: str):
    direction = None
    pitch = None
    minwidth = None
    with open(lef_path, 'r') as f:
        for line in f:
            if re.match(r"\s*LAYER\s+{}".format(layer), line):
                break
        else:
            raise ValueError(f"Layer {layer} not found in {lef_path}")
        for line in f:
            if line.strip().startswith('END'):
                break
            tokens = line.strip().split()
            if not tokens:
                continue
            if tokens[0] == 'DIRECTION':
                direction = tokens[1]
            elif tokens[0] == 'PITCH':
                try:
                    pitch = float(tokens[1])
                except ValueError:
                    pass
            elif tokens[0] == 'MINWIDTH':
                try:
                    minwidth = float(tokens[1])
                except ValueError:
                    pass
    if direction is None or pitch is None:
        raise ValueError(f"Unable to parse layer info for {layer}")
    return direction, pitch, minwidth


def generate_power_straps_tcl(layer: str, direction: str, pitch: float, out_path: str):
    width = pitch * 2.8
    spacing = pitch * 0.7
    set_to_set = pitch * 72
    start_offset = pitch * 3.5
    tcl = (
        f"add_stripes -create_pins 0 "
        f"-block_ring_bottom_layer_limit {layer} "
        f"-block_ring_top_layer_limit M1 "
        f"-direction {direction.lower()} "
        f"-layer {layer} -nets {{VSS VDD}} "
        f"-pad_core_ring_bottom_layer_limit M1 "
        f"-set_to_set_distance {set_to_set:.3f} "
        f"-spacing {spacing:.3f} -switch_layer_over_obs 0 "
        f"-width {width:.3f} "
        f"-area [get_db designs .core_bbox] "
        f"-start [expr [lindex [lindex [get_db designs .core_bbox] 0] 0] + {start_offset:.3f}]"
    )
    with open(out_path, 'w') as f:
        f.write(tcl + "\n")


def main():
    if len(sys.argv) < 3:
        print("Usage: power.py <lef_path> <output_tcl> [layer]", file=sys.stderr)
        sys.exit(1)
    lef_path = sys.argv[1]
    out_tcl = sys.argv[2]
    layer = sys.argv[3] if len(sys.argv) > 3 else 'M3'
    direction, pitch, _ = parse_layer_info(lef_path, layer)
    generate_power_straps_tcl(layer, direction, pitch, out_tcl)


if __name__ == '__main__':
    main()