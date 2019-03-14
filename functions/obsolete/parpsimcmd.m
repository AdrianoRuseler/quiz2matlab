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
% Parallel implementation

function  dataout = parpsimcmd(parname,parvalue,simfilebase,totaltime,steptime,printtime,printstep)


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
for ind=1:length(parname)    
        varstrcmd=[varstrcmd ' -v "' parname{ind} '=' num2str(parvalue(ind),'%10.8e') '"'];
end

% simfilebase=[pwd '\LAB07PSIMa.psimsch'];

% [pathstr, name, ext] = fileparts(simfilebase);
% filename=[name char(floor(26*rand(1, 10)) + 97)]; % Gera nome aleatorio
% simfile= [pathstr '\' filename ext];

[simdir, name, ext] = fileparts(simfilebase);
tmpname=[name strrep(char(java.util.UUID.randomUUID),'-','')];
simfile = fullfile(simdir, [tmpname ext]); % Generate temp sim filename
copyfile(simfilebase,simfile) % Copia arquivo

outfile = [simdir '\' tmpname '.txt'];
% msgfile = [pathstr '\' filename '_msg.txt'];
% extracmd = ''; % Comando extra


% Cria string de comando
infilestr = ['"' simfile '"'];
outfilestr = ['"' outfile '"'];
% msgfilestr = ['"' msgfile '"'];
ttime = ['"' num2str(totaltime,'%10.8e') '"'];  %   -t :  Followed by total time of the simulation.
stime = ['"' num2str(steptime,'%10.8e') '"']; %   -s :  Followed by time step of the simulation.
ptime = ['"' num2str(printtime,'%10.8e') '"']; %   -pt : Followed by print time of the simulation.
pstep = ['"' num2str(printstep,'%10.8e') '"']; %   -ps : Followed by print step of the simulation. ' -m ' msgfilestr 

PsimCmdsrt= ['-i ' infilestr ' -o ' outfilestr ' -t ' ttime ' -s ' stime ' -pt ' ptime ' -ps ' pstep ' ' varstrcmd];

system(['PsimCmd ' PsimCmdsrt]); % Executa simulação
disp([name ' simulado!'])




[fileID,errmsg] = fopen(outfile);
t=0; 
while fileID < 0 
   t=t+1;
   disp(['Erro ao abrir o arquivo ' name ' para escrita!'])
   disp(errmsg)
   [fileID,errmsg] = fopen(outfile);
   if t==10
       data.time=[];
       data.Ts=[];
       data.signals=[];
       data.blockName=name;
       dataout=data;
       return
   end
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



 data.time=M(:,1);
 data.Ts=M(2,1)-M(1,1); % Time step
 
 % Verifies header name
 for i=2:length(header)
     if verLessThan('matlab', '8.2.0')
         U = genvarname(header{i});
     else
         [U, ~] = matlab.lang.makeValidName(header{i},'ReplacementStyle','delete');
     end

     data.signals(i-1).label=U;
     data.signals(i-1).values=M(:,i);
     data.signals(i-1).medio=mean(M(:,i));
     data.signals(i-1).dimensions=1;   
     data.signals(i-1).title=U;
     data.signals(i-1).plotStyle=[0,0];
 end
  
data.blockName=name;
dataout=data;

delete(simfile) % Deleta arquivo de simulação
delete(outfile) % Deleta arquivo de dados



