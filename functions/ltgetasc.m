
% Get asc file parameters
function [circuit] = ltgetasc(circuit)

if ~exist(circuit.LTspice.ascfile,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.LTspice.ascfile])
    return;
end

% circuit.LTspice.asc.file=circuit.LTspice.ascfile;

fileID = fopen(circuit.LTspice.ascfile);
if fileID == -1
    disp(['Could not open: ' circuit.LTspice.ascfile])
    return;
end

ln=1;
pl=1; % number of .param lines

% tline=cell(1,20); % Pre allocation
while ~feof(fileID)
    tline{ln} = fgetl(fileID);
    if contains(tline{ln},'.param') % Find .param line
        circuit.LTspice.asc.paramline(pl)=ln;
        pl=pl+1;
    elseif contains(tline{ln},'.model')
        if isfield(circuit,'model')
            for ml=1:length(circuit.model) % number of .model lines
                if contains(tline{ln},circuit.model(ml).name)
                    circuit.LTspice.asc.modelline(ml)=ln; % Find .model line
                end
            end
        end
    elseif contains(tline{ln},'.step')
        circuit.LTspice.asc.stepline=ln; % Just one step line please
    elseif contains(tline{ln},'.tran')
        circuit.LTspice.asc.cmdline=ln;
        circuit.LTspice.type = 'tran';
    elseif contains(tline{ln},'.ac')
        circuit.LTspice.asc.cmdline=ln;
        circuit.LTspice.type = 'ac';
    elseif contains(tline{ln},'.dc')
        circuit.LTspice.asc.cmdline=ln;
        circuit.LTspice.type = 'dc';
    elseif contains(tline{ln},'.noise')
        circuit.LTspice.asc.cmdline=ln;
        circuit.LTspice.type = 'noise';
    elseif contains(tline{ln},'.tf')
        circuit.LTspice.asc.cmdline=ln;
        circuit.LTspice.type = 'tf';
    elseif contains(tline{ln},'.op')
        circuit.LTspice.asc.cmdline=ln;
        circuit.LTspice.type = 'op';
    end
    % tran, ac, dc, noise, tf, op
    ln=ln+1;
end
fclose(fileID);

circuit.LTspice.asc.lines=tline';

