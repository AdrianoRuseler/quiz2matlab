% =========================================================================
% *** cloze2ioxml
% clozes.xmlpath=pwd;
% clozes.fname='qfilename';
% 
% % Create question 1
% clozes.q(1).name='Q01 name';
% clozes.q(1).comment='comment for Q01';
% clozes.q(1).text='Q01: {1:MULTICHOICE:California#Wrong~%100%Arizona#OK}';
% clozes.q(1).feedback='Q01 feedback';
% clozes.q(1).penalty='0.25';
% clozes.q(1).hidden='0';
% 
% cloze2ioxml(clozes)
%
% =========================================================================

function cloze2ioxml(clozes) % Generate xml file


if isfield(clozes,'xmlpath')
    if ~exist(clozes.xmlpath,'dir')
        mkdir(clozes.xmlpath) % Sem verificação de erro
    end
else
    clozes.xmlpath=pwd;
end

% Number os questions
if isfield(clozes,'q')
    nq=length(clozes.q);
else
    disp('No questions in cloze struct!')
    return
end



% Create the document node and root element, toc:
import matlab.io.xml.dom.*
docNode = Document('quiz');
docRootNode = getDocumentElement(docNode);

for q=1:nq

    appendChild(docRootNode,createComment(docNode,clozes.q(q).comment)); % Add question comment

    question = createElement(docNode,'question');
    setAttribute(question,'type','cloze');

     % Question name
    name = createElement(docNode,'name');
    nametext = createElement(docNode,'text');
    appendChild(nametext,createTextNode(docNode,clozes.q(q).name)); % Coloca nome
    appendChild(name,nametext);
    appendChild(question,name);

   
    questiontext = createElement(docNode,'questiontext');
    setAttribute(questiontext,'format','html');
    questiontexttext = createElement(docNode,'text');
    % appendChild(questiontexttext,createTextNode(docNode,weekdays(i)));
    appendChild(questiontexttext,createCDATASection(docNode,clozes.q(q).text));
    appendChild(questiontext,questiontexttext);
    appendChild(question,questiontext);

    % Question generalfeedback
    generalfeedback = createElement(docNode,'generalfeedback');
    setAttribute(generalfeedback,'format','html');
    generalfeedbacktext = createElement(docNode,'text');
    appendChild(generalfeedbacktext,createTextNode(docNode,clozes.q(q).feedback)); % Coloca feedback da pergunta
    appendChild(generalfeedback,generalfeedbacktext);
    appendChild(question,generalfeedback);


    penalty = createElement(docNode,'penalty');
    appendChild(penalty,createTextNode(docNode,clozes.q(q).penalty));
    appendChild(question,penalty);

    hidden = createElement(docNode,'hidden');
    appendChild(hidden,createTextNode(docNode,clozes.q(q).hidden));
    appendChild(question,hidden);

    appendChild(docRootNode,question);
end

dt = char(datetime('now','Format','yyyMMddHHmmss'));

% dt = datestr(now,'yyyymmddTHHMMSS');
XMLfile=[clozes.xmlpath '\' clozes.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];


writer = matlab.io.xml.dom.DOMWriter;

writer.Configuration.FormatPrettyPrint = true;
writeToFile(writer,docNode,XMLfile);

type(XMLfile);


winopen(clozes.xmlpath)
