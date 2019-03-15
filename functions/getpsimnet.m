
% Get net file parameters
function [circuit] = getpsimnet(circuit)

circuit.PSIMCMD.net.file = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.cct']; % net file
circuit.PSIMCMD.file = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.psimsch']; % PSIM file

if ~exist(circuit.PSIMCMD.net.file,'file') % File exists?
    disp(['File not found: ' circuit.PSIMCMD.net.file])
    system(['PsimCmd -i ' circuit.PSIMCMD.file ' -o ' circuit.PSIMCMD.net.file ' -Net']); % Generates the netlist
end

fileID = fopen(circuit.PSIMCMD.net.file);
if fileID == -1
   disp(['Could not open: ' circuit.PSIMCMD.net.file])    
    return;
end

l=1;
while ~feof(fileID) % Reads content
    tline{l} = fgetl(fileID);
    l=l+1;
end
fclose(fileID);

circuit.PSIMCMD.net.lines=tline';







