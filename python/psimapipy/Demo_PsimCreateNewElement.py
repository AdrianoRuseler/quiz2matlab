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

    print("Create new schematic files in the script which includes a parameter file, a subcircuit and several elements.")


    # This function creates a subcircuit. Filepath is the circuit's full path. it creates a schematic  with one Inductor, one Capacitor and 4 ports.
    def MakeSubBuck1(psimObj, filePath):
        #create a new schamatic file:   sch    
        sch = psimObj.PsimFileNew()

        # Set the size of subcircuit.   4 X 7  would allow 3 ports on top and bottom and 6 ports on right and left
        psimObj.PsimSetElmValue(sch, None, "SUBCIRCUITSIZE", "4,7");
    
        #Add an Inductor with name L1,  with ports at: (230,80) (280,80),  With following values:  Inductance is  avariable "Lvalue", Current Flag and Voltage Flag are set to 1
        psimObj.PsimCreateNewElement(sch, "L",  "L1", PORTS="{230, 80, 280, 80}", DIRECTION=0, Inductance="Lvalue",  CurrentFlag ="1", VoltageFlag ="1")

        # Add a Capacitor  with name C1,  with ports at: (230,80) (280,130), Rotated 90 degrees (Direction =90) .  Capacitance is 0.0001
        psimObj.PsimCreateNewElement(sch, "C",  "C1", PORTS="{280, 80, 280, 130}", DIRECTION=90, Capacitance=0.0001);
            

        # Subcircuit has 4 Bi-Directional ports:  "PORT BIDIR". Other possibilities: "SIGNALIN", "SIGNALOUT"
        psimObj.PsimCreateNewElement(sch, "PORT", "in+" , SUBTYPE="BIDIR", LOCATION="LEFT1",    PORTS="{220, 80}",   DIRECTION=0);
        psimObj.PsimCreateNewElement(sch, "PORT", "in-" , SUBTYPE="BIDIR", LOCATION="LEFT6",    PORTS="{220, 130}", DIRECTION=0);
        psimObj.PsimCreateNewElement(sch, "PORT", "o+"  , SUBTYPE="BIDIR", LOCATION="RIGHT1", PORTS="{300, 80}",   DIRECTION=180);
        psimObj.PsimCreateNewElement(sch, "PORT", "o-"  , SUBTYPE="BIDIR", LOCATION="RIGHT6", PORTS="{300, 130}", DIRECTION=180);
            


        #Adding wires
        psimObj.PsimCreateNewElement(sch, "WIRE", "", X1="220", Y1="130", X2="280", Y2="130"    );
        psimObj.PsimCreateNewElement(sch, "WIRE", "", X1="280", Y1="130", X2="300", Y2="130"    );
        psimObj.PsimCreateNewElement(sch, "WIRE", "", X1="280", Y1="80" , X2="300", Y2="80"     );
        psimObj.PsimCreateNewElement(sch, "WIRE", "", X1="220", Y1="80" , X2="230", Y2="80"     );

        # save the file
        print(f"save the subcircuit file: {filePath}")
        psimObj.PsimFileSave(sch, filePath) 




    
# ----------------- PsimFileNew
    schObjNew = p1.PsimFileNew()
    if(schObjNew):
       # Add a Simulation control at location (100, 40) . define TIMESTEP, TOTALTIME. Other possible parameters: PRINTTIME, PRINTSTEP, SAVEFLAG, LOADFLAG
        p1.PsimCreateNewElement(schObjNew, "SIMCONTROL",  "", POINT="{130, 40}", TIMESTEP="1E-005",  TOTALTIME="0.01" );     
		
        #Add a parameter file	 at location (40, 40) . Set file name as  para-main.txt in the local directory (Directory where this script file resides). 
        param_file_text = "Vin = 12V; \n R1 = 5; \n R2 = 10; \n "
        p1.PsimCreateNewElement(schObjNew, ".FILE",  "FILE1", POINT="{40, 40}", FileName=str_sample_folder + "para-main.txt",  DIRECTION=0 );     

        with open(str_sample_folder + "para-main.txt", 'w') as file2:
            # Write some text to the parameter file that we just created
            file2.write(param_file_text)


		# Add some text
        p1.PsimCreateNewElement(schObjNew, "TEXT",  "One-Quadrant DC/DC Circuit", POINT="{250, 30}" );     

		# Add VDC element.  First port location and Direction are enough to locate the element.  Amplitude is set to the variable 'Vin'
        p1.PsimCreateNewElement(schObjNew, "VDC",  "V1", PORTS="{120, 100}", DIRECTION=0, Amplitude ="Vin");                             	

		#Add a Ground element.  First port location and Direction are enough to locate the element. 
        p1.PsimCreateNewElement(schObjNew, "Ground",  "Ground_1", PORTS="{120, 150}", DIRECTION=0 );                        	
 
		#Add a MOSFET element.  First port location and Direction are enough to locate the element.
        p1.PsimCreateNewElement(schObjNew, "MOSFET",  "MOS1", PORTS="{150, 100}", DIRECTION=270 );                        	


        p1.PsimCreateNewElement(schObjNew, "GATING",  "G0", PORTS="{180, 170}", DIRECTION=0, Frequency=5000, NoOfPoints=2, Switching_Points="0,180" );
		
        p1.PsimCreateNewElement(schObjNew, "DIODE",  "D1", PORTS="{220, 150}", DIRECTION=270, );                        	

        # create a new schematic file set the Filename to "buck-script-sub.psimsch"
        MakeSubBuck1(p1, str_sample_folder + "buck-script-sub.psimsch")

        # First port location (in+) and Direction are enough to locate the element alternatively  AREA={270, 90, 310, 160} could be used too. (AREA={ Left, Top, Right, Bottom}) 
		#  Parameter  Lvalue is also being passed to the subcircuit
        p1.PsimCreateNewElement(schObjNew, "SUBCIRCUIT", "", SCHEMATIC=str_sample_folder + "buck-script-sub.psimsch", NAME="S3", POINT="{290, 120}", Direction="0", Lvalue=0.002   );

        p1.PsimCreateNewElement(schObjNew, "R",  "Ro", PORTS="{370, 100}", DIRECTION=90, Resistance=15, VoltageFlag = 1);

        p1.PsimCreateNewElement(schObjNew, "VP",  "Vo1", PORTS="{370, 100}", DIRECTION=0, );                        	
  
    	#Adding wires
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="200", Y1="100", X2="220", Y2="100"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="180", Y1="120", X2="180", Y2="170"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="120", Y1="150", X2="220", Y2="150"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="120", Y1="100", X2="150", Y2="100"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="220", Y1="100", X2="270", Y2="100"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="220", Y1="150", X2="270", Y2="150"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="310", Y1="100", X2="370", Y2="100"    );
        p1.PsimCreateNewElement(schObjNew, "WIRE", "", X1="310", Y1="150", X2="370", Y2="150"    );
    
  
  
        p1.PsimCreateNewElement(schObjNew, "TEXT",  "This circuit, including its sub-circuit was built with PSIM-Python script.", POINT="{250, 250}" );     
  
  
        #Save the circuit  and close file handle
        p1.PsimFileSave(schObjNew, str_sample_folder + "buck-script.psimsch")
        s1 = str_sample_folder + "buck-script.psimsch"
        print(f"save the circuit file: {s1}")

input("All done. Press the 'Enter' key to continue...");
 