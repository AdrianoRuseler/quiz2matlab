
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

ln=1; % lines
pl=1; % number of .param lines

% tline=cell(1,20); % Pre allocation
while ~feof(fileID)
    tline{ln} = fgetl(fileID);
    if contains(tline{ln},'.param') % Find .param line
        circuit.LTspice.net.paramline(pl)=ln;
        pl=pl+1;
    elseif contains(tline{ln},'.model')
        if isfield(circuit,'model')
            for ml=1:length(circuit.model) % number of .model lines
                if contains(tline{ln},circuit.model(ml).name)
                    circuit.LTspice.net.modelline(ml)=ln; % Find .model line
                end
            end
        end
    elseif contains(tline{ln},'level.')
        circuit.LTspice.net.levelline=ln; % Find Opamp Model   
        circuit.level.linestr=tline{ln};
        lvlstr = strsplit(circuit.level.linestr,' ');
        n=1;
        for s=1:length(lvlstr)
            if contains(lvlstr{s},'=')
               lvlstr2 = strsplit(lvlstr{s},'=');
               circuit.level.name{n}=lvlstr2{1};
               circuit.level.value{n}=lvlstr2{2};
               n=n+1;
            end
        end
        
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







