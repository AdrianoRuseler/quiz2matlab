% =========================================================================
% *** cloze2ioxml
% clozes.xmlpath=pwd;
% clozes.fname='qfilename';
%
% % Create question 1
% clozes.q(1).name='Q01 name';
% clozes.q(1).comment='comment for Q01';
% clozes.q(1).text='Q01: {1:MULTICHOICE:California#Wrong~%100%Arizona#OK}';
% clozes.q(1).generalfeedback='Q01 feedback';
% clozes.q(1).penalty='0.25';
% clozes.q(1).hidden='0';
% clozes.q(1).idnumber='id0';
%
% cloze2ioxml(clozes)
%
% =========================================================================

function XMLfile=cloze2ioxml(clozes) % Generate xml file

XMLfile='';

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

% Init all nom existing or empty fields
for q=1:nq
    % if ~isfield(clozes.q(q),'comment') || isempty(clozes.q(q).comment)
    %     clozes.q(q).comment='';
    % end
    if ~isfield(clozes.q(q),'generalfeedback') || isempty(clozes.q(q).generalfeedback)
        clozes.q(q).generalfeedback='';
    end
    if ~isfield(clozes.q(q),'penalty') || isempty(clozes.q(q).penalty)
        clozes.q(q).penalty='0.3333333';
    end
    if ~isfield(clozes.q(q),'hidden') || isempty(clozes.q(q).hidden)
        clozes.q(q).hidden='0';
    end
    % if ~isfield(clozes.q(q),'idnumber') || isempty(clozes.q(q).idnumber)
    %     clozes.q(q).idnumber='';
    % end
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
    if isfield(clozes.q(q),'comment') & ~isempty(clozes.q(q).comment)
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
    generalfeedback = createElement(docNode,'generalfeedback');
    setAttribute(generalfeedback,'format','html');
    generalfeedbacktext = createElement(docNode,'text');
    % if isfield(clozes.q(q),'generalfeedback')
        appendChild(generalfeedbacktext,createTextNode(docNode,clozes.q(q).generalfeedback)); % Coloca feedback da pergunta
    % end
    appendChild(generalfeedback,generalfeedbacktext);
    appendChild(question,generalfeedback);

    % Question penalty
    penalty = createElement(docNode,'penalty');
    % if isfield(clozes.q(q),'penalty')
        appendChild(penalty,createTextNode(docNode,clozes.q(q).penalty));
    % else
    %     appendChild(penalty,createTextNode(docNode,'0.3333333'));
    % end
    appendChild(question,penalty);

    % Question hidden
    hidden = createElement(docNode,'hidden');
    % if isfield(clozes.q(q),'hidden')
        appendChild(hidden,createTextNode(docNode,clozes.q(q).hidden));
    % else
    %     appendChild(hidden,createTextNode(docNode,'0'));
    % end
    appendChild(question,hidden);

    % Question idnumber
    idnumber = createElement(docNode,'idnumber');
    if isfield(clozes.q(q),'idnumber') & ~isempty(clozes.q(q).idnumber)
        appendChild(idnumber,createTextNode(docNode,clozes.q(q).idnumber));
    end
    appendChild(question,idnumber);

    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[clozes.xmlpath '\' clozes.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);
xml2html(XMLfile)

winopen(clozes.xmlpath)


