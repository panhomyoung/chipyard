# --------------------------------------------------------------------------------
# This script was written and developed by HAMMER at UC Berkeley; however, the
# underlying commands and reports are copyrighted by Cadence. We thank Cadence for
# granting permission to share our research to help promote and foster the next
# generation of innovators.
# --------------------------------------------------------------------------------

create_clock clock_clock -name clock_clock -period 5000.0
set_clock_uncertainty 100.0 [get_clocks clock_clock]
set_clock_groups -asynchronous  -group { clock_clock }

