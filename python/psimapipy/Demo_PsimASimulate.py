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


    print("Run 100 simulations in multiple threads. Limit the maximum concurrent threads to 35")
    print("First simulation would give an error because R is zero")

    #Run simulation in multiple threads
    # two methods to build simulation data for PsimASimulate:  SimulateData_from_dict  and  SimulateData_from_kwargs
    simData = []
    X1 = []
    i = 0
    while( i < 100):
        r1 = 0.25 * i  #first simulation would give an error because R is zero
        c1 = (50 + i) * 1e-6
        fsw1 = (150 + (i * 10)) * 1000
        d3 = dict(Simview=0, C = c1, R = r1, Fsw=fsw1, L=50e-6)
        d3.update({"Vin": i * 1.0})
        strSimviewFile = f"{str_sample_folder}graphs\\Multithread_loop_{i+1}.txt"
# ----------------- SimulateData_from_dict        
        simData.append( p1.SimulateData_from_dict(str_sample_folder + "buck.psimsch", strSimviewFile, d3))
        X1.append(r1)
        i += 1

        r1 = 0.25 * i 
        c1 = (50 + i) * 1e-6
        fsw1 = (150 + (i * 10)) * 1000
        strSimviewFile = f"{str_sample_folder}graphs\\Multithread_loop_{i+1}.csv"
# ----------------- SimulateData_from_kwargs        
        simData.append( p1.SimulateData_from_kwargs(str_sample_folder + "buck.psimsch", strSimviewFile, Simview=0, C = c1, R = r1, Fsw=fsw1, L=5e-6, Vin=i*1.0 ))
        X1.append(r1)
        i += 1

    len1 = len(simData)
    #run PsimASimulate for 100 simulations but limit the concurrent threads to 35. Everytime a simulation ends, new one is started
# ----------------- PsimASimulate
    print("Start simulations...")
    result_ASim = p1.PsimASimulate(35, simData)
    print("...End simulations")
    len2 = len(result_ASim)

    print(f"len(simData)={len1},  len(result_ASim)={len2}. Each simData cell corresponds to a result_ASim cell")

    AllGraphs4 = []
    i = 0
    Y1 = []
    Y1_name = "Y1"
    nCount = len(result_ASim)
    while( i < nCount):
        res = result_ASim[i]
        if(res.Result == 0):
            print(res.ErrorMessage)
            Y1.append(0)
        else:
            g = res.Graph
            Y1_name = g[3].Name
            # take the second curve's steady state value (assume it is the last value of the curve)
            Y1.append(g[3].Values[g[3].Rows - 1])
            AllGraphs4.append(g);
        i += 1


   # Write a new graph file
    nColCount = 2
    nRowCount = nCount
    Names = ["R1", Y1_name]
    curves = [X1, Y1]
# ----------------- PsimWriteGraphFile    
    p1.PsimWriteGraphFile(str_sample_folder + "graphs\\R1_vs_Y1.smv", nColCount, nRowCount, Names, curves)
    s1 = str_sample_folder + "graphs\\R1_vs_Y1.smv"
    print(f"Write a secondary graph file from the results of 100 graphs:\n    {s1}")
    p1.RunSimview(str_sample_folder + "graphs\\R1_vs_Y1.smv", Y1_name);

    os.startfile(str_sample_folder + "graphs\\")


input("Press the 'Enter' key to continue...");

