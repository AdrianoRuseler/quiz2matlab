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

% Tipo:
%
% NUMERICAL
% MULTICHOICE
% MULTICHOICE_H
% MULTICHOICE_V
% MULTICHOICE_S
% MULTICHOICE_HS
% MULTICHOICE_VS

labels={circuit.PSIMCMD.data.signals.label}; % Data variables

for q=1:length(circuit.quiz.question)
    
    switch circuit.quiz.question{q}.type
        case 'NUMERICAL'
            multicell='{1:NUMERICAL:';
            isnumerical=1;
            ispsimchoice=0;
        case 'MULTICHOICE'
            multicell='{1:MULTICHOICE:';
            isnumerical=0;
            ispsimchoice=0;
        case 'MULTICHOICE_H'
            multicell='{1:MULTICHOICE_H:';
            isnumerical=0;
            ispsimchoice=0;
        case 'MULTICHOICE_V'
            multicell='{1:MULTICHOICE_V:';
            isnumerical=0;
            ispsimchoice=0;
        case 'MULTICHOICE_S'
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=0;
        case 'MULTICHOICE_HS'
            multicell='{1:MULTICHOICE_HS:';
            isnumerical=0;
            ispsimchoice=0;
        case 'MULTICHOICE_VS'
            multicell='{1:MULTICHOICE_VS:';
            isnumerical=0;
            ispsimchoice=0;
        case 'PSIMCHOICE'
            multicell='{1:MULTICHOICE:';
            isnumerical=0;
            ispsimchoice=1;
        case 'PSIMCHOICE_S'
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=1;
        otherwise
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=0;
            %   MULTICHOICE
    end
    
    % Gets option value from simulated data
    lopts=length(circuit.quiz.question{q}.options); % Number of options per question
    for o=1:lopts % Get option value
        if strcmp(circuit.quiz.question{q}.vartype{o},'func')
            circuit.quiz.question{q}.values(o)=circuit.funcvalue(circuit.quiz.question{q}.options{o});
        else
            optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
            if ~isempty(optind) % Label found
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                switch circuit.quiz.question{q}.vartype{o} % max, min, rms, mean, delta , meanround
                    case 'max'
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).max];
                    case 'min'
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).min];
                    case 'rms'
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).rms];
                    case 'mean'
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).mean];
                    case 'meanround'
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).meanround];
                    case 'delta'
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).delta];
                    otherwise
                        circuit.quiz.question{q}.values(o)=[circuit.PSIMCMD.data.signals(circuit.quiz.question{q}.labelsind(o)).mean];
                end
            else
                disp('EMPTY! Please set variable im simulation!!')
                disp(circuit)
                circuit.quiz.question{q}.values(o)=[]; %
                disp('EMPTY! Please set variable im simulation!!')
            end
        end
    end
    
    
    if isnumerical % NUMERICAL
        for o=1:lopts % get option value
            [~,~, expstr, mantissa] = real2eng(circuit.quiz.question{q}.values(o),circuit.quiz.question{q}.units{o});
            tempstr=[sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*circuit.quiz.question{q}.opttol(o)/100))];  %  sprintf('%3.3f',mantissa)
            if(circuit.quiz.question{q}.optscore(o))
                multicell = strcat(multicell,['~%' num2str(circuit.quiz.question{q}.optscore(o)) '%' tempstr ]);
                if isfield(circuit.quiz.question{q},'feedback')
                    for fb=1:length(circuit.quiz.question{q}.feedback)
                        if fb==1
                            multicell = strcat(multicell,['#' circuit.quiz.question{q}.feedback{fb}]);
                        else
                            tempstr=[sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*circuit.quiz.question{q}.opttol(fb)/100))];  %  sprintf('%3.3f',mantissa)
                            multicell = strcat(multicell,['~%' num2str(circuit.quiz.question{q}.optscore(fb)) '%' tempstr ]);
                            multicell = strcat(multicell,['#' circuit.quiz.question{q}.feedback{fb}]); % Adds feedback
                        end
                    end
                end
            else
                multicell = strcat(multicell,['~' tempstr]);
            end
            
        end
        multicell = strcat(multicell,['}' expstr]);
        
    elseif ispsimchoice % PSIM CHOICE
%         disp('IS PSIM CHOICE!!!!')       
        
        % quiz.question{q}.units={'opt1','opt2','opt3'};
        % quiz.question{q}.options={'optx'}; % Var for correct answer
        % quiz.question{q}.vartype={'meanround'}; %
        % quiz.question{q}.optscore=[100]; % Score per option
        % quiz.question{q}.opttol=[10]; % tolerance in percentage %
        % quiz.question{q}.type='PSIMCHOICE';
        
        o=1; % This shold be for just 1 option
        correctopt= circuit.quiz.question{q}.values(o); % correct option
        
        
        for opts=1:length(circuit.quiz.question{q}.units)
            if(correctopt==opts)
                multicell = strcat(multicell,['~%100%' circuit.quiz.question{q}.units{opts} ]);
            else
                multicell = strcat(multicell,['~' circuit.quiz.question{q}.units{opts}]);
            end            
        end       
        
        multicell = strcat(multicell,'}');        
        
%         disp(multicell)        
        
    else  %   MULTICHOICE
        [optscoresort,optscoreind] = sort(circuit.quiz.question{q}.optscore,'descend');
        circuit.quiz.question{q}.optscore = optscoresort;
        circuit.quiz.question{q}.values = circuit.quiz.question{q}.values(optscoreind);
        circuit.quiz.question{q}.units = circuit.quiz.question{q}.units(optscoreind);
        
        %  circuit.quiz.question{q}.values % Are unique?? % Changes all
        tempres1=round(circuit.quiz.question{q}.values*1000,3,'significant');
        if ~isequal(length(unique(tempres1)),length(tempres1)) % Options are not unique
            for o=1:lopts
                if(circuit.quiz.question{q}.optscore(o))% Scored option - dont change it!
                    
                else % Option can be changed - no score
                    tempopts= unique([circuit.quiz.question{q}.values(o) circuit.quiz.question{q}.values(o).*[(rand(1,lopts)) (1+rand(1,lopts))]]);
                    circuit.quiz.question{q}.values(o)= tempopts(randperm(length(tempopts),1));
                end
            end % Loop
        end
        
        
        for o=1:lopts
            optstr = real2eng(circuit.quiz.question{q}.values(o),circuit.quiz.question{q}.units{o}); % Gets option value with unit in eng format
            if(circuit.quiz.question{q}.optscore(o))
                multicell = strcat(multicell,['~%' num2str(circuit.quiz.question{q}.optscore(o)) '%' optstr ]);
            else
                multicell = strcat(multicell,['~' optstr]);
            end
        end
        
        multicell = strcat(multicell,'}');
        %         multicell = strrep(multicell,'u','&mu;'); % Substitui u por micro;
        
    end
    circuit.quiz.question{q}.choicestr=multicell;
end

