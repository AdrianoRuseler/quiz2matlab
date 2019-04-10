
% Read raw LTspice ascii file
function data = rawltascii(filename)
% data = rawltascii(circuit.LTspice.raw.file)


if ~exist(filename,'file') % Verifica se existe o arquivo
    disp(['File not found: ' filename ])
    data=[];
    return;
end

% tic
fileID = fopen(filename,'r'); % Opens file
if fileID == -1
    disp(['Could not open file: ' filename ])
    data=[];
    return;
end


% read content from ASCII result file
fileID = fopen(filename);
    content = textscan(fileID,'%s','delimiter','\n');
fclose(fileID);

data.lines=content{1};


% Line=1;
% tline = cell(1,20); % Initial header size guess
% while ~feof(fileID) % Get header
%     tline{Line} = fgetl(fileID); % Reads file lines
%     
%     
%     Line=Line+1;
% end
% % 
% fclose(fileID);
% 
% 
% data.ind.vars
% 
% data.ind.values
% 
% 
%  if contains(tline{l},'tnom') % Find tnom
%         tmpstr=strsplit(tline{l});
%         circuit.LTspice.log.tnom=str2double(tmpstr{3});
%     elseif contains(tline{l},'temp')
%         tmpstr=strsplit(tline{l});
%         circuit.LTspice.log.temp=str2double(tmpstr{3});
%     end