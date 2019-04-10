% Generates the .cir file from LTspice net file

function  circuit = ltnet2ngcir(circuit)

if ~exist(circuit.LTspice.net.file,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.LTspice.net.file])
    return;
end

% 
% fileID = fopen(circuit.LTspice.net.file);
% if fileID == -1
%    disp(['Could not open: ' circuit.LTspice.net.file])    
%     return;
% end

% l=1;
% % tline=cell(1,20); % Pre allocation
% while ~feof(fileID)
%     tline{l} = fgetl(fileID);
%     l=l+1;
% end
% fclose(fileID);
    
circuit.Ngspice.cir.name = circuit.Ngspice.name;
circuit.Ngspice.cir.file = [circuit.Ngspice.simsdir '\' circuit.Ngspice.name '.cir'];

copyfile(circuit.LTspice.net.file,circuit.Ngspice.cir.file) % Copia arquivo