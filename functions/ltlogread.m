
% Reads log file
function [circuit] = ltlogread(circuit)


if ~exist(circuit.LTspice.log.file,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.LTspice.log.file])
    return;
end


fileID = fopen(circuit.LTspice.log.file);
if fileID == -1
   disp(['Could not open: ' circuit.LTspice.log.file])    
    return;
end

l=1;
while ~feof(fileID)
    tline{l} = fgetl(fileID);   
    if ~isempty(tline{l})
        l=l+1;
    end
end
fclose(fileID);
circuit.LTspice.log.lines=tline;


% circuit.LTspice.log.lines{1}

tmpstr=strsplit(tline{1}); 
circuit.LTspice.log.circuit=tmpstr{3};
circuit.LTspice.log.status=tline{2};
circuit.LTspice.log.datesrt=tline{3};
circuit.LTspice.log.ttimestr=tline{4};
% 
for l=5:length(tline)
    if contains(tline{l},'tnom') % Find tnom
        tmpstr=strsplit(tline{l});
        circuit.LTspice.log.tnom=str2double(tmpstr{3});
    elseif contains(tline{l},'temp')
        tmpstr=strsplit(tline{l});
        circuit.LTspice.log.temp=str2double(tmpstr{3});
    end
end
