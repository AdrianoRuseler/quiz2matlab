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
% Generate Quiz Struct for Resistor Choice.
function  [quizstruct] = genqs4remc(Values,tol,EXX,name,theme) % Values can be a vector
% [quizstruct] = genqs4remc(15e3,5,'E24','LAB01Q02a','clean')

quizstruct.name = name;
quizstruct.question.type = 'multichoice';

 colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};
 
 for n=1:length(Values)
     
     quizstruct.question.answernumbers{n}=5; % Numero de escolhas
     
     [band,colornamestr,valuestr] = rband(Values(n),tol,EXX);
     
     
     quizstruct.question.text{n}=['Qual dos resistores abaixo possui uma resistência de ' valuestr '?'];
     [Yc,~] = printresistor(band,theme);
     quizstruct.question.answer{n}{1}=['<p style="text-align: center;"><img src="data:image/png;base64,' Yc '" alt="" width="325" height="59"></p><p style="text-align: center;">(' colornamestr ')</p><br><p></p>'];
     quizstruct.question.answerfraction{n}{1}='100';
     quizstruct.question.answerfeedback{n}{1}='';
     
     
     dband=band(randperm(length(band)));
     [Yc,~] = printresistor(dband,theme);
     if length(band)==4
         dcolornamestr=[ colorname{dband(1)} ', ' colorname{dband(2)} ', ' colorname{dband(3)} ' e ' colorname{dband(4)} ];
     elseif length(band)==5
         dcolornamestr=[ colorname{dband(1)} ', ' colorname{dband(2)} ', ' colorname{dband(3)} ', ' colorname{dband(4)} ' e ' colorname{dband(5)} ];
     end
     quizstruct.question.answer{n}{2}=['<p style="text-align: center;"><img src="data:image/png;base64,' Yc '" alt="" width="325" height="59"></p><p style="text-align: center;">(' dcolornamestr ')</p><br><p></p>'];
     quizstruct.question.answerfraction{n}{2}='0';
     quizstruct.question.answerfeedback{n}{2}='';
     
     
     for r=3:5 % Generates more 4 dump resistors
         if length(band)==4
             dband = randi([1 12],1,4);
             dband=dband(randperm(4));
             dcolornamestr=[ colorname{dband(1)} ', ' colorname{dband(2)} ', ' colorname{dband(3)} ' e ' colorname{dband(4)} ];
         elseif length(band)==5
             dband = randi([1 12],1,5);
             dband=dband(randperm(5));
             dcolornamestr=[ colorname{dband(1)} ', ' colorname{dband(2)} ', ' colorname{dband(3)} ', ' colorname{dband(4)} ' e ' colorname{dband(5)} ];
         end
         
         [Yc,~] = printresistor(dband,theme);
         quizstruct.question.answer{n}{r}=['<p style="text-align: center;"><img src="data:image/png;base64,' Yc '" alt="" width="325" height="59"></p><p style="text-align: center;">(' dcolornamestr ')</p><br><p></p>'];
         quizstruct.question.answerfraction{n}{r}='0'; % Pontuação
         quizstruct.question.answerfeedback{n}{r}='';
     end
     
     
     quizstruct.question.name{n}=[name ' genqs4remc(' strrep(valuestr,' ','') ')'];
     disp(quizstruct.question.name{n}) % Mostra nome da questão
     
     quizstruct.question.generalfeedback{n}='';
     
     quizstruct.question.defaultgrade{n}='5';
     quizstruct.question.penalty{n}='0.25';
     quizstruct.question.hidden{n}='0';
     
     quizstruct.question.unitgradingtype{n} = '0';
     quizstruct.question.unitpenalty{n} = '0.1000000';
     quizstruct.question.showunits{n}= '3';
     quizstruct.question.unitsleft{n} = '0';
     
     quizstruct.question.single{n} = 'true';
     quizstruct.question.shuffleanswers{n} = 'true';
     quizstruct.question.answernumbering{n} = 'abc';
     
 end

quizstruct.question.correctfeedback = 'Sua resposta está correta!';
quizstruct.question.partiallycorrectfeedback = 'Sua resposta está parcialmente correta!';
quizstruct.question.incorrectfeedback = 'Sua resposta está incorreta!';

quizstruct.questionnumbers = n; % Numero de questoes geradas.
quizstruct.questionMAX=500; % Numero máximo de questões por arquivo.




