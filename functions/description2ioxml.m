% =========================================================================
% *** description2ioxml
% descriptions.xmlpath=pwd;
% descriptions.fname='qfilename';
%
% % Create question 1
% descriptions.q(1).name='Q01 name';
% descriptions.q(1).comment='comment for Q01';
% descriptions.q(1).text='Q01 description!';
% descriptions.q(1).generalfeedback='Q01 feedback';
% descriptions.q(1).penalty='0';
% descriptions.q(1).hidden='0';
% descriptions.q(1).idnumber='id0';
%
% description2ioxml(descriptions)
%
% =========================================================================

function XMLfile=description2ioxml(descriptions) % Generate xml file

XMLfile='';

if isfield(descriptions,'xmlpath')
    if ~exist(descriptions.xmlpath,'dir')
        mkdir(descriptions.xmlpath) % Sem verificação de erro
    end
else
    descriptions.xmlpath=pwd;
end

% Number os questions
if isfield(descriptions,'q')
    nq=length(descriptions.q);
else
    disp('No questions in cloze struct!')
    return
end

% Init all nom existing or empty fields
for q=1:nq
    % if ~isfield(clozes.q(q),'comment') || isempty(clozes.q(q).comment)
    %     clozes.q(q).comment='';
    % end
    if ~isfield(descriptions.q(q),'generalfeedback') || isempty(descriptions.q(q).generalfeedback)
        descriptions.q(q).generalfeedback='';
    end
    if ~isfield(descriptions.q(q),'defaultgrade') || isempty(descriptions.q(q).defaultgrade)
        descriptions.q(q).defaultgrade='0';
    end

    if ~isfield(descriptions.q(q),'penalty') || isempty(descriptions.q(q).penalty)
        descriptions.q(q).penalty='0';
    end
    if ~isfield(descriptions.q(q),'hidden') || isempty(descriptions.q(q).hidden)
        descriptions.q(q).hidden='0';
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
    if isfield(descriptions.q(q),'comment') & ~isempty(descriptions.q(q).comment)
        appendChild(docRootNode,createComment(docNode,descriptions.q(q).comment));
    end

    question = createElement(docNode,'question');
    setAttribute(question,'type','description');

    % Question name
    name = createElement(docNode,'name');
    nametext = createElement(docNode,'text');
    appendChild(nametext,createTextNode(docNode,descriptions.q(q).name)); % Coloca nome
    appendChild(name,nametext);
    appendChild(question,name);

    questiontext = createElement(docNode,'questiontext');
    setAttribute(questiontext,'format','html');
    questiontexttext = createElement(docNode,'text');
    % appendChild(questiontexttext,createTextNode(docNode,weekdays(i)));
    appendChild(questiontexttext,createCDATASection(docNode,descriptions.q(q).text));
    appendChild(questiontext,questiontexttext);
    appendChild(question,questiontext);

    % Question generalfeedback
    generalfeedback = createElement(docNode,'generalfeedback');
    setAttribute(generalfeedback,'format','html');
    generalfeedbacktext = createElement(docNode,'text');
    % if isfield(clozes.q(q),'generalfeedback')
    appendChild(generalfeedbacktext,createTextNode(docNode,descriptions.q(q).generalfeedback)); % Coloca feedback da pergunta
    % end
    appendChild(generalfeedback,generalfeedbacktext);
    appendChild(question,generalfeedback);

    % Question defaultgrade
    defaultgrade = createElement(docNode,'defaultgrade');
    appendChild(defaultgrade,createTextNode(docNode,descriptions.q(q).defaultgrade));
    appendChild(question,defaultgrade);

    % Question penalty
    penalty = createElement(docNode,'penalty');
    % if isfield(clozes.q(q),'penalty')
    appendChild(penalty,createTextNode(docNode,descriptions.q(q).penalty));
    % else
    %     appendChild(penalty,createTextNode(docNode,'0.3333333'));
    % end
    appendChild(question,penalty);

    % Question hidden
    hidden = createElement(docNode,'hidden');
    appendChild(hidden,createTextNode(docNode,descriptions.q(q).hidden));
    appendChild(question,hidden);

    % Question idnumber
    idnumber = createElement(docNode,'idnumber');
    if isfield(descriptions.q(q),'idnumber') & ~isempty(descriptions.q(q).idnumber)
        appendChild(idnumber,createTextNode(docNode,descriptions.q(q).idnumber));
    end
    appendChild(question,idnumber);

    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[descriptions.xmlpath '\' descriptions.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);
xml2html(XMLfile)

winopen(descriptions.xmlpath)


