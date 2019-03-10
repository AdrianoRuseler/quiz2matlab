% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2018 AdrianoRuseler
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

function [circuit]=psimXmultichoice(circuit)

% Ru - Vetor numérico com respostas
% RuCerta - Indice com a resposta correta
% unidade  - unidade da resposta, ex V, A Ohms...
% Tipo:
% 
% MULTICHOICE
% MULTICHOICE_H
% MULTICHOICE_V
% MULTICHOICE_S
% MULTICHOICE_HS
% MULTICHOICE_VS

labels={circuit.PSIMCMD.data.signals.label}; % PSIM data variables

for q=1:length(circuit.quiz.question)
    
    switch circuit.quiz.question{q}.choicetype
        case 'MULTICHOICE'
            multicell='{1:MULTICHOICE:';
        case 'MULTICHOICE_H'
            multicell='{1:MULTICHOICE_H:';
        case 'MULTICHOICE_V'
            multicell='{1:MULTICHOICE_V:';
        case 'MULTICHOICE_S'
            multicell='{1:MULTICHOICE_S:';
        case 'MULTICHOICE_HS'
            multicell='{1:MULTICHOICE_HS:';
        case 'MULTICHOICE_VS'
            multicell='{1:MULTICHOICE_VS:';
        otherwise
            multicell='{1:MULTICHOICE_S:';
            %   MULTICHOICE
    end
    
    for o=1:length(circuit.quiz.question{q}.options) % Number of options per question
        circuit.quiz.question{q}.optsind(o) = find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.optsind(o)).mean];
        
        if(circuit.quiz.question{q}.optscore(o))
            multicell = strcat(multicell,['~%' num2str(circuit.quiz.question{q}.optscore(o)) '%' strrep(num2eng(circuit.quiz.question{q}.values(o),1),'.',',') circuit.quiz.question{q}.units{o}]);
        else
            multicell = strcat(multicell,['~' strrep(num2eng(circuit.quiz.question{q}.values(o),1),'.',',') circuit.quiz.question{q}.units{o}]);
        end       
        
    end
    
    multicell = strcat(multicell,'}');
    multicell = strrep(multicell,'u','&mu;'); % Substitui u por micro;      

    circuit.quiz.question{q}.choicestr=multicell;
end

