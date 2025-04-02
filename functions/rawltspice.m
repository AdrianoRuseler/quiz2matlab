
function data = rawltspice(data)
% Elapsed time is 0.053146 seconds.
% % datax = LTspice2Matlab(data.filename)

data.error=0;
data.errorlog='';

% if ~checkSoftwareVersion('LTspice',17)
%     data.errorlog='Version is NOT supported (> 17)';
%     data.error=1;
%     return
% end

tstart = tic;
fprintf('Extracting LTspice ASCII results ...\n');
disp(data.paramstr)

if ~exist(data.filename,'file') % Verifica se existe o arquivo
    data.errorlog = ['File not found:' data.filename ];
    disp(data.errorlog)
    %     data=[];
    data.error=1;
    return;
end

% tic

fileID = fopen(data.filename,'rb'); % Opens file
if fileID == -1
    data.errorlog = ['Could not open:' data.filename ];
    disp(data.errorlog)
    %     data=[];
    data.error=1;
    return;
end

Line=1;
tline = cell(1,20); % Initial header size guess
tmpchar = fgetl(fileID);
if ~contains(tmpchar,'Title:') % Title
    %     disp('binary data!') % frewind(fileID);
    tline{Line}=tmpchar(1:2:end); % Convert
    data.rawfile.type='binary';
    data.rawfile.isbinary=1;
else
    %     disp('ascii data!')
    tline{Line}=tmpchar; % Convert
    data.rawfile.type='ascii';
    data.rawfile.isbinary=0;
end

Line=Line+1; % increment line counter
while ~feof(fileID) % Get header
    tmpchar = fgetl(fileID);
    if data.rawfile.isbinary
        tline{Line}=tmpchar(2:2:end); % Convert
        if contains(tline{Line},'Binary:') % Find Values: line
            data.rawfile.valuesline = Line+1;
            data.rawfile.valuesposition = ftell(fileID);
            disp('Binary DATA!!!')
            break;
        end
    else % ascii data
        tline{Line} = tmpchar;
        if contains(tline{Line},'Values:') % Find Values: line
            data.rawfile.valuesposition = ftell(fileID);
            try
                dataArray = textscan(fileID,'%f%f%f', 'Delimiter', '\t', 'TextType', 'string', 'HeaderLines' ,0, 'ReturnOnError', false, 'EndOfLine', '\r\n'); % read data values
            catch ME                
                data.ME=ME;
                data.errorlog = ME.message;
                disp(data.errorlog)
                data.error=0; %  Bypass this for now
                fclose(fileID);
                return;
            end

            fclose(fileID);
            data.rawfile.valuesline = Line+1;
            break;
        end
    end
    %     disp(tline{Line})
    Line=Line+1; % increment line counter
end

%
data.rawfile.lines=tline;

if contains(tline{10},'time') % Exist time vector?
    data.containstime=1; % Yes
else
    data.containstime=0; % No
end



% data.dataArray=dataArray;
% toc
%% Read header

linestr = strtrim(strsplit(tline{3},':')); % Plotname
data.plotname=linestr{2};

linestr = strtrim(strsplit(tline{4},':')); % Flags
data.flags=linestr{2};

linestr = strtrim(strsplit(tline{5},':')); % No. Variables:
data.nvars=str2double(linestr{2});

%
% Gets variables name
vars=cell(1,data.nvars); % reserve space
if isfield(data.rawfile,'valuesline')
    Line=data.rawfile.valuesline-data.nvars-1;
    if data.containstime % Time data
        Line=Line+1; % skip time variable
        for nv=2:data.nvars %
            vars{nv}=strsplit(strtrim(tline{Line}),char(9));
            U = matlab.lang.makeValidName(char(vars{nv}(2)),'ReplacementStyle','delete');
            data.signals(nv-1).label=char(U);
            data.signals(nv-1).type=char(vars{nv}(3));
            %         data.signals(nv-1).ID=str2double(char(vars{nv}(1)));
            Line=Line+1;
        end
    else % No time data
        for nv=1:data.nvars % OK
            vars{nv}=strsplit(strtrim(tline{Line}),char(9));
            U = matlab.lang.makeValidName(char(vars{nv}(2)),'ReplacementStyle','delete');
            data.signals(nv).label=char(U);
            data.signals(nv).type=char(vars{nv}(3));
            %         data.signals(nv).ID=str2double(char(vars{nv}(1)));
            Line=Line+1;
        end
    end
else
    data.errorlog = ['No valuesline found:' data.filename ];
    disp(data.errorlog)
    data.error=1;
    return
end

linestr = strtrim(strsplit(tline{6},':')); % No. Points:
data.npoints=str2double(linestr{2});

linestr = strtrim(strsplit(tline{7},':')); % Offset:
data.offset=str2double(linestr{2});

linestr = strtrim(strsplit(tline{8},':')); % Command:
data.command=linestr{2};

%% Get data binary

if data.rawfile.isbinary
    disp('RAW file is in binary format!')
    fseek(fileID,data.rawfile.valuesposition+1, 'bof'); % data position
    vardata = fread(fileID, 1, 'double'); % .op

    data.signals(1).op=vardata; % Reads data points in .op simulation
    data.signals(1).values=vardata; % Reads data points in .op simulation
    for nv=2:data.nvars
        vardata=fread(fileID,1,'single');
        data.signals(nv).op=vardata; % Reads data points in .op simulation
        data.signals(nv).values=vardata; % Reads data points in .op simulation
    end

    fclose(fileID);
    fprintf('Finished extracting LTspice ASCII results after %d seconds.\n',toc(tstart));
    return
else
    disp('RAW file is in ascii format!')
end


%% Variables: Get data points ascii
dlines=length(dataArray{1,1}); % Number of data lines
ind=1:data.nvars:dlines; % Index for time data points
data.id=dataArray{1,1}(ind(:));

if data.containstime % contains(tline{10},'time')
    data.time=dataArray{1,3}(ind(:)); % Extracts time
    data.Ts=mean(diff(data.time));
    for nv=2:data.nvars
        indv=nv:data.nvars:dlines;  % Create variables indices in data array
        data.signals(nv-1).values=dataArray{1,2}(indv(:));
    end

else % No time vector
    dataArray{1,2}(1)=dataArray{1,3}(1); % Correct first data row
    for nv=1:data.nvars
        indv=nv:data.nvars:dlines; % Create variables indices in data array
        data.signals(nv).op=dataArray{1,2}(indv(:)); % Reads data points in .op simulation
    end
end


%% Delete data file
% delete(filename) % Deleta arquivo de dados

data.dataArray=dataArray;

fprintf('Finished extracting LTspice ASCII results after %d seconds.\n',toc(tstart));


