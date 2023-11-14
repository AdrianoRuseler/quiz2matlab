% =========================================================================
% *** cloze2moodle
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

function cloze2mdl(quizstruct) % Generate xml file

% Create the document node and root element, toc:
import matlab.io.xml.dom.*
docNode = Document('quiz');
docRootNode = getDocumentElement(docNode);

writer = matlab.io.xml.dom.DOMWriter;
writer.Configuration.FormatPrettyPrint = true;

if isfield(quizstruct,'xmlpath')
    if ~exist(quizstruct.xmlpath,'dir')
        mkdir(quizstruct.xmlpath) % Sem verificação de erro
    end
else
    quizstruct.xmlpath=pwd;
end


% Compatibilidade
if ~isfield(quizstruct,'comb')
    quizstruct.comb=1:quizstruct.questionnumbers;
end

% Date and time string
dt = char(datetime('now','Format','yyyMMddHHmmss'));

file=1;
n=1;
for co=1:length(quizstruct.comb)
    q=quizstruct.comb(co);

    % Add the comment:
    if isfield(quizstruct.question,'comment')
        appendChild(docRootNode,createComment(docNode,quizstruct.question.comment{q})); % Add question comment
    else
        appendChild(docRootNode,createComment(docNode,quizstruct.question.name{q})); % Add question comment
    end

    % Question field
    question = createElement(docNode,'question');
    setAttribute(question,'type',quizstruct.question.type);

    % Question name
    name = createElement(docNode,'name');
    nametext = createElement(docNode,'text');
    appendChild(nametext,createTextNode(docNode,quizstruct.question.name{q})); % Coloca nome
    appendChild(name,nametext);
    appendChild(question,name);


    % Question  text
    questiontext = createElement(docNode,'questiontext');
    setAttribute(questiontext,'format','html');
    questiontexttext = createElement(docNode,'text');
    % appendChild(questiontexttext,createTextNode(docNode,quizstruct.question.text{q}));
    appendChild(questiontexttext,createCDATASection(docNode,quizstruct.question.text{q})); % CDATA
    appendChild(questiontext,questiontexttext);
    appendChild(question,questiontext);


    % Add file to question NOT TESTED YET
    if isfield(quizstruct.question,'filename') % Add model file with link to it
        questiontextfile = createElement(docNode,'file');
        setAttribute(questiontext,'name',quizstruct.question.filename{q});
        setAttribute(questiontext,'path','/');
        setAttribute(questiontext,'encoding','base64');
        appendChild(questiontext,questiontextfile);
        appendChild(questiontextfile,createTextNode(docNode,quizstruct.question.filebase64code{q}));
    end

    % Question generalfeedback
    if isfield(quizstruct.question,'generalfeedback')
        generalfeedback = createElement(docNode,'generalfeedback');
        setAttribute(generalfeedback,'format','html');
        generalfeedbacktext = createElement(docNode,'text');
        appendChild(generalfeedbacktext,createTextNode(docNode,quizstruct.question.generalfeedback{q})); % Coloca feedback geral da pergunta
        appendChild(generalfeedback,generalfeedbacktext);
        appendChild(question,generalfeedback);
    end

    if isfield(quizstruct.question,'penalty')
        penalty = createElement(docNode,'penalty');
        appendChild(penalty,createTextNode(docNode,quizstruct.question.penalty{q}));
        appendChild(question,penalty);
    end

    if isfield(quizstruct.question,'hidden')
        hidden = createElement(docNode,'hidden');
        appendChild(hidden,createTextNode(docNode,quizstruct.question.hidden{q}));
        appendChild(question,hidden);
    end

    if isfield(quizstruct.question,'idnumber')
        hidden = createElement(docNode,'idnumber');
        appendChild(hidden,createTextNode(docNode,quizstruct.question.idnumber{q}));
        appendChild(question,hidden);
    end

    appendChild(docRootNode,question);

    % More than one xml file
    if n==quizstruct.questionMAX
        %
        XMLfile=[quizstruct.xmlpath '\' quizstruct.name 'F' num2str(file,'%02i') 'D' dt 'NQ' num2str(quizstruct.questionnumbers,'%03i') '.xml'];
        writeToFile(writer,docNode,XMLfile);

        % New xml file
        docNode = Document('quiz');
        docRootNode = getDocumentElement(docNode);

        n=1;
        file=file+1;
    end
    n=n+1;
end

% dt = datestr(now,'yyyymmddTHHMMSS');
XMLfile=[quizstruct.xmlpath '\' quizstruct.name 'F' num2str(file,'%02i') 'D' dt 'NQ' num2str(quizstruct.questionnumbers,'%03i') '.xml'];
writeToFile(writer,docNode,XMLfile);

xml2html(XMLfile); % Generate html report

winopen(quizstruct.xmlpath)
