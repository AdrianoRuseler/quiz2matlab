
%% Adicione a pasta com as funções na busca do MATLAB
pathtool % Adidione a pasta com as funções
% addpath('..\quiz2matlab\functions') % Folder with functions



%%  Test simulation with ngspice
% http://ngspice.sourceforge.net/download.html

[status,cmdout] = system('ngspice_con -v'); % Não abre Janela
disp(cmdout)

% ******
% ** ngspice-34 : Circuit level simulation program
% ** The U. C. Berkeley CAD Group
% ** Copyright 1985-1994, Regents of the University of California.
% ** Copyright 2001-2020, The ngspice team.
% ** Please get your ngspice manual from http://ngspice.sourceforge.net/docs.html
% ** Please file your bug-reports at http://ngspice.sourceforge.net/bugrep.html
% ** Creation Date: Jan 29 2021   17:13:07
% ******


%% PSIM

[status,cmdout] = system('PsimCmd');
disp(cmdout)
% 
% Copyright ® 2006-2020 Powersim Inc.  All Rights Reserved.
% 
% Usage: PsimCmd.exe -i "[input file]" -o "[output file]" -v "VarName1=VarValue"  -v "VarName2=VarValue"  -g -K1 -L1 -t "TotalTime" -s "TimeStep" -tv "SecondaryTimestepRatio" -pt "PrintTime" -ps "PrintStep" -Net "Netlist file name" -m "file name for errors" 
% 
% 
% Except input file, all other parameters are optional.
% All file names should be enclosed by " or ' characters.
% Command-line parameters:
%   -i :  Followed by input schematic file or Script file(.script).
%   -o :  Followed by output text (.txt) or binary (.smv) file.
%   -g :  Run Simview after the simulation is complete.
%   -t :  Followed by total time of the simulation.
%   -s :  Followed by time step of the simulation.
%   -DSED :  DSED (non-stiff) Solver. (DSIM only) 
%   -BDSED:  BDSED (stiff) Solver. (DSIM only) 
%   -mt :  Maximum time step. (DSIM only)
%   -nt :  Minimum time step. (DSIM only)
%   -rr :  Relative error. (DSIM only)
%   -ar :  Absolute error. (DSIM only)
%   -zr :  Absolute error for zero crossing detection. (DSIM only)
%   -tv : Use variable time step. Followed by Ratio. SecondaryTimeStep = TimeStep / Ratio.
%   -tc : Do not use variable time step.
%   -pt : Followed by print time of the simulation.
%   -ps : Followed by print step of the simulation.
%   -v :  Followed by variable name and value. This parameter can be used multiple times.
%        example:  -v "R1=1.5"  -v "R2=5" 
%   -m :  Followed by Text file for Error messages
%   -K  or -K1 :  Set 'Save flag' in Simulation control.
%   -K0 :  Remove 'Save flag' in Simulation control.
%   -L or -L1 :  Set 'Load flag' in Simulation control. Continue from previous simulation result.
%   -L0 :  Remove 'Load flag' in Simulation control. Starts simulation from beginning.
%   -Net : Generate netlist file. Simulation will not run. Followed by optional Netlist file name.
%   -NetXml : Generate XML netlist file. Simulation will not run. Followed by optional XML file name.
%   -NetXmlU : Generate XML netlist file in UTF16 format. Simulation will not run. Followed by optional XML file name.
%   -c :  Followed by input netlist file.
%   -LT : Run LTspice simulation. (Requires Spice module)
%   -SP  or -SPICE : Same as -LT. Run LTspice simulation. (Requires Spice module)
%   -DSIM : Run DSIM simulation. (Requires DSIM module)
% To run Script file, input file following -i switch must be a .script file. In case of script file, all other switches are ignored.
% ///////////////////////////////////////////////
% //		psimcmd return values:				   
% /////////////////////////////				   
% //		0: Success							   
% //											   
% //		Errors: 							   
% //		2:  Failed to run simulation or execute script or generate an XML file.	   
% //		3:  Can not open input schematic file  
% //		4:  Input file is missing			   
% //		10: unable to retrieve valid license.  
% //											   
% ///////////////////////////////////////////////

%% LTspice

[status,cmdout] = system('XVIIx64'); % abre Janela
disp(cmdout)



%%

addpath('..\GitHub\quiz2matlab\functions') %
% addpath('..\GitHub\quiz2matlab\questions') % 
savepath % Save search path
