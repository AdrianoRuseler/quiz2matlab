% //		0: Success							   							   
% //		Errors: 							   
% //		2:  Failed to run simulation or generate an XML file or generate Simcoder C code. 
% //		3:  Can not open input schematic file  
% //		4:  Input file is missing		
% //        5:  Key word in cmdout file: ERROR ou Failed
% //        6:  Key word in msg file: ERROR ou Failed
% //		10: unable to retrieve valid license.  
% //		-1: Failed to run script otherwise it returns the script return value or 0


function  [teststatus, circuit]= psimfromcmdtest(circuit)

% Copyright ® 2006-2021 Powersim Inc.  All Rights Reserved.
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
%   -rr :  Relative error. (DSIM only)
%   -ar :  Absolute error. (DSIM only)
%   -zr :  Absolute error for zero crossing detection. (DSIM only)
%   -kt :  Enable Switching Transients Out. (DSIM only)
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
%   -hw : Generate hardware code. (Requires SimCoder modules)
% To run Script file, input file following -i switch must be a .script file. In case of script file, variables (-v switch) are passed to the script. 
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

%  varstrcmd -v "VarName1=VarValue"  -v "VarName2=VarValue"
varstrcmd='';
for ind=1:length(circuit.parname)
    varstrcmd=[varstrcmd ' -v "' circuit.parnamesim{ind} '=' num2str(circuit.parvalue(ind),'%10.8e') '"'];
end
% print functions values
if isfield(circuit,'funcvalue')
    for ind=1:length(circuit.funcvalue)
        varstrcmd=[varstrcmd ' -v "func' num2str(ind) '=' num2str(circuit.funcvalue(ind),'%10.8e') '"'];
    end
end

circuit.PSIMCMD.extracmd = varstrcmd;

simfilebase = [circuit.PSIMCMD.simsdir circuit.PSIMCMD.name '.psimsch']; % Sim base file
circuit.PSIMCMD.inifile = [circuit.PSIMCMD.simsdir circuit.PSIMCMD.name '.ini']; % Arquivo ini simview

if(circuit.PSIMCMD.tmpdir)  % Use system temp dir?
    circuit.PSIMCMD.simsdir = tempdir;
end

randname = strrep(char(java.util.UUID.randomUUID),'-','');
tmpname=[circuit.PSIMCMD.name randname];
circuit.PSIMCMD.randname=randname;
circuit.PSIMCMD.tmpname=tmpname;

if(circuit.PSIMCMD.net.run) % run net file
    circuit.PSIMCMD.infile = [circuit.PSIMCMD.simsdir tmpname '.cct'];
    copyfile(circuit.PSIMCMD.net.file,circuit.PSIMCMD.infile)
else
    if(circuit.PSIMCMD.tmpfile) % Create tmp file for simulation?
        circuit.PSIMCMD.infile = [circuit.PSIMCMD.simsdir tmpname '.psimsch'];
        copyfile(simfilebase,circuit.PSIMCMD.infile) % Copia arquivo
    else
        tmpname = circuit.PSIMCMD.name;
        circuit.PSIMCMD.infile = [circuit.PSIMCMD.simsdir tmpname '.psimsch'];
    end
end

circuit.PSIMCMD.outfile = [circuit.PSIMCMD.simsdir tmpname '.txt'];
circuit.PSIMCMD.msgfile = [circuit.PSIMCMD.simsdir tmpname 'msg.txt'];


if circuit.PSIMCMD.script.run
    circuit.PSIMCMD.script.file = [circuit.PSIMCMD.simsdir tmpname '.script'];
    circuit.PSIMCMD.script.tmpname = tmpname;
    circuit.PSIMCMD.script.name=['PS' upper(randname(1:6)) '.script'];    
    circuit = generatepsimscript(circuit); % Creates PSIM script
    PsimCmdsrt = circuit.PSIMCMD.script.file;
