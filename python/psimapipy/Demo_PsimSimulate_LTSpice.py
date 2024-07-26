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


#I(R1)
    def WriteCommaSepGraphFile(g1, FilePath):
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

    def FindGraphCol(g1, strColName):
        cols = len(g1)
        if cols > 0:
            for j in range(cols):
                if(str(g1[j].Name) == strColName):
                    return j
        return -1;

    AllGraphs = []
    
    # Run Simulation


    #use PsimSimulate_LTSpice with argument list
    Vin = 50;
# ----------------- PsimSimulate_LTSpice    Simview=0: do not open Simview after simulation. To open Simview set Simview=1
    res1 = p1.PsimSimulate_LTSpice(str_sample_folder + "buck.psimsch", str_sample_folder + "graphs\\buck3.raw", Simview=0, Vin=Vin, C = "500u", R = 2.5, Fsw="20k", L=5e-6)
    if(res1.Result == 0):
        print(res1.ErrorMessage)
    else:
        g1 = res1.Graph
        AllGraphs.append(g1);
        WriteCommaSepGraphFile(g1, str_sample_folder + "graphs\\buck3_csv.csv")
        s1 = str_sample_folder + "graphs\\buck3_csv.csv"
        print(f"File was created:  {s1}")
    
    #use PsimSimulate_LTSpice passing the variables with a dictionary object
    d2 = dict(Simview=0, C = "500u", R = 2.5, Fsw="20k", L=5e-6)
    d2.update({"Vin": 60})
# ----------------- PsimSimulate_LTSpice     Simview=0: do not open Simview after simulation. To open Simview set Simview=1
    res2 = p1.PsimSimulate_LTSpice(str_sample_folder + "buck.psimsch", str_sample_folder + "graphs\\buck3_d.raw", **d2)
    if(res2.Result == 0):
        print(res2.ErrorMessage)
    else:
        s1 = str_sample_folder + "graphs\\buck3_d.raw"
        print(f"File was created:  {s1}")
        g2 = res2.Graph
        AllGraphs.append(g2);
        i1 = FindGraphCol(g2, "V(Vout)");
        if(i1 != -1):
            last_value = g2[i1].Values[g2[i1].Rows-1];
            print(f"Last value of {g2[i1].Name} is : {last_value}")



    p1 = None;
input("Press the 'Enter' key to continue...");
 