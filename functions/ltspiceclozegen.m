
% ltspiceclozegen.m
function quizstruct = ltspiceclozegen(circuits,quizopts)

quizstruct.question.type = quizopts.type;
quizstruct.name=quizopts.name;

ntquiz=length(circuits);

if quizopts.nquiz>ntquiz
    quizopts.nquiz=ntquiz;
end
% Number of quiz

if(quizopts.permutquiz)
    nq=randperm(ntquiz,quizopts.nquiz); % escolha as questoes
    tmpcircuits={circuits{:,nq}};
else
    tmpcircuits=circuits;
end

for q=1:quizopts.nquiz
    if isfield(tmpcircuits{q},'parstr')
        quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i') '(' strrep(tmpcircuits{q}.parstr,' ','') ')']; % Generates quiz name
    elseif isfield(tmpcircuits{q},'nostepparstr')
        quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i') '(' strrep(tmpcircuits{q}.nostepparstr,' ','') ')']; % Generates quiz name
    else
        quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i')]; % Generates quiz name
    end
    quizstruct.question.text{q}=tmpcircuits{q}.quiz.text;
    
    disp(quizstruct.question.name{q}) % Display question name
    quizstruct.question.generalfeedback{q}=quizopts.generalfeedback;
    quizstruct.question.penalty{q}=quizopts.penalty;
    quizstruct.question.hidden{q}=quizopts.hidden;
end

quizstruct.questionnumbers = quizopts.nquiz; % Numero de questoes geradas.
quizstruct.questionMAX=quizopts.nquizperxml; % Numero de questoes por arquivo xml

quizstruct.xmlpath=quizopts.xmlpath; % Pasta com arquivos gerados