else
    % Cria string de comando
    infile = ['"' circuit.PSIMCMD.infile '"'];
    outfile = ['"' circuit.PSIMCMD.outfile '"'];
    msgfile = ['"' circuit.PSIMCMD.msgfile '"'];
    totaltime = ['"' num2str(circuit.PSIMCMD.totaltime,'%10.8e') '"'];  %   -t :  Followed by total time of the simulation.
    steptime = ['"' num2str(circuit.PSIMCMD.steptime,'%10.8e') '"']; %   -s :  Followed by time step of the simulation.
    printtime = ['"' num2str(circuit.PSIMCMD.printtime,'%10.8e') '"']; %   -pt : Followed by print time of the simulation.
    printstep = ['"' num2str(circuit.PSIMCMD.printstep,'%10.8e') '"']; %   -ps : Followed by print step of the simulation.

    PsimCmdsrt= ['-i ' infile ' -o ' outfile ' -m ' msgfile ' -t ' totaltime ' -s ' steptime ' -pt ' printtime ' -ps ' printstep ' ' circuit.PSIMCMD.extracmd];

end

tic
% disp(PsimCmdsrt)
% disp(['Simulating ' circuit.PSIMCMD.infile ' file....     Wait!'])

if strcmp(circuit.engine,'psim')
    disp(['PSIM simulation with ' circuit.PSIMCMD.extracmd])
    [status,cmdout] = system(['PsimCmd ' PsimCmdsrt]); % Executa simulação
else
    disp(['LTspice simulation with ' circuit.PSIMCMD.extracmd])
    [status,cmdout] = system(['PsimCmd -LT' PsimCmdsrt]); % Executa simulação
end


circuit.PSIMCMD.status=status; % If 0, is OK! else, some problem
circuit.PSIMCMD.simtime=toc; % Tempo total de simulação

% Error:  Error: One
% disp(cmdout)
circuit.PSIMCMD.cmdout=cmdout;
circuit.PSIMCMD.msg = fileread(circuit.PSIMCMD.msgfile);



%%  Delete file...

disp('Deleting files...')
if(circuit.PSIMCMD.tmpfiledel)
    delete(circuit.PSIMCMD.infile) % Deleta arquivo de simulação
    delete(circuit.PSIMCMD.outfile) % Deleta arquivo de dados

    if circuit.PSIMCMD.script.run
        delete(circuit.PSIMCMD.script.file)
    else
        delete(circuit.PSIMCMD.msgfile)
    end
end
disp('Done!!!!')
disp(circuit.PSIMCMD)

%% Error handler
teststatus=0; % OK!
% 
% disp(circuit.PSIMCMD.cmdout)
% disp(circuit.PSIMCMD.status)
% disp(circuit.PSIMCMD.msg)

if circuit.PSIMCMD.status
   disp("CMD status is a nonzero integer.")
   teststatus = circuit.PSIMCMD.status;
   return
end

% //		0: Success							   							   
% //		Errors: 							   
% //		2:  Failed to run simulation or generate an XML file or generate Simcoder C code. 
% //		3:  Can not open input schematic file  
% //		4:  Input file is missing		
% //        5:  Key word in cmdout file: ERROR ou Failed
% //        6:  Key word in msg file: ERROR ou Failed
% //		10: unable to retrieve valid license.  
% //		-1: Failed to run script otherwise it returns the script return value or 0

if contains(circuit.PSIMCMD.cmdout,'ERROR:','IgnoreCase',true) || contains(circuit.PSIMCMD.cmdout,'Failed','IgnoreCase',true)
    disp('Simulation with error in cmdout!')
    teststatus = 5;
    return
end

if contains(circuit.PSIMCMD.msg,'ERROR:','IgnoreCase',true) || contains(circuit.PSIMCMD.msg,'Failed','IgnoreCase',true)
    disp('Simulation with error in msg!')
    teststatus = 5;
    return
end




