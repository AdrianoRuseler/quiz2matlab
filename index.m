
%% Adicione a pasta com as funções na busca do MATLAB
pathtool % Adidione a pasta com as funções
% addpath('..\quiz2matlab\functions') % Folder with functions

%%  Test simulation with ngspice
% http://ngspice.sourceforge.net/download.html

% checkSoftwareVersion - Checks if the installed software version is supported
isSupported = checkSoftwareVersion('ngspice',44);
[ngspiceVersion,ngspiceExecutable,ngspice_conExecutable]=FindNgspiceVersion();

[status,cmdout] = system('ngspice_con -v'); % Não abre Janela
disp(cmdout)

% ******
% ** ngspice-44.2 : Circuit level simulation program
% ** Compiled with KLU Direct Linear Solver
% ** The U. C. Berkeley CAD Group
% ** Copyright 1985-1994, Regents of the University of California.
% ** Copyright 2001-2024, The ngspice team.
% ** Please get your ngspice manual from https://ngspice.sourceforge.io/docs.html
% ** Please file your bug-reports at https://ngspice.sourceforge.io/bugrep.html
% ** Creation Date: Jan 11 2025   14:28:27
% ******

[status,cmdout] = system('ngspice_con -h'); % Não abre Janela
% Usage: ngspice [OPTION]... [FILE]...
%  Simulate the electical circuits in FILE.
%
%    -a  --autorun             run the loaded netlist
%    -b, --batch               process FILE in batch mode
%    -c, --circuitfile=FILE    set the circuitfile
%    -D, --define=variable[=value] define variable to true/[value]
%    -i, --interactive         run in interactive mode
%    -n, --no-spiceinit        don't load the local or user's config file
%    -o, --output=FILE         set the outputfile
%    -p, --pipe                run in I/O pipe mode
%    -q, --completion          activate command completion
%    -r, --rawfile=FILE        set the rawfile output
%        --soa-log=FILE        set the outputfile for SOA warnings
%    -s, --server              run spice as a server process
%    -t, --term=TERM           set the terminal type
%    -h, --help                display this help and exit
%    -v, --version             output version information and exit
%
%  Report bugs to https://ngspice.sourceforge.io/bugrep.html.

%% PSIM
% checkSoftwareVersion - Checks if the installed software version is supported
isSupported = checkSoftwareVersion('PSIM',24);

[psimVersion,psimExecutable,psimCmdExecutable,psimCmdResult]=FindPSIMVersion();

[status,cmdout] = system('PsimCmd');
disp(cmdout)

% Copyright ® 2001-2022 Powersim, LLC;
% Copyright ® 2022-2024 Altair Engineering Inc.
% All Rights Reserved.
%
% Usage: PsimCmd.exe -i "[input file]" -o "[output file]" -v "VarName1=VarValue"  -v "VarName2=VarValue"  -g -K1 -L1 -t "TotalTime" -s "TimeStep" -tv "SecondaryTimestepRatio" -pt "PrintTime" -ps "PrintStep" -Net "Netlist file name" -m "file name for errors"
%
% Except input file, all other parameters are optional.
% All file names should be enclosed by " or ' characters.
% Command-line parameters:
%   -i :  Followed by input schematic file or Script file(.script).
%   -o :  Followed by output text (.txt) or binary (.smv) file.
%   -g :  Run Simview after the simulation is complete.
%   -t :  Followed by total time of the simulation.
%   -s :  Followed by time step of the simulation.
%   -tv : Use variable time step. Followed by Ratio. SecondaryTimeStep = TimeStep / Ratio.
%   -tc : Do not use variable time step.
%   -pt : Followed by print time of the simulation.
%   -ps : Followed by print step of the simulation.
%   -v :  Followed by variable name and value. This parameter can be used multiple times.
%        example:  -v "R1=1.5"  -v "R2=5"
%        special variables:
%            TIMESTEPTYPE      0,1    0:Standard  1:Variable
%            TIMESTEPRATIO     2,4,8,...
%            TOTALTIME
%            TIMESTEP
%            PRINTTIME
%            PRINTSTEP
%            SAVEFLAG          0,1
%            LOADFLAG          0,1
%            HARDWARETARGET    0,1,....20
% 				No hardware target  :  0
% 				General system		:  1
% 				Myway expert3		:  2
% 				Ps f2833x system	:  3
% 				Pro f28335 system	:  4
% 				Ps f2803x system	:  5
% 				Ps f2806x system	:  6
% 				Ps f2802x system	:  7
% 				Ps kv31 system		:  8
% 				Myway expert4		:  9
% 				Ps f28004x system	:  10
% 				Ps f2837x system	:  11
%
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
%   -hw : Generate hardware code. (Requires SimCoder modules)
% To run Script file: input file following -i switch must be a .script file. In case of script file, variables (-v switch) are passed to the script.
% ///////////////////////////////////////////////
% //		psimcmd return values:
% /////////////////////////////
% //		0: Success
% //
% //		Errors:
% //		2:  Failed to run simulation or generate an XML file or generate Simcoder C code.
% //		3:  Can not open input schematic file
% //		4:  Input file is missing
% //		10: unable to retrieve valid license.
% //		-1: Failed to run script otherwise it returns the script return value or 0
% ///////////////////////////////////////////////
%% LTspice
% checkSoftwareVersion - Checks if the installed software version is supported
isSupported = checkSoftwareVersion('LTspice',17);
[ltspiceVersion,ltspiceExecutable]=FindLTspiceVersion();

% [status,cmdout] = system('XVIIx64'); % abre Janela
[status,cmdout] = system('LTspice'); % abre Janela
% disp(cmdout)

% Command Line Switches for LTspice
% [status,cmdout] = system('LTspice -sync'); % abre Janela


%%

addpath('..\GitHub\quiz2matlab\functions') %
% addpath('..\GitHub\quiz2matlab\questions') %
savepath % Save search path
