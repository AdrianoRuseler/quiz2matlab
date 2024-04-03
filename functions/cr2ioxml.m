% =========================================================================
% *** cr2ioxml
% crs.xmlpath=pwd;
% crs.fname='qfilename';
%
% % Create question 1
% crs.q(1).name='Q01 name';
% crs.q(1).coderunnertype='c_function';
% crs.q(1).comment='comment for Q01';
% crs.q(1).text='Exemplo de texto!';
% crs.q(1).generalfeedback='Q01 feedback';
% crs.q(1).penalty='0.25';
% crs.q(1).hidden='0';
% crs.q(1).idnumber='id0';
%
% cr2ioxml(crs)
%
% =========================================================================

function XMLfile=cr2ioxml(crs) % Generate xml file

XMLfile='';

if isfield(crs,'xmlpath')
    if ~exist(crs.xmlpath,'dir')
        mkdir(crs.xmlpath) % Sem verificação de erro
    end
else
    crs.xmlpath=pwd;
end

% Number os questions
if isfield(crs,'q')
    nq=length(crs.q);
else
    disp('No questions in cloze struct!')
    return
end

% Init all nom existing or empty fields
for q=1:nq
    if ~isfield(crs.q(q),'generalfeedback') || isempty(crs.q(q).generalfeedback)
        crs.q(q).generalfeedback='';
    end
    if ~isfield(crs.q(q),'penalty') || isempty(crs.q(q).penalty)
        crs.q(q).penalty='0.25';
    end
    if ~isfield(crs.q(q),'hidden') || isempty(crs.q(q).hidden)
        crs.q(q).hidden='0';
    end
    if ~isfield(crs.q(q),'coderunnertype') || isempty(crs.q(q).coderunnertype)
        crs.q(q).coderunnertype='c_function';
    end
    if ~isfield(crs.q(q),'defaultgrade') || isempty(crs.q(q).defaultgrade)
        crs.q(q).defaultgrade='1';
    end
    if ~isfield(crs.q(q),'prototypetype') || isempty(crs.q(q).prototypetype)
        crs.q(q).prototypetype='0';
    end
    if ~isfield(crs.q(q),'allornothing') || isempty(crs.q(q).allornothing)
        crs.q(q).allornothing='1';
    end
    if ~isfield(crs.q(q),'penaltyregime') || isempty(crs.q(q).penaltyregime)
        crs.q(q).penaltyregime='10, 20, ...';
    end
    if ~isfield(crs.q(q),'precheck') || isempty(crs.q(q).precheck)
        crs.q(q).precheck='0';
    end
    if ~isfield(crs.q(q),'hidecheck') || isempty(crs.q(q).hidecheck)
        crs.q(q).hidecheck='0';
    end
    if ~isfield(crs.q(q),'showsource') || isempty(crs.q(q).showsource)
        crs.q(q).showsource='0';
    end
    if ~isfield(crs.q(q),'answerboxlines') || isempty(crs.q(q).answerboxlines)
        crs.q(q).answerboxlines='18';
    end
    if ~isfield(crs.q(q),'answerboxcolumns') || isempty(crs.q(q).answerboxcolumns)
        crs.q(q).answerboxcolumns='100';
    end
    if ~isfield(crs.q(q),'answerpreload') || isempty(crs.q(q).answerpreload)
        crs.q(q).answerpreload='';
    end

    if ~isfield(crs.q(q),'globalextra') || isempty(crs.q(q).globalextra)
        crs.q(q).globalextra='';
    end
    if ~isfield(crs.q(q),'useace') || isempty(crs.q(q).useace)
        crs.q(q).useace='';
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
    if isfield(crs.q(q),'comment') & ~isempty(crs.q(q).comment)
        appendChild(docRootNode,createComment(docNode,crs.q(q).comment));
    end

    question = createElement(docNode,'question');
    setAttribute(question,'type','coderunner');

    % Question name
    name = createElement(docNode,'name');
    nametext = createElement(docNode,'text');
    appendChild(nametext,createTextNode(docNode,crs.q(q).name)); % Coloca nome
    appendChild(name,nametext);
    appendChild(question,name);

    questiontext = createElement(docNode,'questiontext');
    setAttribute(questiontext,'format','html');
    questiontexttext = createElement(docNode,'text');
    % appendChild(questiontexttext,createTextNode(docNode,weekdays(i)));
    appendChild(questiontexttext,createCDATASection(docNode,crs.q(q).text));
    appendChild(questiontext,questiontexttext);
    appendChild(question,questiontext);

    % Question generalfeedback
    generalfeedback = createElement(docNode,'generalfeedback');
    setAttribute(generalfeedback,'format','html');
    generalfeedbacktext = createElement(docNode,'text');
    appendChild(generalfeedbacktext,createTextNode(docNode,crs.q(q).generalfeedback)); % Coloca feedback da pergunta
    appendChild(generalfeedback,generalfeedbacktext);
    appendChild(question,generalfeedback);

    % Question defaultgrade
    defaultgrade = createElement(docNode,'defaultgrade');
    appendChild(defaultgrade,createTextNode(docNode,crs.q(q).defaultgrade));
    appendChild(question,defaultgrade);

    % Question penalty
    penalty = createElement(docNode,'penalty');
    appendChild(penalty,createTextNode(docNode,crs.q(q).penalty));
    appendChild(question,penalty);

    % Question hidden
    hidden = createElement(docNode,'hidden');
    appendChild(hidden,createTextNode(docNode,crs.q(q).hidden));
    appendChild(question,hidden);

    % Question idnumber
    idnumber = createElement(docNode,'idnumber');
    if isfield(crs.q(q),'idnumber') & ~isempty(crs.q(q).idnumber)
        appendChild(idnumber,createTextNode(docNode,crs.q(q).idnumber));
    end
    appendChild(question,idnumber);

    % Question coderunnertype
    coderunnertype = createElement(docNode,'coderunnertype');
    appendChild(coderunnertype,createTextNode(docNode,crs.q(q).coderunnertype));
    appendChild(question,coderunnertype);

    % Question prototypetype
    prototypetype = createElement(docNode,'prototypetype');
    appendChild(prototypetype,createTextNode(docNode,crs.q(q).prototypetype));
    appendChild(question,prototypetype);

    % Question allornothing
    allornothing = createElement(docNode,'allornothing');
    appendChild(allornothing,createTextNode(docNode,crs.q(q).allornothing));
    appendChild(question,allornothing);

    % Question penaltyregime
    penaltyregime = createElement(docNode,'penaltyregime');
    appendChild(penaltyregime,createTextNode(docNode,crs.q(q).penaltyregime));
    appendChild(question,penaltyregime);

    % Question precheck
    precheck = createElement(docNode,'precheck');
    appendChild(precheck,createTextNode(docNode,crs.q(q).precheck));
    appendChild(question,precheck);

    % Question hidecheck
    hidecheck = createElement(docNode,'hidecheck');
    appendChild(hidecheck,createTextNode(docNode,crs.q(q).hidecheck));
    appendChild(question,hidecheck);

    % Question showsource
    showsource = createElement(docNode,'showsource');
    appendChild(showsource,createTextNode(docNode,crs.q(q).showsource));
    appendChild(question,showsource);

    % Question showsource
    answerboxlines = createElement(docNode,'answerboxlines');
    appendChild(answerboxlines,createTextNode(docNode,crs.q(q).answerboxlines));
    appendChild(question,answerboxlines);

    % Question answerboxcolumns
    answerboxcolumns = createElement(docNode,'answerboxcolumns');
    appendChild(answerboxcolumns,createTextNode(docNode,crs.q(q).answerboxcolumns));
    appendChild(question,answerboxcolumns);

    % Question answerpreload
    answerpreload = createElement(docNode,'answerpreload');
    appendChild(answerpreload,createTextNode(docNode,crs.q(q).answerpreload));
    appendChild(question,answerpreload);


    % Question globalextra
    globalextra = createElement(docNode,'globalextra');
    appendChild(globalextra,createTextNode(docNode,crs.q(q).globalextra));
    appendChild(question,globalextra);


    % Question useace
    useace = createElement(docNode,'useace');
    appendChild(useace,createTextNode(docNode,crs.q(q).useace));
    appendChild(question,useace);


    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[crs.xmlpath '\' crs.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);
% xml2html(XMLfile)

winopen(crs.xmlpath)


