function logdata = getnetopdata(tmplogname)

fileID = fopen(tmplogname);

ln=1;
while ~feof(fileID)
    lline{ln} = fgetl(fileID);   % read line
    if contains(lline{ln},'Semiconductor Device Operating Points:')
        sdopline=ln;
    elseif contains(lline{ln},'Date:')
        dateline=ln; % Relevant info comes before this
    end
    if ~isempty(lline{ln}) % Discart empty lines
        ln=ln+1;
    end
end
fclose(fileID);
loglines=lline';

%  Semiconductor Device Operating Points:
sd=0;
for ln=sdopline+1:dateline-1
    if contains(loglines{ln},':') %
        tmpstr=strsplit(loglines{ln},':'); %
        tmpstr2=strsplit(strtrim(tmpstr{2}),' ');
        if contains(tmpstr{1},'Name') %
            sd=sd+1; % Device found
            logdata{sd}.Name = tmpstr2;
        elseif contains(tmpstr{1},'Model') %
            logdata{sd}.Model = tmpstr2;
        else
            varname = char(matlab.lang.makeValidName(char(tmpstr{1}),'ReplacementStyle','delete'));
            %             disp(['circuit.LTspice.log.sdop{sd}.' varname '=str2double(strtrim(tmpstr{2}));' ])
            eval(['logdata{sd}.' varname '=str2double(tmpstr2);' ])
        end
    end
end




