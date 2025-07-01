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

stacks=stackverify(stacks);


% Create the document node and root element, toc:
import matlab.io.xml.dom.*
docNode = Document('quiz');
docRootNode = getDocumentElement(docNode);

writer = matlab.io.xml.dom.DOMWriter;
writer.Configuration.FormatPrettyPrint = true;

dt = char(datetime('now','Format','yyyMMddHHmmss'));

nq=length(stacks.q);
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
    appendChild(generalfeedbacktext,createCDATASection(docNode,stacks.q(q).generalfeedback)); % Coloca feedback da pergunta
    % end
    appendChild(generalfeedback,generalfeedbacktext);
    appendChild(question,generalfeedback);

    % Question penalty
    penalty = createElement(docNode,'penalty');
    appendChild(penalty,createTextNode(docNode,stacks.q(q).penalty));
    appendChild(question,penalty);

    % Question hidden
    hidden = createElement(docNode,'hidden');
    appendChild(hidden,createTextNode(docNode,stacks.q(q).hidden));
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
    appendChild(specificfeedbacktext,createCDATASection(docNode,stacks.q(q).specificfeedback));
    appendChild(specificfeedback,specificfeedbacktext);
    appendChild(question,specificfeedback);


    questionnote = createElement(docNode,'questionnote');
    setAttribute(questionnote,'format','moodle_auto_format');
    questionnotetext = createElement(docNode,'text');
    appendChild(questionnotetext,createCDATASection(docNode,stacks.q(q).questionnote));
    appendChild(questionnote,questionnotetext);
    appendChild(question,questionnote);

    questiondescription = createElement(docNode,'questiondescription');
    setAttribute(questiondescription,'format','moodle_auto_format');
    questiondescriptiontext = createElement(docNode,'text');
    % appendChild(questiondescriptiontext,createCDATASection(docNode,stacks.q(q).questiondescription));
    appendChild(questiondescriptiontext,createTextNode(docNode,stacks.q(q).questiondescription));
    appendChild(questiondescription,questiondescriptiontext);
    appendChild(question,questiondescription);

    % <questionsimplify>0</questionsimplify>
    questionsimplify = createElement(docNode,'questionsimplify');
    appendChild(questionsimplify,createTextNode(docNode,stacks.q(q).questionsimplify));
    appendChild(question,questionsimplify);

    % <assumepositive>0</assumepositive>
    assumepositive = createElement(docNode,'assumepositive');
    appendChild(assumepositive,createTextNode(docNode,stacks.q(q).assumepositive));
    appendChild(question,assumepositive);

    % <assumereal>0</assumereal>
    assumereal = createElement(docNode,'assumereal');
    appendChild(assumereal,createTextNode(docNode,stacks.q(q).assumereal));
    appendChild(question,assumereal);


    prtcorrect = createElement(docNode,'prtcorrect');
    setAttribute(prtcorrect,'format','html');
    prtcorrecttext = createElement(docNode,'text');
    appendChild(prtcorrecttext,createCDATASection(docNode,stacks.q(q).prtcorrect));
    appendChild(prtcorrect,prtcorrecttext);
    appendChild(question,prtcorrect);

    prtpartiallycorrect = createElement(docNode,'prtpartiallycorrect');
    setAttribute(prtpartiallycorrect,'format','html');
    prtpartiallycorrecttext = createElement(docNode,'text');
    appendChild(prtpartiallycorrecttext,createCDATASection(docNode,stacks.q(q).prtpartiallycorrect));
    appendChild(prtpartiallycorrect,prtpartiallycorrecttext);
    appendChild(question,prtpartiallycorrect);

    prtincorrect = createElement(docNode,'prtincorrect');
    setAttribute(prtincorrect,'format','html');
    prtincorrecttext = createElement(docNode,'text');
    appendChild(prtincorrecttext,createCDATASection(docNode,stacks.q(q).prtincorrect));
    appendChild(prtincorrect,prtincorrecttext);
    appendChild(question,prtincorrect);

    % <decimals>.</decimals>
    decimals = createElement(docNode,'decimals');
    appendChild(decimals,createTextNode(docNode,stacks.q(q).decimals));
    appendChild(question,decimals);

    % <scientificnotation>*10</scientificnotation>
    scientificnotation = createElement(docNode,'scientificnotation');
    appendChild(scientificnotation,createTextNode(docNode,stacks.q(q).scientificnotation));
    appendChild(question,scientificnotation);

    % <multiplicationsign>dot</multiplicationsign>
    multiplicationsign = createElement(docNode,'multiplicationsign');
    appendChild(multiplicationsign,createTextNode(docNode,stacks.q(q).multiplicationsign));
    appendChild(question,multiplicationsign);

    % <sqrtsign>1</sqrtsign>
    sqrtsign = createElement(docNode,'sqrtsign');
    appendChild(sqrtsign,createTextNode(docNode,stacks.q(q).sqrtsign));
    appendChild(question,sqrtsign);

    % <complexno>i</complexno>
    complexno = createElement(docNode,'complexno');
    appendChild(complexno,createTextNode(docNode,stacks.q(q).complexno));
    appendChild(question,complexno);

    % <inversetrig>cos-1</inversetrig>
    inversetrig = createElement(docNode,'inversetrig');
    appendChild(inversetrig,createTextNode(docNode,stacks.q(q).inversetrig));
    appendChild(question,inversetrig);

    % <logicsymbol>lang</logicsymbol>
    logicsymbol = createElement(docNode,'logicsymbol');
    appendChild(logicsymbol,createTextNode(docNode,stacks.q(q).logicsymbol));
    appendChild(question,logicsymbol);

    % <matrixparens>[</matrixparens>
    matrixparens = createElement(docNode,'matrixparens');
    appendChild(matrixparens,createTextNode(docNode,stacks.q(q).matrixparens));
    appendChild(question,matrixparens);

    % <variantsselectionseed></variantsselectionseed>
    variantsselectionseed = createElement(docNode,'variantsselectionseed');
    appendChild(variantsselectionseed,createTextNode(docNode,stacks.q(q).variantsselectionseed));
    appendChild(question,variantsselectionseed);


    input = createElement(docNode,'input');
    inputname = createElement(docNode,'name');
    appendChild(inputname,createTextNode(docNode,stacks.q(q).input.name));
    appendChild(input,inputname);

    inputtype = createElement(docNode,'type');
    appendChild(inputtype,createTextNode(docNode,stacks.q(q).input.type));
    appendChild(input,inputtype);

    inputtans = createElement(docNode,'tans');
    appendChild(inputtans,createTextNode(docNode,stacks.q(q).input.tans));
    appendChild(input,inputtans);

    inputboxsize = createElement(docNode,'boxsize');
    appendChild(inputboxsize,createTextNode(docNode,stacks.q(q).input.boxsize));
    appendChild(input,inputboxsize);

    % <strictsyntax>1</strictsyntax>
    inputstrictsyntax = createElement(docNode,'strictsyntax');
    appendChild(inputstrictsyntax,createTextNode(docNode,stacks.q(q).input.strictsyntax));
    appendChild(input,inputstrictsyntax);

    % <insertstars>0</insertstars>
    inputinsertstars = createElement(docNode,'insertstars');
    appendChild(inputinsertstars,createTextNode(docNode,stacks.q(q).input.insertstars));
    appendChild(input,inputinsertstars);

    % <syntaxhint></syntaxhint>
    inputsyntaxhint = createElement(docNode,'syntaxhint');
    appendChild(inputsyntaxhint,createTextNode(docNode,stacks.q(q).input.syntaxhint));
    appendChild(input,inputsyntaxhint);

    % <syntaxattribute>0</syntaxattribute>
    inputsyntaxattribute = createElement(docNode,'syntaxattribute');
    appendChild(inputsyntaxattribute,createTextNode(docNode,stacks.q(q).input.syntaxattribute));
    appendChild(input,inputsyntaxattribute);

    % <forbidwords></forbidwords>
    inputforbidwords = createElement(docNode,'forbidwords');
    appendChild(inputforbidwords,createTextNode(docNode,stacks.q(q).input.forbidwords));
    appendChild(input,inputforbidwords);

    % <allowwords></allowwords>
    inputallowwords = createElement(docNode,'allowwords');
    appendChild(inputallowwords,createTextNode(docNode,stacks.q(q).input.allowwords));
    appendChild(input,inputallowwords);

    % <forbidfloat>1</forbidfloat>
    inputforbidfloat = createElement(docNode,'forbidfloat');
    appendChild(inputforbidfloat,createTextNode(docNode,stacks.q(q).input.forbidfloat));
    appendChild(input,inputforbidfloat);

    % <requirelowestterms>0</requirelowestterms>
    inputrequirelowestterms = createElement(docNode,'requirelowestterms');
    appendChild(inputrequirelowestterms,createTextNode(docNode,stacks.q(q).input.requirelowestterms));
    appendChild(input,inputrequirelowestterms);

    % <checkanswertype>1</checkanswertype>
    inputcheckanswertype = createElement(docNode,'checkanswertype');
    appendChild(inputcheckanswertype,createTextNode(docNode,stacks.q(q).input.checkanswertype));
    appendChild(input,inputcheckanswertype);

    % <mustverify>1</mustverify>
    inputmustverify = createElement(docNode,'mustverify');
    appendChild(inputmustverify,createTextNode(docNode,stacks.q(q).input.mustverify));
    appendChild(input,inputmustverify);

    % <showvalidation>1</showvalidation>
    inputshowvalidation = createElement(docNode,'showvalidation');
    appendChild(inputshowvalidation,createTextNode(docNode,stacks.q(q).input.showvalidation));
    appendChild(input,inputshowvalidation);

    % <options></options>
    inputoptions = createElement(docNode,'options');
    appendChild(inputoptions,createTextNode(docNode,stacks.q(q).input.options));
    appendChild(input,inputoptions);

    appendChild(question,input);


    prt = createElement(docNode,'prt');
    prtname = createElement(docNode,'name');
    appendChild(prtname,createTextNode(docNode,stacks.q(q).prt.name));
    appendChild(prt,prtname);

    % <value>1.0000000</value>
    prtvalue = createElement(docNode,'value');
    appendChild(prtvalue,createTextNode(docNode,stacks.q(q).prt.value));
    appendChild(prt,prtvalue);

    % <autosimplify>0</autosimplify>
    prtautosimplify = createElement(docNode,'autosimplify');
    appendChild(prtautosimplify,createTextNode(docNode,stacks.q(q).prt.autosimplify));
    appendChild(prt,prtautosimplify);
    % <feedbackstyle>1</feedbackstyle>
    prtfeedbackstyle = createElement(docNode,'feedbackstyle');
    appendChild(prtfeedbackstyle,createTextNode(docNode,stacks.q(q).prt.feedbackstyle));
    appendChild(prt,prtfeedbackstyle);
    % <feedbackvariables>
    %   <text></text>
    % </feedbackvariables>
    prtfeedbackvariables = createElement(docNode,'feedbackvariables');
    prtfeedbackvariablestext = createElement(docNode,'text');
    appendChild(prtfeedbackvariablestext,createTextNode(docNode,stacks.q(q).prt.feedbackvariables));
    appendChild(prtfeedbackvariables,prtfeedbackvariablestext);
    appendChild(prt,prtfeedbackvariables);

    nqnodes=length(stacks.q(q).prt.node);
    for no=1:nqnodes
        nodeElement = createElement(docNode,'node');
        nodeElementname = createElement(docNode,'name');
        appendChild(nodeElementname,createTextNode(docNode,stacks.q(q).prt.node(no).name));
        appendChild(nodeElement,nodeElementname);

        nodeElementdescription = createElement(docNode,'description');
        appendChild(nodeElementdescription,createTextNode(docNode,stacks.q(q).prt.node(no).description));
        appendChild(nodeElement,nodeElementdescription);

        nodeElementanswertest = createElement(docNode,'answertest');
        appendChild(nodeElementanswertest,createTextNode(docNode,stacks.q(q).prt.node(no).answertest));
        appendChild(nodeElement,nodeElementanswertest);

        nodeElementsans = createElement(docNode,'sans');
        appendChild(nodeElementsans,createTextNode(docNode,stacks.q(q).prt.node(no).sans));
        appendChild(nodeElement,nodeElementsans);

        nodeElementtans = createElement(docNode,'tans');
        appendChild(nodeElementtans,createTextNode(docNode,stacks.q(q).prt.node(no).tans));
        appendChild(nodeElement,nodeElementtans);

        nodeElementtestoptions = createElement(docNode,'testoptions');
        appendChild(nodeElementtestoptions,createTextNode(docNode,stacks.q(q).prt.node(no).testoptions));
        appendChild(nodeElement,nodeElementtestoptions);

        nodeElementquiet = createElement(docNode,'quiet');
        appendChild(nodeElementquiet,createTextNode(docNode,stacks.q(q).prt.node(no).quiet));
        appendChild(nodeElement,nodeElementquiet);

        nodeElementtruescoremode = createElement(docNode,'truescoremode');
        appendChild(nodeElementtruescoremode,createTextNode(docNode,stacks.q(q).prt.node(no).truescoremode));
        appendChild(nodeElement,nodeElementtruescoremode);

        nodeElementtruescore = createElement(docNode,'truescore');
        appendChild(nodeElementtruescore,createTextNode(docNode,stacks.q(q).prt.node(no).truescore));
        appendChild(nodeElement,nodeElementtruescore);

        nodeElementtruepenalty = createElement(docNode,'truepenalty');
        appendChild(nodeElementtruepenalty,createTextNode(docNode,stacks.q(q).prt.node(no).truepenalty));
        appendChild(nodeElement,nodeElementtruepenalty);

        nodeElementtruenextnode = createElement(docNode,'truenextnode');
        appendChild(nodeElementtruenextnode,createTextNode(docNode,stacks.q(q).prt.node(no).truenextnode));
        appendChild(nodeElement,nodeElementtruenextnode);

        nodeElementtruefeedback = createElement(docNode,'truefeedback');
        setAttribute(nodeElementtruefeedback,'format','html');
        nodeElementtruefeedbacktext = createElement(docNode,'text');
        appendChild(nodeElementtruefeedbacktext,createTextNode(docNode,stacks.q(q).prt.node(no).truefeedback));
        appendChild(nodeElementtruefeedback,nodeElementtruefeedbacktext);
        appendChild(nodeElement,nodeElementtruefeedback);


        nodeElementfalsescoremode = createElement(docNode,'falsescoremode');
        appendChild(nodeElementfalsescoremode,createTextNode(docNode,stacks.q(q).prt.node(no).falsescoremode));
        appendChild(nodeElement,nodeElementfalsescoremode);

        nodeElementfalsescore = createElement(docNode,'falsescore');
        appendChild(nodeElementfalsescore,createTextNode(docNode,stacks.q(q).prt.node(no).falsescore));
        appendChild(nodeElement,nodeElementfalsescore);

        nodeElementfalsepenalty = createElement(docNode,'falsepenalty');
        appendChild(nodeElementfalsepenalty,createTextNode(docNode,stacks.q(q).prt.node(no).falsepenalty));
        appendChild(nodeElement,nodeElementfalsepenalty);

        nodeElementfalsenextnode = createElement(docNode,'falsenextnode');
        appendChild(nodeElementfalsenextnode,createTextNode(docNode,stacks.q(q).prt.node(no).falsenextnode));
        appendChild(nodeElement,nodeElementfalsenextnode);

        nodeElementfalseanswernote = createElement(docNode,'falseanswernote');
        appendChild(nodeElementfalseanswernote,createTextNode(docNode,stacks.q(q).prt.node(no).falseanswernote));
        appendChild(nodeElement,nodeElementfalseanswernote);

        nodeElementfalsefeedback = createElement(docNode,'falsefeedback');
        setAttribute(nodeElementfalsefeedback,'format','html');
        nodeElementfalsefeedbacktext = createElement(docNode,'text');
        appendChild(nodeElementfalsefeedbacktext,createTextNode(docNode,stacks.q(q).prt.node(no).falsefeedback));
        appendChild(nodeElementfalsefeedback,nodeElementfalsefeedbacktext);
        appendChild(nodeElement,nodeElementfalsefeedback);

        appendChild(prt,nodeElement);
    end
    appendChild(question,prt);

    % stacks.q(1).deployedseed(1).value='1795421824';
    nseeds=length(stacks.q(q).deployedseed);
    for ns=1:nseeds
        deployedseedElement = createElement(docNode,'deployedseed');
        appendChild(deployedseedElement,createTextNode(docNode,stacks.q(q).deployedseed(ns).value));
        appendChild(question,deployedseedElement);
    end

    nts=length(stacks.q(q).qtest);
    for nt=1:nts
        qtestElement = createElement(docNode,'qtest');

        qtestElementtestcase = createElement(docNode,'testcase');
        appendChild(qtestElementtestcase,createTextNode(docNode,stacks.q(q).qtest(nt).testcase));
        appendChild(qtestElement,qtestElementtestcase);

        qtestElementdescription = createElement(docNode,'description');
        appendChild(qtestElementdescription,createTextNode(docNode,stacks.q(q).qtest(nt).description));
        appendChild(qtestElement,qtestElementdescription);

        % stacks.q(1).qtest(qt).testinput.name='ans';
        % stacks.q(1).qtest(qt).testinput.value='ta';
        qtestElementtestinput = createElement(docNode,'testinput');
        qtestElementtestinputtext = createElement(docNode,'text');
        appendChild(qtestElementtestinputtext,createTextNode(docNode,stacks.q(q).qtest(nt).testinput.name));
        qtestElementtestinputvalue = createElement(docNode,'value');
        appendChild(qtestElementtestinputvalue,createTextNode(docNode,stacks.q(q).qtest(nt).testinput.value));

        appendChild(qtestElementtestinput,qtestElementtestinputtext);
        appendChild(qtestElementtestinput,qtestElementtestinputvalue);
        appendChild(qtestElement,qtestElementtestinput);

        
        % stacks.q(1).qtest(qt).expected.name='prt1';
        % stacks.q(1).qtest(qt).expected.expectedscore='1.0000000';
        % stacks.q(1).qtest(qt).expected.expectedpenalty='0.0000000';
        % stacks.q(1).qtest(qt).expected.expectedanswernote='1-0-T';

        qtestElementexpected = createElement(docNode,'expected');
        qtestElementexpectedname = createElement(docNode,'name');
        qtestElementexpectedexpectedscore = createElement(docNode,'expectedscore');
        qtestElementexpectedexpectedpenalty = createElement(docNode,'expectedpenalty');
        qtestElementexpectedexpectedanswernote = createElement(docNode,'expectedanswernote');

        appendChild(qtestElementexpectedname,createTextNode(docNode,stacks.q(q).qtest(nt).expected.name));
        appendChild(qtestElementexpectedexpectedscore,createTextNode(docNode,stacks.q(q).qtest(nt).expected.expectedscore));
        appendChild(qtestElementexpectedexpectedpenalty,createTextNode(docNode,stacks.q(q).qtest(nt).expected.expectedpenalty));
        appendChild(qtestElementexpectedexpectedanswernote,createTextNode(docNode,stacks.q(q).qtest(nt).expected.expectedanswernote));

        appendChild(qtestElementexpected,qtestElementexpectedname);
        appendChild(qtestElementexpected,qtestElementexpectedexpectedscore);
        appendChild(qtestElementexpected,qtestElementexpectedexpectedpenalty);
        appendChild(qtestElementexpected,qtestElementexpectedexpectedanswernote);

        appendChild(qtestElement,qtestElementexpected);


        appendChild(question,qtestElement);
    end



    appendChild(docRootNode,question);
end

% XML file name
XMLfile=[stacks.xmlpath '\' stacks.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

writeToFile(writer,docNode,XMLfile);

% type(XMLfile);
% xml2html(XMLfile);

winopen(stacks.xmlpath)


