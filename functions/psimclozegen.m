% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2021 AdrianoRuseler
% ***
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% ***
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% ***
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================

function quizstruct = psimclozegen(circuits,quizopts)

quizstruct.question.type = quizopts.type;
quizstruct.name=quizopts.name;

ntquiz=length(circuits);

if quizopts.nquiz>ntquiz
    quizopts.nquiz=ntquiz;
end
% nquiz=length(circuits); % Number of quiz

if(quizopts.permutquiz)
    nq=randperm(ntquiz,quizopts.nquiz); % escolha as questoes
    tmpcircuits={circuits{:,nq}};
else
    tmpcircuits=circuits;
end

for q=1:quizopts.nquiz
    if isfield(tmpcircuits{q},'parstr')
        if isfield(tmpcircuits{q},'model')
            tmpstr='';
            for ml=1:length(tmpcircuits{q}.model) % number of .model lines
                tmpstr=[tmpstr '(' strrep(tmpcircuits{q}.model(ml).parstr,' ','') ')'];
            end
            quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i') '(' strrep(tmpcircuits{q}.parstr,' ','') ')'  tmpstr ]; % Generates quiz name

        else
            quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i') '(' strrep(tmpcircuits{q}.parstr,' ','') ')']; % Generates quiz name
        end
    elseif isfield(tmpcircuits{q},'nostepparstr')
        quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i') '(' strrep(tmpcircuits{q}.nostepparstr,' ','') ')']; % Generates quiz name
    else
        quizstruct.question.name{q}=[tmpcircuits{q}.quiz.name 'q' num2str(q,'%03i')]; % Generates quiz name
    end

    quizstruct.question.text{q}=tmpcircuits{q}.quiz.text;

    if tmpcircuits{q}.quiz.modelfile % Add model file with link to it
        quizstruct.question.filebase64code{q}=tmpcircuits{q}.model(1).filebase64code;
        quizstruct.question.filename{q} = tmpcircuits{q}.quiz.nomearquivo;
    end

    if tmpcircuits{q}.quiz.scriptfile % Add PSIM script file with link to it
        quizstruct.question.filebase64code{q}=tmpcircuits{q}.PSIMCMD.script.base64code;
        quizstruct.question.filename{q} = tmpcircuits{q}.PSIMCMD.script.name;
    end

    disp(quizstruct.question.name{q}) % Display question name
    quizstruct.question.generalfeedback{q}=quizopts.generalfeedback;
    quizstruct.question.penalty{q}=quizopts.penalty;
    quizstruct.question.hidden{q}=quizopts.hidden;
end

quizstruct.questionnumbers = quizopts.nquiz; % Numero de questoes geradas.
quizstruct.questionMAX=quizopts.nquizperxml; % Numero de questoes por arquivo xml

quizstruct.xmlpath=quizopts.xmlpath; % Pasta com arquivos gerados

