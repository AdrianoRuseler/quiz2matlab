% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2019 AdrianoRuseler
% ***
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% ***
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% ***
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================


function  circuit = psimfromcmd(circuit)

% Copyright ® 2006-2018 Powersim Inc.  All Rights Reserved.
% 
% Usage: PsimCmd.exe -i "[input file]" -o "[output file]" -v "VarName1=VarValue"  -v "VarName2=VarValue"  -g -K1 -L1 -t "TotalTime" -s "TimeStep" -pt "PrintTime" -ps "PrintStep" -Net "Netlist file name" -m "file name for errors"
% 
% Except input file, all other parameters are optional.
% All file names should be enclosed by " or ' characters.
% Command-line parameters:
% -i :  Followed by input schematic file.
% -o :  Followed by output text (.txt) or binary (.smv) file.
% -g :  Run Simview after the simulation is complete.
% -t :  Followed by total time of the simulation.
% -s :  Followed by time step of the simulation.
% -pt : Followed by print time of the simulation.
% -ps : Followed by print step of the simulation.
% -v :  Followed by variable name and value. This parameter can be used multiple times.
% example:  -v "R1=1.5"  -v "R2=5"
% -m :  Followed by Text file for Error messages
% -K  or -K1 :  Set 'Save flag' in Simulation control.
% -K0 :  Remove 'Save flag' in Simulation control.
% -L or -L1 :  Set 'Load flag' in Simulation control. Continue from previous simulation result.
% -L0 :  Remove 'Load flag' in Simulation control. Starts simulation from beginning.
% -Net : Generate netlist file. Simulation will not run. Followed by optional Netlist file name.
% -c :  Followed by input netlist file.
% -SP  or -SPICE : Run Spice simulation. (Requires Spice module)
% -LT : Run LTspice simulation. (Requires Spice module)

%  varstrcmd -v "VarName1=VarValue"  -v "VarName2=VarValue"
varstrcmd='';
for ind=1:length(circuit.parname)
    varstrcmd=[varstrcmd ' -v "' circuit.parname{ind} '=' num2str(circuit.parvalue(ind),'%10.8e') '"'];
end
circuit.PSIMCMD.extracmd = varstrcmd;

simfilebase = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.psimsch']; % Sim base file
circuit.PSIMCMD.inifile = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.ini']; % Arquivo ini simview

if(circuit.PSIMCMD.tmpdir)  % Use system temp dir?
   circuit.PSIMCMD.simsdir = tempdir;    
end

if(circuit.PSIMCMD.tmpfile) % Create tmp file for simulation?
    tmpname=[circuit.PSIMCMD.name strrep(char(java.util.UUID.randomUUID),'-','')];
    circuit.PSIMCMD.infile = [circuit.PSIMCMD.simsdir '\' tmpname '.psimsch'];
    copyfile(simfilebase,circuit.PSIMCMD.infile) % Copia arquivo
else
    tmpname = circuit.PSIMCMD.name;
    circuit.PSIMCMD.infile = [circuit.PSIMCMD.simsdir '\' tmpname '.psimsch'];
end

circuit.PSIMCMD.outfile = [circuit.PSIMCMD.simsdir '\' tmpname '.txt'];
circuit.PSIMCMD.msgfile = [circuit.PSIMCMD.simsdir '\' tmpname '_msg.txt'];

% Cria string de comando
infile = ['"' circuit.PSIMCMD.infile '"'];
outfile = ['"' circuit.PSIMCMD.outfile '"'];
msgfile = ['"' circuit.PSIMCMD.msgfile '"'];
totaltime = ['"' num2str(circuit.PSIMCMD.totaltime,'%10.8e') '"'];  %   -t :  Followed by total time of the simulation.
steptime = ['"' num2str(circuit.PSIMCMD.steptime,'%10.8e') '"']; %   -s :  Followed by time step of the simulation.
printtime = ['"' num2str(circuit.PSIMCMD.printtime,'%10.8e') '"']; %   -pt : Followed by print time of the simulation.
printstep = ['"' num2str(circuit.PSIMCMD.printstep,'%10.8e') '"']; %   -ps : Followed by print step of the simulation.

PsimCmdsrt= ['-i ' infile ' -o ' outfile ' -m ' msgfile ' -t ' totaltime ' -s ' steptime ' -pt ' printtime ' -ps ' printstep ' ' circuit.PSIMCMD.extracmd];

tic
disp(PsimCmdsrt)
disp('Simulating...')
[status,cmdout] = system(['PsimCmd ' PsimCmdsrt]); % Executa simulação

circuit.PSIMCMD.status=status; % If 0, is OK! else, some problem

circuit.PSIMCMD.simtime=toc; % Tempo total de simulação
disp(cmdout)
circuit.PSIMCMD.cmdout=cmdout;


%%  Load file .txt
disp(['Reading ' circuit.PSIMCMD.outfile ' file....     Wait!'])
tic

[fileID,~] = fopen(circuit.PSIMCMD.outfile);
% [filename,permission,machinefmt,encodingOut] = fopen(fileID);
if fileID==-1
    disp('File error!!')
    return
end

% BufSize -> Maximum string length in bytes -> 4095
tline = fgetl(fileID);
[header] = strread(tline,'%s','delimiter',' ');

fstr='%f';
for tt=2:length(header)
    fstr=[fstr '%f'];
end

M = cell2mat(textscan(fileID,fstr));
fclose(fileID);

disp('Done!')
% Convert data

disp('Converting to simulink struct data ....')

circuit.PSIMCMD.data.time=M(:,1);
circuit.PSIMCMD.data.Ts=M(2,1)-M(1,1); % Time step

% Verifies header name
for i=2:length(header)
    if verLessThan('matlab', '8.2.0')
        U = genvarname(header{i});
        modified=1; % Just force update
    else
        [U, modified] = matlab.lang.makeValidName(header{i},'ReplacementStyle','delete');
    end
    if modified
        disp(['Name ' header{i} ' modified to ' U ' (MATLAB valid name for variables)!!'])
    end
    circuit.PSIMCMD.data.signals(i-1).label=U;
    circuit.PSIMCMD.data.signals(i-1).values=M(:,i);
    circuit.PSIMCMD.data.signals(i-1).mean=mean(M(:,i)); 
    circuit.PSIMCMD.data.signals(i-1).rms=rms(M(:,i));
    circuit.PSIMCMD.data.signals(i-1).dimensions=1;
    circuit.PSIMCMD.data.signals(i-1).title=U;
    circuit.PSIMCMD.data.signals(i-1).plotStyle=[0,0];
end

circuit.PSIMCMD.data.blockName=tmpname;
circuit.PSIMCMD.data.PSIMheader=header; % For non valid variables
circuit.PSIMCMD.datareadtime=toc; % Tempo total de simulação

disp('Done!!!!')

disp('Deleting files...')
if(circuit.PSIMCMD.tmpfiledel)
    delete(circuit.PSIMCMD.infile) % Deleta arquivo de simulação
    delete(circuit.PSIMCMD.outfile) % Deleta arquivo de dados
    delete(circuit.PSIMCMD.msgfile)
end
disp('Done!!!!')
disp(circuit.PSIMCMD)


