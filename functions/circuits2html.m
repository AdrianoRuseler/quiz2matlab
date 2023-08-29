% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2023 AdrianoRuseler
% ***
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% ***
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% ***
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================
% Generate html report from circuits

% xml2html(XMLfile); % Generate html report from circuits


function circuits2html(circuits) % Generate html report from circuits struct

printtable=1; % Print data table
rfields = {'values','dimensions','title','plotStyle'}; % Remove Fields from table

printchart=1; % Print chart
printploty=1;

[~,y]=size(circuits);

dt = char(datetime('now','Format','yyyMMddHHmmss'));
fname=[circuits{1}.name 'q' num2str(y,'%03i') 'T' dt];
fpath=[circuits{1}.dir 'reports\'];

% create the html file
header{1}='<!DOCTYPE html>';
header{2}='<html lang="pt-br">';
header{3}='<head>';
header{4}= ['<title>' fname '</title>'];
header{5}='  <meta charset="utf-8">';
header{6}='  <meta name="viewport" content="width=device-width, initial-scale=1">';
header{7}='  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">';
header{8}='  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>';
header{9}='  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>';
header{10}='  <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>';
header{11}='</head>';
header{12}='<body>';
b=1;

for c=1:y % circuit loop
    body{b}=' '; b=b+1;
    body{b}='<div class="container mt-3">'; b=b+1;
    body{b}='   <div class="card">'; b=b+1;
    body{b}=['      <div class="card-header"><h4>' circuits{c}.name 'q' num2str(c,'%03i') '(' circuits{c}.parstr ')</h4></div>']; b=b+1;
    body{b}=['      <div class="card-body">' circuits{c}.quiz.text '</div>']; b=b+1;
    if printtable
        intable=rmfield(circuits{c}.PSIMCMD.data.signals,rfields); % Remove Fields
        table=signal2htmltable(intable);
        body{b}=['      <div class="card-footer"><p><code>' circuits{c}.PSIMCMD.simctrl '</code></p>' table '</div>']; b=b+1;
    else
        body{b}=['      <div class="card-footer"><p><code>' circuits{c}.PSIMCMD.simctrl '</code></p></div>']; b=b+1;
    end

    if printchart
        % intable=rmfield(circuits{c}.PSIMCMD.data.signals,rfields); % Remove Fields
        chart=signal2htmlchart(circuits{c}.PSIMCMD.data);
        body{b}=['      <div class="card-footer"><p><code>' circuits{c}.PSIMCMD.simctrl '</code></p>' chart '</div>']; b=b+1;
    else
        body{b}=['      <div class="card-footer"><p><code>' circuits{c}.PSIMCMD.simctrl '</code></p></div>']; b=b+1;
    end

    if printploty
        % intable=rmfield(circuits{c}.PSIMCMD.data.signals,rfields); % Remove Fields
        ploty=signal2htmlploty(circuits{c}.PSIMCMD.data);
        body{b}=['      <div class="card-footer"><p><code>' circuits{c}.PSIMCMD.simctrl '</code></p>' ploty '</div>']; b=b+1;
    else
        body{b}=['      <div class="card-footer"><p><code>' circuits{c}.PSIMCMD.simctrl '</code></p></div>']; b=b+1;
    end

    body{b}='   </div>'; b=b+1;
    body{b}='</div>'; b=b+1;
end

% <p><code>circuits{c}.PSIMCMD.simctrl</code></p>
% circuits{c}.PSIMCMD.simctrl

body{b}='</body>'; b=b+1;
body{b}='</html>'; b=b+1;
body{b}=' ';

% Create html file
if ~exist(fpath,'dir')
    mkdir(fpath)
end

fileID = fopen([fpath '\' fname '.html'],'w','n','UTF-8');
if fileID==-1
    disp('File error!!')
    return
end

for h=1:length(header)
    fprintf(fileID,'%s\n',header{h}); % Write header
end

for b=1:length(body)
    fprintf(fileID,'%s\n',body{b}); % Write body
end

fclose(fileID);

web([fpath '\' fname '.html']) % opens html file





