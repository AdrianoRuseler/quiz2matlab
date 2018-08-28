% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2018 AdrianoRuseler
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


% circuit.fullfilename = [ circuit.basefilename  circuit.prefixname]; % Atualiza nome do arquivo

circuit.PSIMCMD.infile = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.psimsch'];
circuit.PSIMCMD.outfile = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.txt'];
circuit.PSIMCMD.msgfile = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '_msg.txt'];
circuit.PSIMCMD.inifile = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.ini']; % Arquivo ini simview
circuit.PSIMCMD.extracmd = '';

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
disp('Simulando conversor...')
[status,cmdout] = system(['PsimCmd ' PsimCmdsrt]); % Executa simulação
disp(cmdout)
circuit.PSIMCMD.cmdout=cmdout;

if verLessThan('matlab', '9.1')
    if isempty(strfind(cmdout,'Failed'))
        circuit.PSIMCMD.status=0;
        disp('Importando dados simulados do conversor...')
        circuit = psimread(circuit); % Importa pontos simulados
    else
        disp('Ocorreu algum erro!')
        circuit.PSIMCMD.status=1;
    end
else    
    if contains(cmdout,'Error')||contains(cmdout,'Failed') % Verifica se houve error durante a simulação
        disp('Ocorreu algum erro!')
        circuit.PSIMCMD.status=1;
    else
        circuit.PSIMCMD.status=0;
        disp('Importando dados simulados do conversor...')
        circuit = psimread(circuit); % Importa pontos simulados
        %     conv = psimini2struct(conv);  % Atualiza a estrutura conv com dados do arquivo .ini
    end
end

disp(cmdout)
circuit.PSIMCMD.simtime=toc; % Tempo total de simulação

disp(circuit.PSIMCMD)





