% =========================================================================
% *** cloze2xml

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
% cloze2xml(clozes) % Generate xml file

% =========================================================================

function cloze2xml(clozes) % Generate xml file


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
docNode = com.mathworks.xml.XMLUtils.createDocument('quiz');
% Identify the root element, and set the version attribute:
quiz = docNode.getDocumentElement;
% toc.setAttribute('version','2.0');

for q=1:nq
    question = docNode.createElement('question');
    question.setAttribute('type','cloze');
    quiz.appendChild(question);

    % Add the comment: clozes.q(q).name
    question.appendChild(docNode.createComment(clozes.q(q).comment));

    % Question name
    name = docNode.createElement('name');
    nametext = docNode.createElement('text');
    question.appendChild(name);
    name.appendChild(nametext);
    nametext.appendChild(docNode.createTextNode(clozes.q(q).name)); % Coloca nome


    % Question  text
    questiontext = docNode.createElement('questiontext');
    questiontext.setAttribute('format','html');
    questiontexttext = docNode.createElement('text');
    question.appendChild(questiontext);
    questiontext.appendChild(questiontexttext);
    % questiontexttext.appendChild(docNode.createTextNode(clozes.q(q).text)); % Coloca pergunta
    % questiontexttext.appendChild(docNode.createTextNode(clozes.q(q).text)); % Coloca pergunta

    questiontexttext.appendChild(docNode.createCDATASection(['<![CDATA[', clozes.q(q).text ,']]>']));

    % Question generalfeedback
    generalfeedback = docNode.createElement('generalfeedback');
    generalfeedback.setAttribute('format','html');
    generalfeedbacktext = docNode.createElement('text');
    question.appendChild(generalfeedback);
    generalfeedback.appendChild(generalfeedbacktext);
    generalfeedbacktext.appendChild(docNode.createTextNode(clozes.q(q).feedback)); % Coloca feedback da pergunta


    penalty = docNode.createElement('penalty');
    penalty.appendChild(docNode.createTextNode(clozes.q(q).penalty));
    question.appendChild(penalty);

    hidden = docNode.createElement('hidden');
    hidden.appendChild(docNode.createTextNode(clozes.q(q).hidden));
    question.appendChild(hidden);

end

dt = char(datetime('now','Format','yyyMMddHHmmss'));

% dt = datestr(now,'yyyymmddTHHMMSS');
XMLfile=[clozes.xmlpath '\' clozes.fname 'D' dt 'NQ' num2str(nq,'%03i') '.xml'];

xmlwrite(XMLfile,docNode);

winopen(clozes.xmlpath)
