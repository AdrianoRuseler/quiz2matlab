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


 # read .raw file and vonvert to csv  
    s1 = str_sample_folder + "buck_raw_test.raw"
    print(f"read the following file and vonvert to csv: \n  {s1} ")
# ----------------- PsimReadGraphFile
    res = p1.PsimReadGraphFile(str_sample_folder + "buck_raw_test.raw")
    g1 = res.Graph

    FilePath = str_sample_folder + "buck_raw_test.csv";
    
    # Open the file in write mode
    with open(FilePath, "w") as f:
        cols = len(g1)
        if cols > 0:
            # Write all the PSIM_curve.Name values as comma separated in top line
            names = [curve.Name for curve in g1]
            f.write(",".join(names) + "\n")

            # Get the max length of Values array among all curves
            max_length =  max([curve.Rows for curve in g1])  #g1[0].Rows.value

            # Loop through the length and write each value of PSIM_curve.Values[i] in one line
            for i in range(max_length):
                values_line = []
                for j in range(cols):
                    # Append value if exists, else append an empty string for that PSIM_curve
                    values_line.append(str(g1[j].Values[i]))
                f.write(",".join(values_line) + "\n")
    
    print( f"Following file was created: {FilePath}" )


input("Press the 'Enter' key to continue...");
