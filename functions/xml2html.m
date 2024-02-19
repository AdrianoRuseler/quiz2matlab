% =========================================================================
% *** xml2html
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

function xml2html(XMLfile) % Generate html report from moodle xml file

% XMLfile = 'somexmlfile.xml';
[fpath,fname,~] = fileparts(XMLfile);
% xml = xml2struct(XMLfile);
xml = readstruct(XMLfile); % Native function

% create the html file
header{1}='<!DOCTYPE html>';
header{2}='<html lang="pt-br">';
header{3}='<head>';
header{4}= ['<title>' fname '</title>'];
header{5}='  <meta charset="utf-8">';
header{6}='  <meta name="viewport" content="width=device-width, initial-scale=1">';
header{7}='  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">';
header{8}='  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>';
header{9}='</head>';
header{10}='<body>';

b=1;
for q=1:length(xml.question)
    body{b}=' '; b=b+1;
    body{b}='<div class="container mt-3">'; b=b+1;
    body{b}='   <div class="card">'; b=b+1;
    qname=xml.question(q).name.text; % Nome da questão
    % 'retry01q001(Vi=175V,fi=80Hz,Von=550mV,alfa=80grauseR0=1,3&Omega;)'
    body{b}=['      <div class="card-header"><h4>' qname '</h4></div>']; b=b+1;
    % body{b}=['<h3>' qname '</h3>']; b=b+1;

    qtext=xml.question(q).questiontext.text; % Enunciados e questões em html.
    % xml.quiz.question{q}.questiontext.Attributes.format  %  html.
    % body{b}=qtext; b=b+1;
    % qfiletext=<a download="hello.txt" href="data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==">File name</a>;
    if isfield(xml.question(q).questiontext,'file') % TODO fix new lines added
        qfname=xml.question(q).questiontext.file.nameAttribute;
        qtextfile=['<br>Baixar: <a download="' qfname '" href="data:text/plain;base64,' xml.question(q).questiontext.file.Text '">' qfname '</a>'];
        body{b}=['      <div class="card-body">' qtext qtextfile '</div>']; b=b+1;
    else
        body{b}=['      <div class="card-body">' qtext '</div>']; b=b+1;
    end

    btext=''; % init
    if isfield(xml.question(q),'generalfeedback') % TODO
        btext=[btext 'Generalfeedback: ' xml.question(q).generalfeedback.text '<br>'];
    end

    if isfield(xml.question(q),'penalty') % TODO
        btext=[btext 'Penalty: ' num2str(xml.question(q).penalty) '<br>'];
    end

    if isfield(xml.question(q),'hidden') % TODO
        btext=[btext 'Hidden: ' num2str(xml.question(q).hidden) '<br>'];
    end

    if isfield(xml.question(q),'idnumber') % TODO
        btext=[btext 'idnumber: ' xml.question(q).idnumber ];
    end

    body{b}=['      <div class="card-footer">' btext '</div>']; b=b+1;


    % xml.quiz.question{q}.Attributes.type  % Tipo da questão
    body{b}='   </div>'; b=b+1;
    body{b}='</div>'; b=b+1;
end


body{b}='</body>'; b=b+1;
body{b}='</html>'; b=b+1;
body{b}=' ';

% Create html file
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

