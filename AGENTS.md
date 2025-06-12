Chipyard System Capabilities & Initial Setup Guide

This document provides an automated agent (e.g., an AI code generation model like Codex) with a comprehensive overview of the Chipyard SoC design framework. It is intended to help the agent understand its core capabilities, key components, workflow, and how to interact with it for automation purposes.

1. System Overview
Chipyard is an open-source, agile System-on-Chip (SoC) design, simulation, and implementation framework. It is based on the Chisel hardware construction language and integrates a complete flow, from high-level RTL design to GDSII physical layout generation.

Core Philosophy:

Agile Development: To rapidly iterate, configure, and generate complex SoC designs.
Parameterization: To leverage the power of the Scala language to create highly configurable and reusable hardware components.
Integration: To provide an end-to-end, out-of-the-box toolchain from functional simulation to physical implementation.
For an AI agent, you can think of Chipyard as an "SoC Factory". Your task is to provide the correct "blueprint" (configuration files) to this factory, and it will automatically produce the corresponding digital circuit design (Verilog), simulation models, and even the physical layout (GDSII).

2. Core Components & Technology Stack
Chipyard itself is the "glue" that integrates several powerful tools and components developed by the Berkeley Architecture Research (BAR) group.

Component	Technology	Role & Capability
Chisel	Scala	Hardware Construction Language. Unlike Verilog/VHDL, it's not a static description language, but a program that "generates" circuits using Scala code. This is the key to achieving high parameterization.
FIRRTL	-	Intermediate Representation (IR). Chisel code is first compiled into FIRRTL, a hardware IR similar to LLVM, which enables high-level circuit optimizations and transformations before final compilation to Verilog.
Rocket Chip	Chisel	SoC Generator. Provides a stable, validated, in-order single-issue RISC-V core (Rocket Core) and a complete SoC subsystem, including caches, a bus fabric (TileLink), and peripherals.
BOOM (Berkeley Out-of-Order Machine)	Chisel	High-Performance SoC Generator. Provides a parameterized, configurable, out-of-order execution RISC-V core, ideal for high-performance processor research.
TileLink	-	Coherent Bus Protocol. A bus protocol designed by Berkeley for connecting processor cores, caches, and peripherals, offering high flexibility and scalability.
Gemmini	Chisel	Systolic Array Generator. A framework for generating deep learning hardware accelerators (similar to Google's TPU) that can be seamlessly integrated into a Chipyard SoC.
FireSim	FPGA Simulation	FPGA-accelerated, cycle-exact simulation platform. Enables deploying Chipyard-generated designs onto cloud FPGAs (like Amazon F1) to achieve simulation speeds several orders of magnitude faster than software simulation.
Hammer	Python, TCL, YAML	VLSI Flow Management Tool. An abstraction layer for automatically invoking industry-standard EDA tools (e.g., Cadence, Synopsys) to complete the physical design flow from Verilog to GDSII (synthesis, place & route, DRC/LVS, etc.).

导出到 Google 表格
3. Core Capabilities
An agent can leverage Chipyard to perform the following core tasks:

3.1 SoC Generation & Customization
Core Selection: Choose between the stable, low-power Rocket core or the high-performance BOOM core.
Core Configuration: Precisely control nearly all microarchitectural parameters via Scala configurations, such as pipeline depth, cache size/structure, branch predictor type, etc.
Peripheral Addition: Easily add or remove standard peripherals like UART, SPI, GPIO, I2C, etc.
Accelerator Integration: Integrate custom hardware accelerators (like Gemmini or a user's own design) into the SoC via the TileLink bus.
Memory System: Configure multi-level caches, number of memory channels, and DRAM controllers.
3.2 Multi-level Simulation
Software Simulation (Verilator): Use the open-source Verilator simulator for cycle-exact functional simulation. This is the primary method for debugging RTL logic.
Commercial Tool Simulation (VCS/Questa): Supports integration with industry-standard simulators.
FPGA-Accelerated Simulation (FireSim): Used for large-scale, long-running simulations, such as booting a full operating system and running complex applications.
3.3 VLSI Physical Design Flow (ASIC Flow)
Automated Physical Implementation: Automatically transform the generated Verilog netlist into a physical layout using the Hammer framework.
Technology Portability: Hammer supports different Process Design Kits (PDKs) through technology plugins, including open-source ones like Skywater130 and ASAP7, and can be extended to support commercial PDKs (e.g., TSMC 28nm).
Complete Flow: Covers logic synthesis, place & route (P&R), clock tree synthesis (CTS), DRC/LVS checks, and finally generates a GDSII file ready for tapeout.
4. Initial Setup & Environment for AI Agents
To get an agent started, a standardized Chipyard environment needs to be established.

4.1 System Dependencies
Operating System: Ubuntu 18.04 / 20.04 (Recommended)
Core Tools: git, make, curl
Compiler/Build Tools: JDK 8/11, Mill, SBT (Scala Build Tool), Verilator (for simulation)
VLSI Tools: If running the physical flow, EDA tool suites from Cadence/Synopsys/Mentor are required.
4.2 Standard Installation Flow
The following is the standard command sequence for an agent's initial setup:

Bash

# 1. Clone the Chipyard repository and all its submodules
git clone https://github.com/ucb-bar/chipyard.git
cd chipyard
git checkout <stable-version-tag> # Using a stable release tag is recommended over the main branch
./scripts/init-submodules.sh

# 2. Set up the environment
# This script installs all necessary dependencies (RISC-V toolchain, Verilator, etc.)
# Note: This can take a long time and may require sudo privileges.
./build-setup.sh riscv-tools esp-tools

# 3. Enter the Scala build environment to pre-cache dependencies
# The first run will download many dependencies and take a while.
source ./env.sh
mill chipyard.fpga.arty.arty-100t-freechips.test.DefaultTestHarness.fpga_build
4.3 Key Directory Structure
Key directories the agent needs to be aware of:

chipyard/: The top-level directory.
generators/: (Primary interaction directory) Contains the source code for all SoC configurations and generators.
chipyard/src/main/scala/config/: Core configuration area. Location of Config.scala files that define the SoC topology and parameters.
boom/: Source code for the BOOM core.
rocket/: Source code for the Rocket core.
sims/verilator/: The Verilator simulation directory. make sim is executed here.
vlsi/: (Physical design interaction directory) Contains the Hammer framework and all VLSI flow-related configuration files.
build-setup.sh, env.sh: Critical environment setup scripts.
5. Workflow for Automation
A typical end-to-end workflow for an agent interacting with Chipyard is as follows:

Phase 1: Design & Configuration
Target: Modify Scala Config files to define the SoC architecture.
Location: generators/chipyard/src/main/scala/config/Configs.scala (or a custom configuration file).
Action: The agent adjusts parameters by modifying or creating new Config classes. For example, selecting the core type, number of cores, cache sizes, etc.
Scala

// Example: A configuration with 2 BOOM cores
class MyDualBoomConfig extends Config(
  new boom.common.WithNBigCores(2) ++       // Overrides the core count to 2
  new chipyard.config.AbstractConfig)      // Inherits the base configuration
Phase 2: Generation & Simulation
Target: Compile the Scala configuration into Verilog and run a functional simulation.
Commands: Executed in the chipyard/sims/verilator directory:
Bash

# 1. Generate Verilog code (target Config is MyDualBoomConfig defined above)
make CONFIG=MyDualBoomConfig verilog

# 2. Compile the simulator
make CONFIG=MyDualBoomConfig

# 3. Run the simulation (e.g., running a test from riscv-tests)
make CONFIG=MyDualBoomConfig run-binary BINARY=../../tests/isa/rv64ui-p-simple
Output: Verilog code is placed in the generated-src directory. Simulation results are displayed on the terminal.
Phase 3: Physical Implementation
Target: Generate a GDSII file from the Verilog code using the Hammer flow.
Location: chipyard/vlsi/
Action:
Configure Hammer: Modify .yml files to specify the PDK, toolchain (Cadence/Synopsys), and design constraints (clock frequency, IO placement, etc.).
env.yml: EDA tool paths and licenses.
your-tech.yml: Details of the Process Design Kit (LEF, LIB, GDS, etc.).
your-design.yml: Design-specific constraints.
Execute Flow: Run the following in the vlsi directory:
Bash

# Specify your configuration, which must match the one used for Verilog generation
make CONFIG=MyDualBoomConfig buildfile # Links Verilog and constraints
make syn    # Logic Synthesis
make par    # Place & Route
make drc    # Design Rule Check
make lvs    # Layout vs. Schematic Check
Output: The final GDSII file will be located in a directory like build/.../par-rundir/.
6. Key Interfaces for Automation
Programmatic Configuration (Scala): The most powerful and flexible interface. Explore the design space by directly generating and modifying Config classes.
VLSI Configuration (YAML): Adjust physical design flow parameters by modifying YAML files, such as clock frequency, area/power targets, and layout dimensions.
Hammer Hooks (Python): Write Python callback functions for specific steps in the VLSI flow (e.g., init_design) to inject custom TCL commands, enabling fine-grained control over EDA tools.
Makefile/SBT/Mill: Drive the entire flow by invoking these build tools from the command line.
