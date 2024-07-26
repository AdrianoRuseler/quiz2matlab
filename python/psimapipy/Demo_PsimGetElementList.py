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
import xml.etree.ElementTree as ET
from pathlib import Path
import winreg
import os
import webbrowser

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


    def WriteElementList_xml(element_List, filePath):
        # Create the root of our XML structure
        root = ET.Element('PSIM_Schematic_Elements')

        # Iterate over each My_Element object in the list
        for element in element_List:
            # Create the Element node and set its attributes
            element_node = ET.SubElement(root, 'Element', Type=element.Type, Name=element.Name, Index=str(element.Index))
            
            # Iterate over Params in the current My_Element object
            for param in element.Params:
                # Create the Param node and set its attributes
                ET.SubElement(element_node, 'Param', Name=param.Name, Value=param.Value)

        # Write the XML structure to the file
        tree = ET.ElementTree(root)
        tree.write(filePath, encoding="utf-8", xml_declaration=True)
        webbrowser.open(f'file://{filePath}')


    def WriteElementList_txt(element_List, filePath):
        with open(filePath, "w") as f:
            # Iterate over each My_Element object in the list
            for element in element_List:
                f.write("\n")
                if(element.Type == ".FILE"):
                    f.write(element.Type + "\n")
                    f.write("\t" + element.Params[0].Name + " = " + element.Params[0].Value + "\n") #Name
                    f.write("\t" + element.Params[1].Name + " = " + element.Params[1].Value + "\n") #File Name
                    f.write("\t" + element.Params[3].Name + " = " + element.Params[3].Value + "\n") #priority
                    f.write("--------File Contents - Begin------\n")
                    f.write(element.Params[2].Value + "\n")
                    f.write("--------File Contents - End--------\n\n")
                else:
                    f.write(element.Type + "\n")
                    # Iterate over Params in the current My_Element object
                    for param in element.Params:
                        f.write("\t" + param.Name + " = " + param.Value + "\n")


# open a schematic file
# ----------------- PsimFileOpen
    schObj = p1.PsimFileOpen(str_sample_folder + "buck.psimsch")
    if(schObj):

# ----------------- PsimGetElementList        
        elmList = p1.PsimGetElementList(schObj, 0)    
        if(elmList):
            WriteElementList_xml(elmList, str_sample_folder + "test3.xml")
            s1 = str_sample_folder + "test3.xml"
            print(f"File was created:  {s1}")

            WriteElementList_txt(elmList, str_sample_folder + "test3.txt")
            s1 = str_sample_folder + "test3.txt"
            print(f"File was created:  {s1}")

            #update element values using the Element list
# ----------------- PsimSetElmValue
            r1 = p1.PsimSetElmValue(schObj, elmList[5], "Capacitance", "1m")
            r1 = p1.PsimSetElmValue(schObj, elmList[6], "Resistance", "10k")
        
            #update element values using Element Type and Name
# ----------------- PsimSetElmValue
            r1 = p1.PsimSetElmValue2(schObj, "C", "C1", "Capacitance", "1.2m")
            r1 = p1.PsimSetElmValue2(schObj, "R", "R1", "Resistance", "11k")

            #Create a new parameter file element
# ----------------- PsimCreateNewElement                    
            p1.PsimCreateNewElement(schObj, ".FILE", "MyParamFile2", POINT="{(-100,20)", File=str_sample_folder + "p1.txt", Priority = 7)
            with open(str_sample_folder + "p1.txt", 'w') as file:
                # Write some text to the parameter file that we just created
                file.write(" Vin= 105; \n Fsw=20k; \n L=5e-6; \n")

            #Simulate the file using schematic ID instead of file path
            print("Simulate the file using schematic ID instead of file path.")
# ----------------- PsimSimulate
            res1 = p1.PsimSimulate(schObj, str_sample_folder + "graphs\\buck_schID.smv", Simview=0)
            if(res1.Result == 0):
                print(res1.ErrorMessage)
            else:
                s1 = str_sample_folder + "graphs\\buck_schID.smv"
                print(f"We ran a simulation and following graph file was created: \n      {s1}")
                g1 = res1.Graph

            #disable the MOSFET and Simulate again
# ----------------- PsimEnableElm2     
            print("\n Disable the MOSFET and Simulate again.")       
            r1 = p1.PsimEnableElm2(schObj, "MOSFET", "Q2", 0)
# ----------------- PsimSimulate    using PSIM_Schematic object
            res1 = p1.PsimSimulate(schObj, str_sample_folder + "graphs\\buck_schID_B.smv", Simview=0)
            if(res1.Result == 0):
                print("Expecting an error because we disabled the MOSFET:\n" + res1.ErrorMessage)
            else:
                g1 = res1.Graph
                
            #Enable the MOSFET and Simulate again
# ----------------- PsimEnableElm2  
            print("\n Enable the MOSFET and Simulate again.")                 
            r1 = p1.PsimEnableElm2(schObj, "MOSFET", "Q2", 1)
# ----------------- PsimSimulate     using PSIM_Schematic object         
            res1 = p1.PsimSimulate(schObj, str_sample_folder + "graphs\\buck_schID_C.smv", Simview=0)
            if(res1.Result == 0):
                print(res1.ErrorMessage)
            else:
                s1 = str_sample_folder + "graphs\\buck_schID_C.smv"
                print(f"We ran a simulation and following graph file was created: \n      {s1}")
                g1 = res1.Graph
            

# ----------------- PsimIsSubcircuit  using PSIM_Schematic object
            isSub = p1.PsimIsSubcircuit(schObj)

        # Save the circuit in a new file: buck_2.psimsch
# ----------------- PsimFileSave
        p1.PsimFileSave(schObj, str_sample_folder + "buck_2.psimsch")
        s1 = str_sample_folder + "buck_2.psimsch"
        print(f"Saving the modified schematic file to: \n     {s1}")


    p1 = None;

input("All done. Press the 'Enter' key to continue..."); 