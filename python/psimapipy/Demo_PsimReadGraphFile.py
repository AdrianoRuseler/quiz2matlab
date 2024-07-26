##
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

    s1 = str_sample_folder + "Accord_FluxM.mat"
    print(f"read the following file and show the last value of each curve: \n  {s1}");
    # read .mat file and show the last value of each curve
# ----------------- PsimReadGraphFile   
    res5 = p1.PsimReadGraphFile(str_sample_folder + "Accord_FluxM.mat")
    if(res5.Result == 0):
        print(res5.ErrorMessage)
    else:
        g_mat = res5.Graph
        nCount = len(g_mat)
        i = 0
        while( i < nCount):
            curve = g_mat[i]
            # take the last value of the curve)
            print(curve.Name + " => " + str(curve.Values[curve.Rows-1]) )  
            i += 1  


input("Press the 'Enter' key to continue...");
