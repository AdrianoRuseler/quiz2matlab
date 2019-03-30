
function data = rawltspice(filename)
% Elapsed time is 0.053146 seconds.

tstart = tic;
fprintf('Extracting LTspice ASCII results ...\n');
    
if ~exist(filename,'file') % Verifica se existe o arquivo
    disp(['File not found:' filename ])
    data=[];
    return;
end

% tic

fileID = fopen(filename,'rb'); % Opens file
if fileID == -1
    disp(['Could not open:' filename ])
    data=[];
    return;
end

Line=1;
tline = cell(1,20); % Initial header size guess
tmpchar = fgetl(fileID);
if ~contains(tmpchar,'Title:') % Title
    disp('binary data!') % frewind(fileID);
    tline{Line}=tmpchar(1:2:end); % Convert
    data.rawfile.type='binary';
    data.rawfile.isbinary=1;
else
    disp('ascii data!')
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
            break;
        end
    else % Binary data
        tline{Line} = tmpchar;
        if contains(tline{Line},'Values:') % Find Values: line
            data.rawfile.valuesposition = ftell(fileID);
            dataArray = textscan(fileID,'%f%f%f', 'Delimiter', '\t', 'TextType', 'string', 'HeaderLines' ,0, 'ReturnOnError', false, 'EndOfLine', '\r\n'); % read data values
            fclose(fileID);
            data.rawfile.valuesline = Line+1;
            break;
        end
    end
    
%     disp(tline{Line})
    Line=Line+1; % increment line counter
end
% 

% 
data.rawfile.lines=tline;


% data.dataArray=dataArray;
% toc
%% Read header

linestr = strtrim(strsplit(tline{3},':')); % Plotname
data.plotname=linestr{2};

linestr = strtrim(strsplit(tline{4},':')); % Flags
data.flags=linestr{2};

linestr = strtrim(strsplit(tline{5},':')); % No. Variables:
data.nvars=str2double(linestr{2});

% Gets variables name
vars=cell(1,data.nvars); % reserve space
Line=data.rawfile.valuesline-data.nvars-1;
for nv=1:data.nvars % Why 9?
    vars{nv}=strsplit(strtrim(tline{Line}),char(9));
    U = matlab.lang.makeValidName(char(vars{nv}(2)),'ReplacementStyle','delete');
    data.signals(nv).label=char(U);
    data.signals(nv).type=char(vars{nv}(3));
    data.signals(nv).ID=str2double(char(vars{nv}(1)));
    Line=Line+1;
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
    fprintf('finished extracting LTspice ASCII results after %d seconds.\n',toc(tstart));
    return
else
    disp('RAW file is in ascii format!')
end


%% Variables: Get data points ascii
dlines=length(dataArray{1,1}); % Number of data lines
ind=1:data.nvars:dlines; % Index for time data points
data.id=dataArray{1,1}(ind(:));

if contains(tline{10},'time')
    data.time=dataArray{1,3}(ind(:));
    data.Ts=data.time(2)-data.time(1);
    for nv=2:data.nvars
        indv=nv:data.nvars:dlines;
        data.signals(nv-1).values=dataArray{1,2}(indv(:));
%         data.signals(nv-1).mean=mean(data.signals(nv-1).values);
%         data.signals(nv-1).rms=rms(data.signals(nv-1).values);        
    end
    
    
else % Its an .op simulation
%     data.time=[];
%     data.Ts=[];
    dataArray{1,2}(1)=dataArray{1,3}(1); % Correct first data row
    for nv=1:data.nvars
        indv=nv:data.nvars:dlines;
        data.signals(nv).op=dataArray{1,2}(indv(:)); % Reads data points in .op simulation
        data.signals(nv).values=dataArray{1,2}(indv(:)); % Reads data points in .op simulation        
    end       
end


%% Delete data file
% delete(filename) % Deleta arquivo de dados

data.dataArray=dataArray;

fprintf('finished extracting LTspice ASCII results after %d seconds.\n',toc(tstart));


