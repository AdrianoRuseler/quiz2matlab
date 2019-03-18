% =========================================================================
% *** multichoice2moodle
% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2016 AdrianoRuseler
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

function multichoice2moodle(quizstruct)

% feature('DefaultCharacterSet')

% Create the document node and root element, toc:
docNode = com.mathworks.xml.XMLUtils.createDocument('quiz');

% Identify the root element, and set the version attribute:
quiz = docNode.getDocumentElement;
% toc.setAttribute('version','2.0');

file=1;
n=1;
for q=1:quizstruct.questionnumbers %
    
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
    
    if isfield(quizstruct.question, 'filename')
        questiontextfile = docNode.createElement('file');
        questiontextfile.setAttribute('name',quizstruct.question.filename{q});
        questiontextfile.setAttribute('path',quizstruct.question.filepath{q});
        questiontextfile.setAttribute('encoding',quizstruct.question.fileencoding{q});
        questiontext.appendChild(questiontextfile);
        questiontextfile.appendChild(docNode.createTextNode(quizstruct.question.filedata{q})); % Coloca dados em base64
    end
    
    % Question generalfeedback
    generalfeedback = docNode.createElement('generalfeedback');
    generalfeedback.setAttribute('format','html');
    generalfeedbacktext = docNode.createElement('text');
    question.appendChild(generalfeedback);
    generalfeedback.appendChild(generalfeedbacktext);
    generalfeedbacktext.appendChild(docNode.createTextNode(quizstruct.question.generalfeedback{q})); % Coloca feddback da pergunta
    
    for a=1:quizstruct.question.answernumbers{q}
        % Question answer
        answer = docNode.createElement('answer');
        answer.setAttribute('fraction',quizstruct.question.answerfraction{q}{a});
%         answer.setAttribute('format','moodle_auto_format');
         answer.setAttribute('format','html');
        
        answertext = docNode.createElement('text');
        question.appendChild(answer);
        answer.appendChild(answertext);
        answertext.appendChild(docNode.createTextNode(quizstruct.question.answer{q}{a})); % Coloca feddback da pergunta
        
        if isfield(quizstruct.question, 'answerfilename')
            answertextfile = docNode.createElement('file');
            answertextfile.setAttribute('name',quizstruct.question.answerfilename{q}{a});
            answertextfile.setAttribute('path',quizstruct.question.answerfilepath{q}{a});
            answertextfile.setAttribute('encoding',quizstruct.question.answerfileencoding{q}{a});
            answer.appendChild(answertextfile);
            answertextfile.appendChild(docNode.createTextNode(quizstruct.question.answerfiledata{q}{a})); % Coloca dados em base64
        end
        
        answerfeedback = docNode.createElement('feedback');
        answerfeedback.setAttribute('format','html');
        answer.appendChild(answerfeedback);
        
        answerfeedbacktext = docNode.createElement('text');
        answerfeedbacktext.appendChild(docNode.createTextNode(quizstruct.question.answerfeedback{q}{a})); % Coloca feddback da pergunta
        answerfeedback.appendChild(answerfeedbacktext);
    end
    
    
    defaultgrade = docNode.createElement('defaultgrade');
    defaultgrade.appendChild(docNode.createTextNode(quizstruct.question.defaultgrade{q}));
    question.appendChild(defaultgrade);
    
    penalty = docNode.createElement('penalty');
    penalty.appendChild(docNode.createTextNode(quizstruct.question.penalty{q}));
    question.appendChild(penalty);
    
    hidden = docNode.createElement('hidden');
    hidden.appendChild(docNode.createTextNode(quizstruct.question.hidden{q}));
    question.appendChild(hidden);
    
    unitgradingtype = docNode.createElement('unitgradingtype');
    unitgradingtype.appendChild(docNode.createTextNode(quizstruct.question.unitgradingtype{q}));
    question.appendChild(unitgradingtype);
    
    unitpenalty = docNode.createElement('unitpenalty');
    unitpenalty.appendChild(docNode.createTextNode(quizstruct.question.unitpenalty{q}));
    question.appendChild(unitpenalty);
    
    showunits = docNode.createElement('showunits');
    showunits.appendChild(docNode.createTextNode(quizstruct.question.showunits{q}));
    question.appendChild(showunits);
    
    unitsleft = docNode.createElement('unitsleft');
    unitsleft.appendChild(docNode.createTextNode(quizstruct.question.unitsleft{q}));
    question.appendChild(unitsleft);
    
    single = docNode.createElement('single');
    single.appendChild(docNode.createTextNode(quizstruct.question.single{q}));
    question.appendChild(single);
    
    shuffleanswers = docNode.createElement('shuffleanswers');
    shuffleanswers.appendChild(docNode.createTextNode(quizstruct.question.shuffleanswers{q}));
    question.appendChild(shuffleanswers);
    
    answernumbering = docNode.createElement('answernumbering');
    answernumbering.appendChild(docNode.createTextNode(quizstruct.question.answernumbering{q}));
    question.appendChild(answernumbering);
    
    correctfeedback = docNode.createElement('correctfeedback');
    correctfeedback.appendChild(docNode.createTextNode(quizstruct.question.correctfeedback));
    question.appendChild(correctfeedback);
    
    partiallycorrectfeedback = docNode.createElement('partiallycorrectfeedback');
    partiallycorrectfeedback.appendChild(docNode.createTextNode(quizstruct.question.partiallycorrectfeedback));
    question.appendChild(partiallycorrectfeedback);
    
    incorrectfeedback = docNode.createElement('incorrectfeedback');
    incorrectfeedback.appendChild(docNode.createTextNode(quizstruct.question.incorrectfeedback));
    question.appendChild(incorrectfeedback);
    
        if n==quizstruct.questionMAX
        xmlwrite([quizstruct.name num2str(file) '.xml'],docNode);        
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

xmlwrite([quizstruct.name '.xml'],docNode);


winopen(pwd)

