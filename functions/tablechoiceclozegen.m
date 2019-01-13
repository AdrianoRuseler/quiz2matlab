% Cria quiz com tabela de dados e op��es para responder
function quizstruct = tablechoiceclozegen(quizstruct)

quizstruct.question.type = 'cloze'; % Tipo de quest�o
pngfigstr=png2base64([pwd '\figs\' quizstruct.figname '.png']); % Carrega figura do enunciado da quest�o

% quizstruct.question.str

[~,y]=size(quizstruct.Xu); % Tamanho da matriz com par�metros
nq=randperm(y,quizstruct.sortnquestions); % escolha as questoes
for q=1:length(nq)
    n=nq(q); % Pega elemento sorteado
    parstr=param2str(quizstruct.Xu(:,n),quizstruct.parname,quizstruct.parunit); % Gera string com par�metros
    quizstruct.question.name{q}=[quizstruct.name 'q' num2str(q,'%04i') ' (' parstr ')']; % Gera nome da quest�o
    
    figlegstr=[quizstruct.figlegendastr parstr ]; % Gera legenda da figura
    figstr=['<p style="text-align: left;">' pngfigstr '</p><p style="text-align: left;">' figlegstr '<br></p>']; % Gera c�digo html da figura
    
    quizstruct.question.text{q}=[ '<p>'  quizstruct.perguntastr  figstr '<br></p>']; % Gera enunciado da quest�o
    
    
    %     [iRB iRC iCC vCE vBE vCC vCB];
    noptsu=length(quizstruct.question.str);
    for a=1:noptsu
        opts=quizstruct.Ru{n}(quizstruct.question.nopts(a,:));
        nsopts=length(opts);
        optsvalues=[opts opts.*(rand(1,nsopts)) opts.*(1+rand(1,nsopts))]; % Verificar se respostas s�o unicas        
        choicestr=clozeXmultichoice(optsvalues,quizstruct.question.crt(a),quizstruct.question.units{a},'MULTICHOICE_S'); % Obtem string com respostas   
        
        quizstruct.question.text{q}=[quizstruct.question.text{q}   ' <p> ' quizstruct.question.str{a} ' '  choicestr '<br></p>'];        
    end
    
    
    disp(quizstruct.question.name{q}) % Mostra a quest�o
    quizstruct.question.generalfeedback{q}='';
    quizstruct.question.penalty{q}='0.25';
    quizstruct.question.hidden{q}='0';
end

quizstruct.questionnumbers = q; % Numero de questoes geradas.
quizstruct.questionMAX=q+1; % Numero de questoes por arquivo xml

quizstruct.xmlpath=[ pwd '\xmlfiles']; % Pasta com arquivos gerados
% cloze2moodle(quizstruct) % Exporta em arquivos xml