
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

ln=1;
while ~feof(fileID)
    tline{ln} = fgetl(fileID);   % read line
    if ~isempty(tline{ln}) % Discart empty lines    
        ln=ln+1;       
    end
end
fclose(fileID);
circuit.LTspice.log.lines=tline';


% circuit.LTspice.log.lines{1}

tmpstr=strsplit(tline{1}); 
circuit.LTspice.log.circuit=tmpstr{3}; % Circuit file
circuit.LTspice.log.status=tline{2}; % Simulation method used and status


for ln=3:length(tline)
    if contains(tline{ln},'Date:')
        circuit.LTspice.log.datesrt=tline{ln}(7:end); % Gets data str
        circuit.LTspice.log.dateline=ln; % Relevant info comes before this
        break
    end
    %     elseif contains(tline{ln},'Total elapsed time:')
    %         circuit.LTspice.log.ttimestr=tline{ln};
    
    %     elseif contains(tline{ln},'tnom') % Find tnom
    %         tmpstr=strsplit(tline{ln});
    %         circuit.LTspice.log.tnom=str2double(tmpstr{3});
    %     elseif contains(tline{ln},'temp')
    %         tmpstr=strsplit(tline{ln});
    %         circuit.LTspice.log.temp=str2double(tmpstr{3});
    %     end
end


% dateline circuit.LTspice.data.signals

nvars = circuit.LTspice.data.nvars;
% m=1;
for ln=3:circuit.LTspice.log.dateline
    if contains(tline{ln},'=')
        tmpstr1=strsplit(tline{ln},':'); % Varname
        tmpstr2=strsplit(strtrim(tmpstr1{2}),'=');
%         circuit.LTspice.log.measname{m}=strtrim(tmpstr1{1});
        nvars=nvars+1;
        U = matlab.lang.makeValidName(char(tmpstr1{1}),'ReplacementStyle','delete');
        circuit.LTspice.data.signals(nvars).label=char(U);
        circuit.LTspice.data.signals(nvars).cmd=strtrim(tmpstr2{1});
        circuit.LTspice.data.signals(nvars).type='meas';
%         circuit.LTspice.log.meascmd{m}=strtrim(tmpstr2{1});
%         circuit.LTspice.log.measvalue{m}=str2double(strtrim(tmpstr2{2}));
        
        circuit.LTspice.data.signals(nvars).meas=str2double(strtrim(tmpstr2{2}));
%         m=m+1;
    end
    %     elseif contains(tline{ln},'Total elapsed time:')
    %         circuit.LTspice.log.ttimestr=tline{ln};
    
    %     elseif contains(tline{ln},'tnom') % Find tnom
    %         tmpstr=strsplit(tline{ln});
    %         circuit.LTspice.log.tnom=str2double(tmpstr{3});
    %     elseif contains(tline{ln},'temp')
    %         tmpstr=strsplit(tline{ln});
    %         circuit.LTspice.log.temp=str2double(tmpstr{3});
    %     end
end

circuit.LTspice.data.nvars=nvars;




