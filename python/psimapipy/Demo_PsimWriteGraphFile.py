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


    # Generate some test data
    nColCount = 3
    nRowCount = int(12/0.001)
    # three curves
    Names = []
    Names.append("Time")
    Names.append("TimeCube")
    Names.append("Parabola")

    # Create arrays for double values
    Time = []
    Time3 = []
    Parabola = []

    for i in range(0, nRowCount):
        v = 0.001 * i
        Time.append(v)
        Time3.append(v**3)
        Parabola.append(v**2 - 5*v + 3)

    curves = []
    curves.append(Time);
    curves.append(Time3)
    curves.append(Parabola)

# ----------------- PsimWriteGraphFile 

    res = p1.PsimWriteGraphFile(str_sample_folder + "graphs\\Test_Data.smv", nColCount, nRowCount, Names, curves)
    if res != 0:
        s1 = str_sample_folder + "graphs\\Test_Data.smv"
        print(f"File was created:  {s1}")

    res = p1.PsimWriteGraphFile(str_sample_folder + "graphs\\Test_Data.mat", nColCount, nRowCount, Names, curves)
    if res != 0:
        s1 = str_sample_folder + "graphs\\Test_Data.mat"
        print(f"File was created:  {s1}")

    res = p1.PsimWriteGraphFile(str_sample_folder + "graphs\\Test_Data.txt", nColCount, nRowCount, Names, curves)
    if res != 0:
        s1 = str_sample_folder + "graphs\\Test_Data.txt"
        print(f"File was created:  {s1}")

    res = p1.PsimWriteGraphFile(str_sample_folder + "graphs\\Test_Data.csv", nColCount, nRowCount, Names, curves)
    if res != 0:
        s1 = str_sample_folder + "graphs\\Test_Data.csv"
        print(f"File was created:  {s1}")


    p1.RunSimview(str_sample_folder + "graphs\\Test_Data.mat", "TimeCube", "Parabola", "TimeCube - Parabola");

    os.startfile(str_sample_folder + "graphs\\")

input("Press the 'Enter' key to continue...");


    