% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2022 AdrianoRuseler
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
% MULTICHOICE_S MULTICHOICE_S
% MULTICHOICE_HS
% MULTICHOICE_VS

labels={circuit.PSIMCMD.data.signals.label}; % Data variables

if ~isfield(circuit.quiz,'exptable') % Add exptable
    circuit.quiz.exptable=0;
end


for q=1:length(circuit.quiz.question)
    multicellstr='';
    switch circuit.quiz.question{q}.type
        case 'STRING'
            multicell=['{1:MULTICHOICE:' multicellstr ];
%             multicell=['{1:MULTICHOICE:' multicellstr '}'];
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=1;
        case 'NUMERICAL'
            multicell='{1:NUMERICAL:';
            isnumerical=1;
            ispsimchoice=0;
            isstringchoice=0;
        case 'MULTICHOICE'
            multicell='{1:MULTICHOICE:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=0;
        case 'MULTICHOICE_H'
            multicell='{1:MULTICHOICE_H:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=0;
        case 'MULTICHOICE_V'
            multicell='{1:MULTICHOICE_V:';
            isnumerical=0;
            ispsimchoice=0;
        case 'MULTICHOICE_S'
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=0;
        case 'MULTICHOICE_HS'
            multicell='{1:MULTICHOICE_HS:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=0;
        case 'MULTICHOICE_VS'
            multicell='{1:MULTICHOICE_VS:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=0;
        case 'PSIMCHOICE'
            multicell='{1:MULTICHOICE:';
            isnumerical=0;
            ispsimchoice=1;
            isstringchoice=0;
        case 'PSIMCHOICE_S'
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=1;
            isstringchoice=0;
        case 'STRINGCHOICE'
            multicell='{1:MULTICHOICE:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=1;
        case 'STRINGCHOICE_S'
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=1;
        case 'STRINGCHOICE_HS'
            multicell='{1:MULTICHOICE_HS:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=1;
        case 'STRINGCHOICE_VS'
            multicell='{1:MULTICHOICE_VS:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=1;
        otherwise
            multicell='{1:MULTICHOICE_S:';
            isnumerical=0;
            ispsimchoice=0;
            isstringchoice=0;
            %   MULTICHOICE
    end

    if circuit.quiz.exptable
        if isfield(circuit.quiz.question{q},'expopts')
            expmulticell=['{1:MULTICHOICE_S:~%100%' circuit.quiz.question{q}.expopts{1}];
            lopts=length(circuit.quiz.question{q}.expopts); % Number of options per question
            for o=2:lopts % Get option value
                expmulticell = strcat(expmulticell,['~' circuit.quiz.question{q}.expopts{o}]);
            end
            expmulticell = strcat(expmulticell,'}');
            % quiz.question{q}.expopts={'IRb','IRc','VR2'}; % {1:MULTICHOICE:~IRc~Vc~%100%IRb}
            %             disp(expmulticell)
        end
    end


    % Gets option value from simulated data
    lopts=length(circuit.quiz.question{q}.options); % Number of options per question
    for o=1:lopts % Get option value
        if strcmp(circuit.quiz.question{q}.vartype{o},'func')
            circuit.quiz.question{q}.values(o)=circuit.funcvalue(circuit.quiz.question{q}.options{o});
        elseif strcmp(circuit.quiz.question{q}.vartype{o},'string')
            circuit.quiz.question{q}.values(o)=0;
        elseif strcmp(circuit.quiz.question{q}.vartype{o},'str') % equations options
            %                 quiz.question{q}.options={'EQ01','B','C','D','E'}; % Only lowcase
            % quiz.question{q}.vartype={'str'}; % meas
            % quiz.question{q}.optscore=[100 0 0 0 0]; % Score per option

            if(circuit.quiz.question{q}.optscore(o))
                multicellstr = strcat(multicellstr,['~%' num2str(circuit.quiz.question{q}.optscore(o)) '%' circuit.quiz.question{q}.options{o} ]);
            else
                multicellstr = strcat(multicellstr,['~' circuit.quiz.question{q}.options{o}]);
            end

        else
            optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
            if ~isempty(optind) % Label found
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                switch circuit.quiz.question{q}.vartype{o} % max, min, rms, mean, delta , meanround , math
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

    elseif isstringchoice % STRING CHOICE
        %
        % circuit.quiz.question{1}.options={'Expr01','Expr02','Expr03','Expr04','Expr05'};
        % circuit.quiz.question{1}.vartype={'string'}; % Expression
        % circuit.quiz.question{1}.optscore=[100 0 0 0 0]; % Score per option
        % circuit.quiz.question{1}.opttol=[10 10 10 10 10]; % tolerance in percentage %
        % circuit.quiz.question{1}.type='STRINGCHOICE';

        [optscoresort,optscoreind] = sort(circuit.quiz.question{q}.optscore,'descend');
        circuit.quiz.question{q}.optscore = optscoresort;
        circuit.quiz.question{q}.options = circuit.quiz.question{q}.options(optscoreind);

        %         disp(circuit.quiz.question{q}.options)
        for o=1:lopts
            optstr = circuit.quiz.question{q}.options(o);
            if(circuit.quiz.question{q}.optscore(o))
                multicell = strcat(multicell,['~%' num2str(circuit.quiz.question{q}.optscore(o)) '%' optstr{:} ]);
                %                 disp(multicell)
            else
                multicell = strcat(multicell,['~' optstr{:}]);
                %                 disp(multicell)
            end
        end

        multicell = strcat(multicell,'}');
        %         multicell = strrep(multicell,'u','&mu;'); % Substitui u por micro;


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
    if circuit.quiz.exptable
        circuit.quiz.question{q}.expchoicestr=expmulticell;
    end
end







