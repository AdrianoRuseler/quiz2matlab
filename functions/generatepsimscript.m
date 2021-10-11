% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2021 AdrianoRuseler
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
% https://psim.powersimtech.com/hubfs/PDF%20Tutorials/Tutorial%20-%20How%20to%20Use%20Script%20Functions.pdf

% The Script functions that used in PSIM%s Script Tool can perform calculations, run simulation, and
% plot graphs.

function  circuit = generatepsimscript(circuit)

circuit.PSIMSCRIPT{1}='// Text file intended to run as script in PSIM'; % FileName = FileName 
circuit.PSIMSCRIPT{2}='FileDir = GetLocal("PARAMPATH");';
circuit.PSIMSCRIPT{3}=['FileName = "' circuit.PSIMCMD.script.tmpname '";'];
circuit.PSIMSCRIPT{4}=['infile = FileDir + FileName + ".psimsch";'];
% circuit.PSIMSCRIPT{5}=['outfile = "' circuit.PSIMCMD.outfile '";'];
circuit.PSIMSCRIPT{5}=['outfile = FileDir + FileName + ".txt";'];
% circuit.PSIMSCRIPT{6}=['msgfile = "' circuit.PSIMCMD.msgfile '";'];
circuit.PSIMSCRIPT{6}='';

circuit.PSIMSCRIPT{7}='//Simulation Control Variables';
circuit.PSIMSCRIPT{8}=['TT = "' num2str(circuit.PSIMCMD.totaltime,'%4.3e') '"; // TotalTime'];  %   -t :  Followed by total time of the simulation.
circuit.PSIMSCRIPT{9}=['TS = "' num2str(circuit.PSIMCMD.steptime,'%4.3e') '"; // TimeStep']; %   -s :  Followed by time step of the simulation.
circuit.PSIMSCRIPT{10}=['PT = "' num2str(circuit.PSIMCMD.printtime,'%4.3e') '"; // PrintTime']; %   -pt : Followed by print time of the simulation.
circuit.PSIMSCRIPT{11}=['PS = "' num2str(circuit.PSIMCMD.printstep,'%4.3e') '"; // PrintStep']; %   -ps : Followed by print step of the simulation.
circuit.PSIMSCRIPT{12}='';

% circuit.PSIMSCRIPT{13}='//turn off loging';
% circuit.PSIMSCRIPT{14}='ScriptOption("NoLog");';
% circuit.PSIMSCRIPT{15}='';

% Simulate(File1, smvFile, TimeStep = Step_t, TotalTime=Total_t, graph1);
circuit.PSIMSCRIPT{13}='// Parameters';
valor=circuit.parvalue;
parname=circuit.parnamesim;
s = length(circuit.PSIMSCRIPT);
for a=1:length(valor)
    circuit.PSIMSCRIPT{a+s} = [parname{a} '=' num2str(valor(a),'%4.3e') ';'] ;
end

s = length(circuit.PSIMSCRIPT);
% print functions values
if isfield(circuit,'funcvalue')
    for ind=1:length(circuit.funcvalue)
        circuit.PSIMSCRIPT{ind+s} = ['func' num2str(ind) '=' num2str(circuit.funcvalue(ind),'%4.3e') ';'] ;
    end
end

% disp(circuit.PSIMSCRIPT)
s = length(circuit.PSIMSCRIPT);
circuit.PSIMSCRIPT{s+1} = '';
circuit.PSIMSCRIPT{s+2} = '// Run simulation';
circuit.PSIMSCRIPT{s+3} = 'Simulate (infile, outfile, TotalTime=TT, TimeStep=TS, PrintTime=PT, PrintStep=PS);';
circuit.PSIMSCRIPT{s+4} = '//graph1 = GraphRead(outfile);   // Reading simulation output';

fileID = fopen(circuit.PSIMCMD.script.file,'w');
% [filename,permission,machinefmt,encodingOut] = fopen(fileID);
if fileID==-1
    disp('File error!!')
    return
end

for m=1:length(circuit.PSIMSCRIPT) %
    fprintf(fileID,'%s\n',circuit.PSIMSCRIPT{m});
end

fclose(fileID);


% Reads script file and convert to Base64
fileID = fopen(circuit.PSIMCMD.script.file,'r');
if fileID==-1
    disp('File error!!')
    return
end
A = fread(fileID);
fclose(fileID);

Yc = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(A)))'; % Encode
circuit.PSIMCMD.script.base64code=Yc;

% disp(circuit.PSIMCMD.script.base64code)



% s = length(circuit.PSIMSCRIPT);
% circuit.PSIMSCRIPT{s+1}='// Append data to the end of the file.';
% 
% fileID = fopen(circuit.PSIMCMD.script.file,'a');
% % [filename,permission,machinefmt,encodingOut] = fopen(fileID);
% if fileID==-1
%     disp('File error!!')
%     return
% end
% 
% fprintf(fileID,'%s\n',circuit.PSIMSCRIPT{s+1});
% 
% fclose(fileID);




