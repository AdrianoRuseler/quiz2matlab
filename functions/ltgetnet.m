
% Get net file parameters
function [circuit] = ltgetnet(circuit)

if ~exist(circuit.LTspice.net.file,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.LTspice.net.file])
    return;
end

fileID = fopen(circuit.LTspice.net.file);
if fileID == -1
   disp(['Could not open: ' circuit.LTspice.net.file])    
    return;
end

l=1;
% tline=cell(1,20); % Pre allocation
while ~feof(fileID)
    tline{l} = fgetl(fileID);
    if contains(tline{l},'.param') % Find .param line
        circuit.LTspice.net.paramline=l;
    elseif contains(tline{l},'.tran')
        circuit.LTspice.net.cmdline=l;
        circuit.LTspice.type = 'tran';
    elseif contains(tline{l},'.ac')
        circuit.LTspice.net.cmdline=l;
        circuit.LTspice.type = 'ac';
    elseif contains(tline{l},'.dc')
        circuit.LTspice.net.cmdline=l;
        circuit.LTspice.type = 'dc';
    elseif contains(tline{l},'.noise')
        circuit.LTspice.net.cmdline=l;
        circuit.LTspice.type = 'noise';
    elseif contains(tline{l},'.tf')
        circuit.LTspice.net.cmdline=l;
        circuit.LTspice.type = 'tf';
    elseif contains(tline{l},'.op')
        circuit.LTspice.net.cmdline=l;
        circuit.LTspice.type = 'op';
    end
    % tran, ac, dc, noise, tf, op
    l=l+1;
end
fclose(fileID);

circuit.LTspice.net.lines=tline';







