
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

ln=1;
% tline=cell(1,20); % Pre allocation
while ~feof(fileID)
    tline{ln} = fgetl(fileID);
    if contains(tline{ln},'.param') % Find .param line
        circuit.LTspice.net.paramline=ln;
    elseif contains(tline{ln},'.model')    
        circuit.LTspice.net.modelline=ln; % Find .model line
    elseif contains(tline{ln},'.step')
        circuit.LTspice.net.stepline=ln; % Just one step line please
    elseif contains(tline{ln},'.tran')
        circuit.LTspice.net.cmdline=ln;
        circuit.LTspice.type = 'tran';
    elseif contains(tline{ln},'.ac')
        circuit.LTspice.net.cmdline=ln;
        circuit.LTspice.type = 'ac';
    elseif contains(tline{ln},'.dc')
        circuit.LTspice.net.cmdline=ln;
        circuit.LTspice.type = 'dc';
    elseif contains(tline{ln},'.noise')
        circuit.LTspice.net.cmdline=ln;
        circuit.LTspice.type = 'noise';
    elseif contains(tline{ln},'.tf')
        circuit.LTspice.net.cmdline=ln;
        circuit.LTspice.type = 'tf';
    elseif contains(tline{ln},'.op')
        circuit.LTspice.net.cmdline=ln;
        circuit.LTspice.type = 'op';
    end
    % tran, ac, dc, noise, tf, op
    ln=ln+1;
end
fclose(fileID);

circuit.LTspice.net.lines=tline';







