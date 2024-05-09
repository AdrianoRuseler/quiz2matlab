
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

if(circuit.LTspice.data.error)
    disp(circuit.LTspice.log.lines)
    return;
end

% circuit.LTspice.log.lines{1}

tmpstr=strsplit(tline{1});
circuit.LTspice.log.circuit=tmpstr{3}; % Circuit file


if isfield(circuit,'cmdtype')
    switch circuit.cmdtype
        case '.ac'
            % Semiconductor Device Operating Points
            for ln=3:length(tline)
                if contains(tline{ln},'Semiconductor Device Operating Points:')
                    circuit.LTspice.log.sdopline=ln;
                elseif contains(tline{ln},'Date:')
                    circuit.LTspice.log.datesrt=tline{ln}(7:end); % Gets data str
                    circuit.LTspice.log.dateline=ln; % Relevant info comes before this
                    break
                end
            end
            circuit.LTspice.log.status=tline{2}; % Simulation method used and status
            % Semiconductor Device Operating Points?
            sd =0;
            if isfield(circuit.LTspice.log,'sdopline')
                sdopline=circuit.LTspice.log.sdopline+1;
            else
                sdopline=3;
            end
            
        case '.op'
            % Semiconductor Device Operating Points
            for ln=3:length(tline)
                if contains(tline{ln},'Semiconductor Device Operating Points:')
                    circuit.LTspice.log.sdopline=ln;
                elseif contains(tline{ln},'Date:')
                    circuit.LTspice.log.datesrt=tline{ln}(7:end); % Gets data str
                    circuit.LTspice.log.dateline=ln; % Relevant info comes before this
                    break
                end
            end
            circuit.LTspice.log.status=tline{2}; % Simulation method used and status
            % Semiconductor Device Operating Points?
            sd =0;
            if isfield(circuit.LTspice.log,'sdopline')
                sdopline=circuit.LTspice.log.sdopline+1;
            else
                sdopline=3;
            end
            
        case '.tran' % .tran Tprint Tstop Tstart
            for ln=3:length(tline)
                if contains(tline{ln},'Date:')
                    circuit.LTspice.log.datesrt=tline{ln}(7:end); % Gets data str
                    circuit.LTspice.log.dateline=ln; % Relevant info comes before this
                    break
                end
            end
            circuit.LTspice.log.status=tline{2}; % Simulation method used and status
            sdopline=3;
            
        otherwise
            disp('cmdtype otherwise!!')
    end
else
    disp('cmdtype not found!!')
end


if ~isfield(circuit.LTspice.log,'dateline')
    disp('dateline NOT FOUMD!!')
    disp(tline)
end


%  Semiconductor Device Operating Points:
for ln=sdopline:circuit.LTspice.log.dateline
    if contains(tline{ln},'=') || contains(tline{ln},'Date') % .meas field or end of Semiconductor info
        circuit.LTspice.log.measline = ln;
        break;
    elseif contains(tline{ln},':') %
        tmpstr=strsplit(tline{ln},':'); %
        tmpstr2=strsplit(strtrim(tmpstr{2}),' ');
        if contains(tmpstr{1},'Name') %
            sd=sd+1; % Device found
            circuit.LTspice.log.sdop{sd}.Name = tmpstr2;
        elseif contains(tmpstr{1},'Model') %
            circuit.LTspice.log.sdop{sd}.Model = tmpstr2;
        elseif contains(tmpstr{1},'Warning') %
            disp(tline{ln})
        else
            varname = char(matlab.lang.makeValidName(char(tmpstr{1}),'ReplacementStyle','delete'));
            %             disp(['circuit.LTspice.log.sdop{sd}.' varname '=str2double(strtrim(tmpstr{2}));' ])
            eval(['circuit.LTspice.log.sdop{sd}.' varname '=str2double(tmpstr2);' ])
        end
    end
end


if ~isfield(circuit.LTspice.log,'measline')
    circuit.LTspice.log.measline = ln;
end


nvars = length(circuit.LTspice.data.signals);
for ln=circuit.LTspice.log.measline:circuit.LTspice.log.dateline
    if contains(tline{ln},'=') && contains(tline{ln},':')% .meas field
        if contains(tline{ln},'FROM')
            tmpstr0=strsplit(tline{ln},'FROM'); % Varname
            tmpstr1=strsplit(tmpstr0{1},':'); % Varname
        else
            tmpstr1=strsplit(tline{ln},':'); % Varname
        end
        tmpstr2=strsplit(strtrim(tmpstr1{2}),'=');
        
        nvars=nvars+1;
        U = matlab.lang.makeValidName(char(tmpstr1{1}),'ReplacementStyle','delete');
        circuit.LTspice.data.signals(nvars).label=char(U);
        circuit.LTspice.data.signals(nvars).cmd=strtrim(tmpstr2{1});
        circuit.LTspice.data.signals(nvars).type='meas';
        circuit.LTspice.data.signals(nvars).meas=str2double(strtrim(tmpstr2{2}));
        
        varname = char(matlab.lang.makeValidName(char(tmpstr1{1}),'ReplacementStyle','delete'));
        % disp(['circuit.LTspice.log.meas.' varname '=str2double(strtrim(tmpstr2{2}));' ])
        eval(['circuit.LTspice.log.meas.' varname '=str2double(strtrim(tmpstr2{2}));' ])
        
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

circuit.LTspice.data.nvars=length(circuit.LTspice.data.signals);






