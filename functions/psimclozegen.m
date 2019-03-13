



function quizstruct = psimclozegen(circuits,name)


quizstruct.question.type = 'cloze';
quizstruct.name=name;

nquiz=length(circuits); % Number of quiz

for q=1:nquiz

    quizstruct.question.name{q}=[circuits{q}.quiz.name 'q' num2str(q,'%04i') '(' strrep(circuits{q}.parstr,' ','') ')']; % Gera nome da questão
    
    quizstruct.question.text{q}=circuits{q}.quiz.text;
    
    disp(quizstruct.question.name{q}) % Mostra a questão
    quizstruct.question.generalfeedback{q}='';
    quizstruct.question.penalty{q}='0.25';
    quizstruct.question.hidden{q}='0';
end


quizstruct.questionnumbers = nquiz; % Numero de questoes geradas.
quizstruct.questionMAX=nquiz+1; % Numero de questoes por arquivo xml

quizstruct.xmlpath=[ pwd '\xmlfiles']; % Pasta com arquivos gerados

