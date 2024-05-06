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
        crs.q(q).answerboxlines='5';
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
    if ~isfield(crs.q(q),'resultcolumns') || isempty(crs.q(q).resultcolumns)
        crs.q(q).resultcolumns='';
    end
    if ~isfield(crs.q(q),'template') || isempty(crs.q(q).template)
        crs.q(q).template='';
    end
    if ~isfield(crs.q(q),'iscombinatortemplate') || isempty(crs.q(q).iscombinatortemplate)
        crs.q(q).iscombinatortemplate='';
    end
    if ~isfield(crs.q(q),'allowmultiplestdins') || isempty(crs.q(q).allowmultiplestdins)
        crs.q(q).allowmultiplestdins='';
    end
    if ~isfield(crs.q(q),'validateonsave') || isempty(crs.q(q).validateonsave)
        crs.q(q).validateonsave='1';
    end
    if ~isfield(crs.q(q),'testsplitterre') || isempty(crs.q(q).testsplitterre)
        crs.q(q).testsplitterre='';
    end
    if ~isfield(crs.q(q),'language') || isempty(crs.q(q).language)
        crs.q(q).language='';
    end
    if ~isfield(crs.q(q),'acelang') || isempty(crs.q(q).acelang)
        crs.q(q).acelang='';
    end
    if ~isfield(crs.q(q),'sandbox') || isempty(crs.q(q).sandbox)
        crs.q(q).sandbox='';
    end
    if ~isfield(crs.q(q),'grader') || isempty(crs.q(q).grader)
        crs.q(q).grader='';
    end
    if ~isfield(crs.q(q),'cputimelimitsecs') || isempty(crs.q(q).cputimelimitsecs)
        crs.q(q).cputimelimitsecs='';
    end
    if ~isfield(crs.q(q),'memlimitmb') || isempty(crs.q(q).memlimitmb)
        crs.q(q).memlimitmb='';
    end
    if ~isfield(crs.q(q),'sandboxparams') || isempty(crs.q(q).sandboxparams)
        crs.q(q).sandboxparams='';
    end
    if ~isfield(crs.q(q),'templateparams') || isempty(crs.q(q).templateparams)
        crs.q(q).templateparams='';
    end
    if ~isfield(crs.q(q),'hoisttemplateparams') || isempty(crs.q(q).hoisttemplateparams)
        crs.q(q).hoisttemplateparams='1';
    end
    if ~isfield(crs.q(q),'extractcodefromjson') || isempty(crs.q(q).extractcodefromjson)
        crs.q(q).extractcodefromjson='1';
    end
    if ~isfield(crs.q(q),'templateparamslang') || isempty(crs.q(q).templateparamslang)
        crs.q(q).templateparamslang='None';
    end
    if ~isfield(crs.q(q),'templateparamsevalpertry') || isempty(crs.q(q).templateparamsevalpertry)
        crs.q(q).templateparamsevalpertry='0';
    end
    if ~isfield(crs.q(q),'templateparamsevald') || isempty(crs.q(q).templateparamsevald)
        crs.q(q).templateparamsevald='{}';
    end
    if ~isfield(crs.q(q),'twigall') || isempty(crs.q(q).twigall)
        crs.q(q).twigall='0';
    end
    if ~isfield(crs.q(q),'uiplugin') || isempty(crs.q(q).uiplugin)
        crs.q(q).uiplugin='';
    end
    if ~isfield(crs.q(q),'uiparameters') || isempty(crs.q(q).uiparameters)
        crs.q(q).uiparameters='';
    end
    if ~isfield(crs.q(q),'attachments') || isempty(crs.q(q).attachments)
        crs.q(q).attachments='0';
    end
    if ~isfield(crs.q(q),'attachmentsrequired') || isempty(crs.q(q).attachmentsrequired)
        crs.q(q).attachmentsrequired='0';
    end
    if ~isfield(crs.q(q),'maxfilesize') || isempty(crs.q(q).maxfilesize)
        crs.q(q).maxfilesize='10240';
    end
    if ~isfield(crs.q(q),'filenamesregex') || isempty(crs.q(q).filenamesregex)
        crs.q(q).filenamesregex='';
    end
    if ~isfield(crs.q(q),'filenamesexplain') || isempty(crs.q(q).filenamesexplain)
        crs.q(q).filenamesexplain='';
    end
    if ~isfield(crs.q(q),'displayfeedback') || isempty(crs.q(q).displayfeedback)
        crs.q(q).displayfeedback='';
    end
    if ~isfield(crs.q(q),'giveupallowed') || isempty(crs.q(q).giveupallowed)
        crs.q(q).giveupallowed='';
    end
    if ~isfield(crs.q(q),'prototypeextra') || isempty(crs.q(q).prototypeextra)
        crs.q(q).prototypeextra='';
    end

    % LOOP for cases test
    for tc=1:length(crs.q(q).testcases)

        if ~isfield(crs.q(q).testcases(tc),'stdin') || isempty(crs.q(q).testcases(tc).stdin)
            crs.q(q).testcases(tc).stdin='';
        end

        if ~isfield(crs.q(q).testcases(tc),'extra') || isempty(crs.q(q).testcases(tc).extra)
            crs.q(q).testcases(tc).extra='';
        end

        if ~isfield(crs.q(q).testcases(tc),'display') || isempty(crs.q(q).testcases(tc).display)
            crs.q(q).testcases(tc).display='SHOW';
        end

    end
