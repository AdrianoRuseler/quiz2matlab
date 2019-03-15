
function data = rawltspice(filename)
% Elapsed time is 0.053146 seconds.
% filename='F:\Dropbox\UTFPR\Moodle\MATLAB\LAB12\LAB12a5bb8a430d91f4a628c42613fc6299d85.raw';

tstart = tic;
fprintf('Extracting LTspice ASCII results ...\n');
    
if ~exist(filename,'file') % Verifica se existe o arquivo
    disp(['File not found:' filename ])
    data=[];
    return;
end

% tic
fileID = fopen(filename,'r'); % Opens file
if fileID == -1
    data=[];
    return;
end




Line=1;
tline = cell(1,20); % Initial header size guess
while ~feof(fileID) % Get header
    tline{Line} = fgetl(fileID); % Reads file lines
    if contains(tline{Line},'Values:') % Find Values: line
        dataArray = textscan(fileID,'%f%f%f', 'Delimiter', '\t', 'TextType', 'string', 'HeaderLines' ,0, 'ReturnOnError', false, 'EndOfLine', '\r\n'); % read data values
        break;
    elseif contains(tline{Line},'Binary:') % Find Binary data: line
        disp('Binary data!') %
        disp('Binary data!') %
        fclose(fileID);
        data=[];
        return;
    end
    Line=Line+1;
end
% 
fclose(fileID);

% data.dataArray=dataArray;
% toc
%% Read header

linestr = strtrim(strsplit(tline{3},':'));
data.plotname=linestr{2};

linestr = strtrim(strsplit(tline{4},':'));
data.flags=linestr{2};

linestr = strtrim(strsplit(tline{5},':'));
data.nvars=str2double(linestr{2});

linestr = strtrim(strsplit(tline{6},':'));
data.npoints=str2double(linestr{2});

linestr = strtrim(strsplit(tline{7},':'));
data.offset=str2double(linestr{2});

linestr = strtrim(strsplit(tline{8},':'));
data.command=linestr{2};

%% Variables: Get data points
dlines=length(dataArray{1,1}); % Number of data lines
ind=1:data.nvars:dlines; % Index for time data points
data.id=dataArray{1,1}(ind(:));

if contains(tline{10},'time')
    vline=11; % Start of variables line
    data.time=dataArray{1,3}(ind(:));
    data.Ts=data.time(2)-data.time(1);
    for nv=2:data.nvars
        indv=nv:data.nvars:dlines;
        data.signals(nv-1).values=dataArray{1,2}(indv(:));
%         data.signals(nv-1).mean=mean(data.signals(nv-1).values);
%         data.signals(nv-1).rms=rms(data.signals(nv-1).values);        
    end
    
    
else % Its an .op simulation
    vline=10; % Start of variables line
%     data.time=[];
%     data.Ts=[];
    dataArray{1,2}(1)=dataArray{1,3}(1); % Correct first data row
    for nv=1:data.nvars
        indv=nv:data.nvars:dlines;
        data.signals(nv).op=dataArray{1,2}(indv(:)); % Reads data points in .op simulation
    end   
    
end

% Index exceeds the number of array elements (1).
% 
% Error in rawltspice (line 91)
%     U = matlab.lang.makeValidName(char(vars{nv}(2)),'ReplacementStyle','delete');
% 
% Error in LTspiceSim (line 120)
%     data = rawltspice(simoprawfile); % Read data

%% Gets variables name
nv=1;
vars=cell(1,data.nvars); % reserve space

for Line=vline:9+data.nvars % Why 9?
    vars{nv}=strsplit(strtrim(tline{Line}),char(9));
    U = matlab.lang.makeValidName(char(vars{nv}(2)),'ReplacementStyle','delete');
    data.signals(nv).label=char(U);
    data.signals(nv).type=char(vars{nv}(3));
    data.signals(nv).ID=str2double(char(vars{nv}(1)));
    nv=nv+1;
end
% 
% nv=1;
% vars=cell(1,data.nvars); % reserve space
% vline=11; % Ajuste ???
% for Line=vline:10+data.nvars % Why 9?
%     vars{nv}=strsplit(strtrim(tline{Line}),char(9));
%     U = matlab.lang.makeValidName(char(vars{nv}(2)),'ReplacementStyle','delete');
%     data.signals(nv).label=char(U);
%     data.signals(nv).type=char(vars{nv}(3));
%     data.signals(nv).ID=str2double(char(vars{nv}(1)));
%     nv=nv+1;
% end

%% Delete data file
% delete(filename) % Deleta arquivo de dados



fprintf('finished extracting LTspice ASCII results after %d seconds.\n',toc(tstart));


