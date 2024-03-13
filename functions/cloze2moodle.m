% =========================================================================
% *** cloze2moodle -->> cloze2mdl 
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

function cloze2moodle(quizstruct) % Generate xml file

% Create the document node and root element, toc:
docNode = com.mathworks.xml.XMLUtils.createDocument('quiz');
% Identify the root element, and set the version attribute:
quiz = docNode.getDocumentElement;
% toc.setAttribute('version','2.0');

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


file=1;
n=1;
for co=1:length(quizstruct.comb)
    q=quizstruct.comb(co);
    question = docNode.createElement('question');
    question.setAttribute('type',quizstruct.question.type);
    quiz.appendChild(question);
    
    % Add the comment:
    question.appendChild(docNode.createComment(quizstruct.question.name{q}));
    
    % Question name
    name = docNode.createElement('name');
    nametext = docNode.createElement('text');
    question.appendChild(name);
    name.appendChild(nametext);
    nametext.appendChild(docNode.createTextNode(quizstruct.question.name{q})); % Coloca nome
    
    
    % Question  text
    questiontext = docNode.createElement('questiontext');
    questiontext.setAttribute('format','html');
    questiontexttext = docNode.createElement('text');
    question.appendChild(questiontext);
    questiontext.appendChild(questiontexttext);
    questiontexttext.appendChild(docNode.createTextNode(quizstruct.question.text{q})); % Coloca pergunta
    
    % Add file to question    
    if isfield(quizstruct.question,'filename') % Add model file with link to it        
        questiontextfile = docNode.createElement('file');
        questiontextfile.setAttribute('name',quizstruct.question.filename{q});
        questiontextfile.setAttribute('path','/');
        questiontextfile.setAttribute('encoding','base64');
        questiontext.appendChild(questiontextfile);
        questiontextfile.appendChild(docNode.createTextNode(quizstruct.question.filebase64code{q})); % Coloca pergunta
    end
    
    
    % Question generalfeedback
    generalfeedback = docNode.createElement('generalfeedback');
    generalfeedback.setAttribute('format','html');
    generalfeedbacktext = docNode.createElement('text');
    question.appendChild(generalfeedback);
    generalfeedback.appendChild(generalfeedbacktext);
    generalfeedbacktext.appendChild(docNode.createTextNode(quizstruct.question.generalfeedback{q})); % Coloca feddback da pergunta
    
    
    penalty = docNode.createElement('penalty');
    penalty.appendChild(docNode.createTextNode(quizstruct.question.penalty{q}));
    question.appendChild(penalty);
    
    hidden = docNode.createElement('hidden');
    hidden.appendChild(docNode.createTextNode(quizstruct.question.hidden{q}));
    question.appendChild(hidden);
    
    
    if n==quizstruct.questionMAX
        %         xmlwrite([quizstruct.xmlpath '\' quizstruct.name 'f' num2str(file,'%02i') '.xml'],docNode);
        dt = datestr(now,'yyyymmddTHHMMSS');
        xmlwrite([quizstruct.xmlpath '\' quizstruct.name 'F' num2str(file,'%02i') 'D' dt 'NQ' num2str(quizstruct.questionnumbers,'%03i') '.xml'],docNode);
        
        % Create the document node and root element, toc:
        docNode = com.mathworks.xml.XMLUtils.createDocument('quiz');
        % Identify the root element, and set the version attribute:
        quiz = docNode.getDocumentElement;
        % toc.setAttribute('version','2.0');
        n=1;
        file=file+1;
    end
    n=n+1;
end

dt = char(datetime('now','Format','yyyMMddHHmmss'));

% dt = datestr(now,'yyyymmddTHHMMSS');
XMLfile=[quizstruct.xmlpath '\' quizstruct.name 'F' num2str(file,'%02i') 'D' dt 'NQ' num2str(quizstruct.questionnumbers,'%03i') '.xml'];

xmlwrite(XMLfile,docNode);

xml2html(XMLfile); % Generate html report

winopen(quizstruct.xmlpath)
