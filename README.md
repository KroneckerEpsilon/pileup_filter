# STRUCTURE

## Analysis
.
├── analysis
│   ├── analysis.ipynb
│   ├── filter\_convolutional\_model.ipynb
│   ├── filter\_softwaresim.ipynb
### filter functions defined as .py
│   ├── sipm\_filters.py
### Auxilary Notebooks to handle the csv data
│   ├── digest.ipynb
│   └── to\_v.ipynb

## Firmware Part
├── FPGA
│   ├── downsampling
### Datatypes including sipmhit, dsphit etc. TODO: simulate fixed comma
│   ├── dtypes
### Filter containing trapezoidal
│   ├── filter
### Vivado Project
│   ├── firmware
### Simulated Frontend reading in Sipmhit from CSV converting it to vhdl Dtype
│   ├── readtxt
### Top and TB entity
│   ├── top
### old ghdl compilation and run method
│   ├── ghdl

├── README.md

