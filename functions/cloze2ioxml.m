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
% clozes.q(1).idnumber='id0';
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

writer = matlab.io.xml.dom.DOMWriter;
writer.Configuration.FormatPrettyPrint = true;

dt = char(datetime('now','Format','yyyMMddHHmmss'));

for q=1:nq
    % Add question comment
    if isfield(clozes.q(q),'comment')
        appendChild(docRootNode,createComment(docNode,clozes.q(q).comment));
    end

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
    if isfield(clozes.q(q),'generalfeedback')
        generalfeedback = createElement(docNode,'generalfeedback');
        setAttribute(generalfeedback,'format','html');
        generalfeedbacktext = createElement(docNode,'text');
        appendChild(generalfeedbacktext,createTextNode(docNode,clozes.q(q).feedback)); % Coloca feedback da pergunta
        appendChild(generalfeedback,generalfeedbacktext);
        appendChild(question,generalfeedback);
    end

    % Question penalty
    if isfield(clozes.q(q),'penalty')
        penalty = createElement(docNode,'penalty');
        appendChild(penalty,createTextNode(docNode,clozes.q(q).penalty));
        appendChild(question,penalty);
    end

    % Question hidden
    if isfield(clozes.q(q),'hidden')
        hidden = createElement(docNode,'hidden');
        appendChild(hidden,createTextNode(docNode,clozes.q(q).hidden));
        appendChild(question,hidden);
    end

    % Question idnumber
    if isfield(clozes.q(q),'idnumber')
        idnumber = createElement(docNode,'idnumber');
        appendChild(idnumber,createTextNode(docNode,clozes.q(q).idnumber));
        appendChild(question,idnumber);
    end

    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[clozes.xmlpath '\' clozes.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);

winopen(clozes.xmlpath)
