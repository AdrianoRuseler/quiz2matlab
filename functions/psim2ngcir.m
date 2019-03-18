% Generates the .cir file from PSIM net file

function  circuit = psim2ngcir(circuit)

if ~exist(circuit.PSIMCMD.net.file,'file') % File exists?
    disp(['File not found: ' circuit.PSIMCMD.net.file])
    system(['PsimCmd -i ' circuit.PSIMCMD.file ' -o ' circuit.PSIMCMD.net.file ' -Net']); % Generates the netlist
end


fileID = fopen(circuit.PSIMCMD.net.file);
if fileID == -1
   disp(['Could not open: ' circuit.PSIMCMD.net.file])    
    return;
end

% TODO:
line=1;
while ~feof(fileID)
    tline{line} = fgetl(fileID);
    line=line+1;
end
fclose(fileID);



    
circuit.Ngspice.cir.name = circuit.Ngspice.name;
circuit.Ngspice.cir.file = [circuit.Ngspice.simsdir '\' circuit.Ngspice.name '.cir'];
circuit.Ngspice.cir.lines = tline';

% Writes cir file
fileID = fopen(circuit.Ngspice.net.file,'w');
if fileID == -1
   disp(['Could not open: ' circuit.PSIMCMD.net.file])    
    return;
end

for l=1:length(circuit.Ngspice.net.lines) % Write netfile content
    fprintf(fileID, '%s%c%c', circuit.Ngspice.net.lines{l} ,13,10);   
end

fclose(fileID); % Close


% copyfile(circuit.LTspice.net.file,circuit.Ngspice.cir.file) % Copia arquivo