end % Question Loop



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
    appendChild(answerpreload,createCDATASection(docNode,crs.q(q).answerpreload));
    appendChild(question,answerpreload);

    % Question globalextra
    globalextra = createElement(docNode,'globalextra');
    appendChild(globalextra,createTextNode(docNode,crs.q(q).globalextra));
    appendChild(question,globalextra);

    % Question useace
    useace = createElement(docNode,'useace');
    appendChild(useace,createTextNode(docNode,crs.q(q).useace));
    appendChild(question,useace);

    % Question resultcolumns
    resultcolumns = createElement(docNode,'resultcolumns');
    appendChild(resultcolumns,createTextNode(docNode,crs.q(q).resultcolumns));
    appendChild(question,resultcolumns);

    % Question template
    template = createElement(docNode,'template');
    if isempty(crs.q(q).template)
        appendChild(template,createTextNode(docNode,crs.q(q).template));
    else
        appendChild(template,createCDATASection(docNode,crs.q(q).template));
    end
    appendChild(question,template);

    % Question iscombinatortemplate
    iscombinatortemplate = createElement(docNode,'iscombinatortemplate');
    appendChild(iscombinatortemplate,createTextNode(docNode,crs.q(q).iscombinatortemplate));
    appendChild(question,iscombinatortemplate);

    % Question allowmultiplestdins
    allowmultiplestdins = createElement(docNode,'allowmultiplestdins');
    appendChild(allowmultiplestdins,createTextNode(docNode,crs.q(q).allowmultiplestdins));
    appendChild(question,allowmultiplestdins);

    % Question answer
    answer = createElement(docNode,'answer');
    appendChild(answer,createTextNode(docNode,crs.q(q).answer));
    appendChild(question,answer);

    % Question validateonsave
    validateonsave = createElement(docNode,'validateonsave');
    appendChild(validateonsave,createTextNode(docNode,crs.q(q).validateonsave));
    appendChild(question,validateonsave);

    % Question testsplitterre
    testsplitterre = createElement(docNode,'testsplitterre');
    appendChild(testsplitterre,createTextNode(docNode,crs.q(q).testsplitterre));
    appendChild(question,testsplitterre);

    % Question language
    language = createElement(docNode,'language');
    appendChild(language,createTextNode(docNode,crs.q(q).language));
    appendChild(question,language);

    % Question acelang
    acelang = createElement(docNode,'acelang');
    appendChild(acelang,createTextNode(docNode,crs.q(q).acelang));
    appendChild(question,acelang);

    % Question sandbox
    sandbox = createElement(docNode,'sandbox');
    appendChild(sandbox,createTextNode(docNode,crs.q(q).sandbox));
    appendChild(question,sandbox);

    % Question grader
    grader = createElement(docNode,'grader');
    appendChild(grader,createTextNode(docNode,crs.q(q).grader));
    appendChild(question,grader);

    % Question cputimelimitsecs
    cputimelimitsecs = createElement(docNode,'cputimelimitsecs');
    appendChild(cputimelimitsecs,createTextNode(docNode,crs.q(q).cputimelimitsecs));
    appendChild(question,cputimelimitsecs);

    % Question memlimitmb
    memlimitmb = createElement(docNode,'memlimitmb');
    appendChild(memlimitmb,createTextNode(docNode,crs.q(q).memlimitmb));
    appendChild(question,memlimitmb);

    % Question sandboxparams
    sandboxparams = createElement(docNode,'sandboxparams');
    appendChild(sandboxparams,createTextNode(docNode,crs.q(q).sandboxparams));
    appendChild(question,sandboxparams);

    % Question templateparams
    templateparams = createElement(docNode,'templateparams');
    appendChild(templateparams,createTextNode(docNode,crs.q(q).templateparams));
    appendChild(question,templateparams);

    % Question hoisttemplateparams
    hoisttemplateparams = createElement(docNode,'hoisttemplateparams');
    appendChild(hoisttemplateparams,createTextNode(docNode,crs.q(q).hoisttemplateparams));
    appendChild(question,hoisttemplateparams);

    % Question extractcodefromjson
    extractcodefromjson = createElement(docNode,'extractcodefromjson');
    appendChild(extractcodefromjson,createTextNode(docNode,crs.q(q).extractcodefromjson));
    appendChild(question,extractcodefromjson);

    % Question templateparamslang
    templateparamslang = createElement(docNode,'templateparamslang');
    appendChild(templateparamslang,createTextNode(docNode,crs.q(q).templateparamslang));
    appendChild(question,templateparamslang);

    % Question templateparamsevalpertry
    templateparamsevalpertry = createElement(docNode,'templateparamsevalpertry');
    appendChild(templateparamsevalpertry,createTextNode(docNode,crs.q(q).templateparamsevalpertry));
    appendChild(question,templateparamsevalpertry);

    % Question templateparamsevald
    templateparamsevald = createElement(docNode,'templateparamsevald');
    appendChild(templateparamsevald,createTextNode(docNode,crs.q(q).templateparamsevald));
    appendChild(question,templateparamsevald);

    % Question twigall
    twigall = createElement(docNode,'twigall');
    appendChild(twigall,createTextNode(docNode,crs.q(q).twigall));
    appendChild(question,twigall);

    % Question uiplugin
    uiplugin = createElement(docNode,'uiplugin');
    appendChild(uiplugin,createTextNode(docNode,crs.q(q).uiplugin));
    appendChild(question,uiplugin);

    % Question uiparameters
    uiparameters = createElement(docNode,'uiparameters');
    appendChild(uiparameters,createTextNode(docNode,crs.q(q).uiparameters));
    appendChild(question,uiparameters);

    % Question attachments
    attachments = createElement(docNode,'attachments');
    appendChild(attachments,createTextNode(docNode,crs.q(q).attachments));
    appendChild(question,attachments);

    % Question attachmentsrequired
    attachmentsrequired = createElement(docNode,'attachmentsrequired');
    appendChild(attachmentsrequired,createTextNode(docNode,crs.q(q).attachmentsrequired));
    appendChild(question,attachmentsrequired);

    % Question maxfilesize
    maxfilesize = createElement(docNode,'maxfilesize');
    appendChild(maxfilesize,createTextNode(docNode,crs.q(q).maxfilesize));
    appendChild(question,maxfilesize);

    % Question filenamesregex
    filenamesregex = createElement(docNode,'filenamesregex');
    appendChild(filenamesregex,createTextNode(docNode,crs.q(q).filenamesregex));
    appendChild(question,filenamesregex);

    % Question filenamesexplain
    filenamesexplain = createElement(docNode,'filenamesexplain');
    appendChild(filenamesexplain,createTextNode(docNode,crs.q(q).filenamesexplain));
    appendChild(question,filenamesexplain);

    % Question displayfeedback
    displayfeedback = createElement(docNode,'displayfeedback');
    appendChild(displayfeedback,createTextNode(docNode,crs.q(q).displayfeedback));
    appendChild(question,displayfeedback);

    % Question giveupallowed
    giveupallowed = createElement(docNode,'giveupallowed');
    appendChild(giveupallowed,createTextNode(docNode,crs.q(q).giveupallowed));
    appendChild(question,giveupallowed);

    % Question prototypeextra
    prototypeextra = createElement(docNode,'prototypeextra');
    appendChild(prototypeextra,createTextNode(docNode,crs.q(q).prototypeextra));
    appendChild(question,prototypeextra);

    % <testcases>
    %   <testcase testtype="0" useasexample="0" hiderestiffail="0" mark="1.0000000" >
    testcases = createElement(docNode,'testcases');

    % LOOP for cases test
    for tc=1:length(crs.q(q).testcases)
        testcasestestcase = createElement(docNode,'testcase');
        %   <testcase testtype="0" useasexample="0" hiderestiffail="0" mark="1.0000000" >
        setAttribute(testcasestestcase,'testtype','0');
        setAttribute(testcasestestcase,'useasexample','0');
        setAttribute(testcasestestcase,'hiderestiffail','0');
        setAttribute(testcasestestcase,'mark','1.0000000');

        testcasestestcode = createElement(docNode,'testcode');
        testcasestestcodetext = createElement(docNode,'text');
        if isempty(crs.q(q).testcases(tc).testcode)
            appendChild(testcasestestcodetext,createTextNode(docNode,crs.q(q).testcases(tc).testcode));
        else
            appendChild(testcasestestcodetext,createCDATASection(docNode,crs.q(q).testcases(tc).testcode));
        end

        appendChild(testcasestestcode,testcasestestcodetext);
        appendChild(testcasestestcase,testcasestestcode);

        testcasesstdin = createElement(docNode,'stdin');
        testcasesstdintext = createElement(docNode,'text');
        appendChild(testcasesstdintext,createTextNode(docNode,crs.q(q).testcases(tc).stdin));
        appendChild(testcasesstdin,testcasesstdintext);
        appendChild(testcasestestcase,testcasesstdin);

        testcasesexpected = createElement(docNode,'expected');
        testcasesexpectedtext = createElement(docNode,'text');
        appendChild(testcasesexpectedtext,createTextNode(docNode,crs.q(q).testcases(tc).expected));
        appendChild(testcasesexpected,testcasesexpectedtext);
        appendChild(testcasestestcase,testcasesexpected);

        testcasesextra = createElement(docNode,'extra');
        testcasesextratext = createElement(docNode,'text');
        appendChild(testcasesextratext,createTextNode(docNode,crs.q(q).testcases(tc).extra));
        appendChild(testcasesextra,testcasesextratext);
        appendChild(testcasestestcase,testcasesextra);

        testcasesdisplay = createElement(docNode,'display');
        testcasesdisplaytext = createElement(docNode,'text');
        appendChild(testcasesdisplaytext,createTextNode(docNode,crs.q(q).testcases(tc).display));
        appendChild(testcasesdisplay,testcasesdisplaytext);
        appendChild(testcasestestcase,testcasesdisplay);

        appendChild(testcases,testcasestestcase);

    end
    appendChild(question,testcases);

    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[crs.xmlpath '\' crs.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);
% xml2html(XMLfile)

winopen(crs.xmlpath)


