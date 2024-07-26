###
## Altair PSIM - Sample Python script to test and exercise the Python API for PSIM
##
## This requires:
##  - Altair PSIM 2023.1 or higher
##  - Python 3.X  (this was developed using Python 3.8)
##  - psimapipy python wheel 

#----------------- Sample Script Start ----------------------------------

# [FD] This relies on the __init__.py file to load the class and functions defined explictly
from psimapipy import *
from pathlib import Path
import winreg
import os

# Initialize PSIM class with path to PSIM folder

strPSIM_folder_Path = "";
str_sample_folder = "";

# Get the directory of the current script
current_script_dir = os.path.dirname(os.path.realpath(__file__))

# Move two folders up
parent_of_parent_dir = os.path.abspath(os.path.join(current_script_dir, os.pardir, os.pardir))
# Check if 'PSIM.exe' exists in this directory
myfile_path = os.path.join(parent_of_parent_dir, 'PSIM.exe');
if os.path.isfile(myfile_path):
    strPSIM_folder_Path = parent_of_parent_dir; #prefer the current folder structure to path found in registry
#  if 'PSIM.exe' did not exists, the class will get the path from registry.

if len(str_sample_folder) == 0:
    str_sample_folder = current_script_dir + "\\PythonTest\\";

# [FD] Actual sample/example start here

print("Loading PSIM...");
p1 = PSIM(strPSIM_folder_Path)

# ----------------- IsValid
if(p1 and p1.IsValid()):

    
# ----------------- get_psim_version
    ver, subVer, subsubver, subsubsubver = p1.get_psim_version()


    print("Run 100 simulations in a loop")
    print("First simulation would give an error because R is zero")

    #Run simulation in a loop
    AllGraphs3 = []
    i = 0
    while( i < 100):
        r1 = 0.25 * i  #first simulation would give an error because R is zero
        d3 = dict(Simview=0, C = "50u", R = r1, Fsw="20k", L=5e-6)
        d3.update({"Vin": i * 1.0})
        strSimviewFile = f"{str_sample_folder}graphs\\Sim_1_loop_{i+1}.txt"
# ----------------- PsimSimulate        
        res3 = p1.PsimSimulate(str_sample_folder + "buck.psimsch", strSimviewFile, **d3)
        if(res3.Result == 0):
            print(res3.ErrorMessage)
        else:
            print(f"File was created:  {strSimviewFile}")
            g3 = res3.Graph
            AllGraphs3.append(g3);
        i += 1

    os.startfile(str_sample_folder + "graphs\\")

input("Press the 'Enter' key to continue...");
