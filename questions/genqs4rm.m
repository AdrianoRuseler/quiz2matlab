% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2019 AdrianoRuseler
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
% Generate Quiz Struct for Resistor measurement.
function  [quizstruct] = genqs4rm(Values,tol,EXX,name) % Values can be a vector

quizstruct.name = name;
quizstruct.question.type = 'cloze';


for n=1:length(Values)    
    
    [~,quiz,valuestr,~] = rbandcolorid(Values(n),tol,EXX);
    quizstruct.question.name{n}=[name ' genqs4rm(' strrep(valuestr,' ','') ')'];
    
    quizstruct.question.text{n}=['<p>Qual a sequência de cores do resistor de ' valuestr '?</p>' quiz.tableMULTICHOICE ...
        '<br><p>Com um multímetro, meça o resistor de ' valuestr ' e preencha os campos abaixo:</p>'...
        '<p>Valor medido é: ' quiz.valorNUMERICAL '&Omega; na escala de ' quiz.escalaMULTICHOICE '</p>'];
    
    disp(quizstruct.question.name{n})
    quizstruct.question.generalfeedback{n}='';
    quizstruct.question.penalty{n}='0.25';
    quizstruct.question.hidden{n}='0';
end

quizstruct.questionnumbers = n; % Numero de questoes geradas.
quizstruct.questionMAX=500;




