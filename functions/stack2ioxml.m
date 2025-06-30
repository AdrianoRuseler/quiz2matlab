% =========================================================================
% *** stack2ioxml
% stacks.xmlpath=pwd;
% stacks.fname='qfilename';
% stacks.usetidy=0;
%
% % Create question 1
% stacks.q(1).name='Q01 name';
% stacks.q(1).comment='comment for Q01';
% stacks.q(1).text='Q01: {1:MULTICHOICE:California#Wrong~%100%Arizona#OK}';
% stacks.q(1).generalfeedback='Q01 feedback';
% stacks.q(1).penalty='0.25';
% stacks.q(1).hidden='0';
% stacks.q(1).idnumber='id0';
%
% stack2ioxml(stacks)
%
% =========================================================================

function XMLfile=stack2ioxml(stacks) % Generate xml file

XMLfile='';

if isfield(stacks,'xmlpath')
    if ~exist(stacks.xmlpath,'dir')
        mkdir(stacks.xmlpath) % Sem verificação de erro
    end
else
    stacks.xmlpath=pwd;
end

% Number os questions
if isfield(stacks,'q')
    nq=length(stacks.q);
else
    disp('No questions in cloze struct!')
    return
end

% Verify for usetidy
if isfield(stacks,'usetidy')
    % https://github.com/htacg/tidy-html5
    [status,tidyver] = system('tidy --version');
    if status
        disp(tidyver)
        disp('https://github.com/htacg/tidy-html5')
        stacks.usetidy=0;
    else
        stacks.usetidy=1;
    end
else
    stacks.usetidy=0;
end

% Init all nom existing or empty fields
for q=1:nq
    % if ~isfield(stacks.q(q),'comment') || isempty(stacks.q(q).comment)
    %     stacks.q(q).comment='';
    % end
    if ~isfield(stacks.q(q),'generalfeedback') || isempty(stacks.q(q).generalfeedback)
        stacks.q(q).generalfeedback='';
    end
    if ~isfield(stacks.q(q),'penalty') || isempty(stacks.q(q).penalty)
        stacks.q(q).penalty='0.3333333';
    end
    if ~isfield(stacks.q(q),'hidden') || isempty(stacks.q(q).hidden)
        stacks.q(q).hidden='0';
    end
    % if ~isfield(stacks.q(q),'idnumber') || isempty(stacks.q(q).idnumber)
    %     stacks.q(q).idnumber='';
    % end
    if stacks.usetidy
        stacks.q(q).text = formathtml(stacks.q(q).text);
    end

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
    if isfield(stacks.q(q),'comment') & ~isempty(stacks.q(q).comment)
        appendChild(docRootNode,createComment(docNode,stacks.q(q).comment));
    end

    question = createElement(docNode,'question');
    setAttribute(question,'type','stack');

    % Question name
    name = createElement(docNode,'name');
    nametext = createElement(docNode,'text');
    appendChild(nametext,createTextNode(docNode,stacks.q(q).name)); % Coloca nome
    appendChild(name,nametext);
    appendChild(question,name);

    questiontext = createElement(docNode,'questiontext');
    setAttribute(questiontext,'format','html');
    questiontexttext = createElement(docNode,'text');
    % appendChild(questiontexttext,createTextNode(docNode,weekdays(i)));
    appendChild(questiontexttext,createCDATASection(docNode,stacks.q(q).text));
    appendChild(questiontext,questiontexttext);
    appendChild(question,questiontext);

    % Question generalfeedback
    generalfeedback = createElement(docNode,'generalfeedback');
    setAttribute(generalfeedback,'format','html');
    generalfeedbacktext = createElement(docNode,'text');
    % if isfield(stacks.q(q),'generalfeedback')
    appendChild(generalfeedbacktext,createTextNode(docNode,stacks.q(q).generalfeedback)); % Coloca feedback da pergunta
    % end
    appendChild(generalfeedback,generalfeedbacktext);
    appendChild(question,generalfeedback);

    % Question penalty
    penalty = createElement(docNode,'penalty');
    % if isfield(stacks.q(q),'penalty')
    appendChild(penalty,createTextNode(docNode,stacks.q(q).penalty));
    % else
    %     appendChild(penalty,createTextNode(docNode,'0.3333333'));
    % end
    appendChild(question,penalty);

    % Question hidden
    hidden = createElement(docNode,'hidden');
    % if isfield(stacks.q(q),'hidden')
    appendChild(hidden,createTextNode(docNode,stacks.q(q).hidden));
    % else
    %     appendChild(hidden,createTextNode(docNode,'0'));
    % end
    appendChild(question,hidden);

    % Question idnumber
    idnumber = createElement(docNode,'idnumber');
    if isfield(stacks.q(q),'idnumber') & ~isempty(stacks.q(q).idnumber)
        appendChild(idnumber,createTextNode(docNode,stacks.q(q).idnumber));
    end
    appendChild(question,idnumber);

    stackversion = createElement(docNode,'stackversion');
    stackversiontext = createElement(docNode,'text');
    appendChild(stackversiontext,createTextNode(docNode,stacks.q(q).stackversion)); % Coloca stackversion
    appendChild(stackversion,stackversiontext);
    appendChild(question,stackversion);

    % questionvariables
    questionvariables = createElement(docNode,'questionvariables');
    questionvariablestext = createElement(docNode,'text');
    appendChild(questionvariablestext,createTextNode(docNode,stacks.q(q).questionvariables)); % Coloca stackversion
    appendChild(questionvariables,questionvariablestext);
    appendChild(question,questionvariables);


    specificfeedback = createElement(docNode,'specificfeedback');
    setAttribute(specificfeedback,'format','html');
    specificfeedbacktext = createElement(docNode,'text');
    % appendChild(questiontexttext,createTextNode(docNode,weekdays(i)));
    appendChild(specificfeedbacktext,createCDATASection(docNode,stacks.q(q).specificfeedback));
    appendChild(specificfeedback,specificfeedbacktext);
    appendChild(question,specificfeedback);



    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[stacks.xmlpath '\' stacks.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);
xml2html(XMLfile);

winopen(stacks.xmlpath)


