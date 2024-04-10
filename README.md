## STRUCTURE

### Datatypes including sipmhit
├── dtypes
│   └── dtypes.vhdl

### Filter containing trapezoidal
├── filter
│   └── filter.vhdl

### Simulated Frontend reading in Sipmhit from CSV converting it to vhdl Dtype
├── readtxt
│   ├── data.csv
│   ├── ghdlcomp.sh
│   ├── readtxt.vhdl
│   ├── sipm1data0_ev4_dig.csv
│   ├── sipm2data0_ev4_dig.csv
│   ├── text.txt
│   └── Untitled.ipynb
├── template.vhdl

### Top and TB entity
├── testbench
│   └── top_tb.vhdl
└── top
    └── top.vhdl


## LOG

### 10.04.24
- Created Gitrepo
- TODO: Implement Filter Submodules
- Write Compile Methods for multiple Entities
- Connect Filter Generics to system-wide parameters
