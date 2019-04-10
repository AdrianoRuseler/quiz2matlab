
% Get net file parameters
function [circuit] = ngspicegetnet(circuit)

if ~exist(circuit.Ngspice.cir.file,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.Ngspice.cir.file])
    return;
end

fileID = fopen(circuit.Ngspice.cir.file);
if fileID == -1
   disp(['Could not open: ' circuit.Ngspice.cir.file])    
    return;
end

l=1;
% tline=cell(1,20); % Pre allocation
while ~feof(fileID)
    tline{l} = fgetl(fileID);
    if contains(tline{l},'.param') % Find .param line
        circuit.Ngspice.cir.paramline=l;
    elseif contains(tline{l},'.tran')
        circuit.Ngspice.cir.cmdline=l;
        circuit.Ngspice.type = 'tran';
    elseif contains(tline{l},'.ac')
        circuit.Ngspice.cir.cmdline=l;
        circuit.Ngspice.type = 'ac';
    elseif contains(tline{l},'.dc')
        circuit.Ngspice.cir.cmdline=l;
        circuit.Ngspice.type = 'dc';
    elseif contains(tline{l},'.noise')
        circuit.Ngspice.cir.cmdline=l;
        circuit.Ngspice.type = 'noise';
    elseif contains(tline{l},'.tf')
        circuit.Ngspice.cir.cmdline=l;
        circuit.Ngspice.type = 'tf';
    elseif contains(tline{l},'.op')
        circuit.Ngspice.cir.cmdline=l;
        circuit.Ngspice.type = 'op';
    end
    % tran, ac, dc, noise, tf, op
    l=l+1;
end
fclose(fileID);

circuit.Ngspice.cir.lines=tline';







