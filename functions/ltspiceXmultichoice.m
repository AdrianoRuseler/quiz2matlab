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

function [circuit]=ltspiceXmultichoice(circuit)

% Tipo:
%
% NUMERICAL
% MULTICHOICE
% MULTICHOICE_H
% MULTICHOICE_V
% MULTICHOICE_S
% MULTICHOICE_HS
% MULTICHOICE_VS

if isfield(circuit.LTspice.data,'signals')
    labels={circuit.LTspice.data.signals.label}; % Data variables
end

for q=1:length(circuit.quiz.question)
    
    lopts=length(circuit.quiz.question{q}.options); % Number of options per question
    for o=1:lopts % Get option value
        
        tmpvartype=strsplit(circuit.quiz.question{q}.vartype{o},':'); %
        switch tmpvartype{1}
            case 'func'
                circuit.quiz.question{q}.values(o)=circuit.funcvalue(circuit.quiz.question{q}.options{o});
            case 'max'
                optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).max];
            case 'min'
                optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).min];
            case 'rms'
                optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).rms];
            case 'mean'
                optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).mean];
            case 'op'
                optind=find(contains(labels,circuit.quiz.question{q}.options{o},'IgnoreCase',true));
                circuit.quiz.question{q}.labelsind(o) = optind(1);
                circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).op];
            case 'meas' % .meas
                %                     circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).meas];
                if isfield(circuit.LTspice.log,'meas')
                    fields = fieldnames(circuit.LTspice.log.meas);
                    optind=find(contains(fields,circuit.quiz.question{q}.options{o}));
                    if optind
                        eval(['circuit.quiz.question{q}.values(o)=circuit.LTspice.log.meas.' circuit.quiz.question{q}.options{o} ';'])
                    else
                        disp([ circuit.quiz.question{q}.options{o} ' -> meas not FOUND!!'])
                        circuit.quiz.question{q}.values(o)=[];
                    end
                else
                    disp([ circuit.quiz.question{q}.options{o} ' -> meas not FOUND!!'])
                    circuit.quiz.question{q}.values(o)=[];
                end
            case 'log'
                tmpstr=strsplit(circuit.quiz.question{q}.options{o},':'); %
                ndevgroups=length(circuit.LTspice.log.sdop); % Number os groups, TBJ, Fet...
                for g=1:ndevgroups
                    devnames={circuit.LTspice.log.sdop{g}.Name}; % Data variables
                    devfields{g} = fieldnames(circuit.LTspice.log.sdop{g}); % Grupo g
                    if find(contains(devfields{g},tmpstr{2}))
                        devind=find(contains(devnames{:},tmpstr{1},'IgnoreCase',true));
                        if devind
                            eval(['circuit.quiz.question{q}.values(o)=circuit.LTspice.log.sdop{g}.' tmpstr{2} '(' num2str(devind) ');'])
                        else
                            disp([ tmpstr{2} ' -> Log not FOUND!!']) % O que fazer?
                        end
                    end
                end
                
            case 'pbc'
                tbj=tbj2quiz(circuit,circuit.quiz.question{q}.options{o});
                tbjmchoice = tbj.pbc;
            case 'pbe'
                tbj=tbj2quiz(circuit,circuit.quiz.question{q}.options{o});
                tbjmchoice = tbj.pbe;
            case 'mop'
                %                 if strcmp(circuit.quiz.question{q}.type,'FET')
                %                     fet=fet2quiz(circuit,circuit.quiz.question{q}.options{o});
                %                     fetmchoice = fet.mop;
                %                 else
                tbj=tbj2quiz(circuit,circuit.quiz.question{q}.options{o});
                tbjmchoice = tbj.mop;
                %                 end
            case 're'
                tbj=tbj2quiz(circuit,circuit.quiz.question{q}.options{o});
                circuit.quiz.question{q}.values(o)=tbj.re;
            case 'ro'
                tbj=tbj2quiz(circuit,circuit.quiz.question{q}.options{o});
                circuit.quiz.question{q}.values(o)=tbj.Ro;
                
            case 'feteval'
                switch tmpvartype{2}
                    case 'mop'
                        fet=fet2quiz(circuit,circuit.quiz.question{q}.options{o});
                        fetmchoice = fet.mop;
                    otherwise
                        fet=fet2quiz(circuit,circuit.quiz.question{q}.options{o});
                        circuit.quiz.question{q}.values(o)=fet.(tmpvartype{2});
                end
                
            otherwise
                disp('circuit.quiz.question{q}.values(o)=[circuit.LTspice.data.signals(circuit.quiz.question{q}.labelsind(o)).mean];')
        end
    end
    
    ismultichoice=0;
    switch circuit.quiz.question{q}.type
        case 'STRING'
            multicell='';
        case 'NUMERICAL'
            multicell='{1:NUMERICAL:'; %  {1:NUMERICAL:~%100%704.000:70.400} mV
            for o=1:lopts % get option value
                if isfield(circuit.quiz.question{q},'values')
                    [~,~, expstr, mantissa] = real2eng(circuit.quiz.question{q}.values(o),circuit.quiz.question{q}.units{o});
                    tempstr=[sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*circuit.quiz.question{q}.opttol(o)/100))];  %  sprintf('%3.3f',mantissa)
                    if(circuit.quiz.question{q}.optscore(o))
                        multicell = strcat(multicell,['~%' num2str(circuit.quiz.question{q}.optscore(o)) '%' tempstr ]);
                    else
                        multicell = strcat(multicell,['~' tempstr]);
                    end
                else
                    expstr ='';
                end
            end
            multicell = strcat(multicell,['}' expstr]);
            
        case 'TBJ'
            multicell = tbjmchoice;
        case 'FET'
            multicell = fetmchoice;
        case 'MULTICHOICE'
            multicell='{1:MULTICHOICE:';
            ismultichoice=1;
        case 'MULTICHOICE_H'
            multicell='{1:MULTICHOICE_H:';
            ismultichoice=1;
        case 'MULTICHOICE_V'
            multicell='{1:MULTICHOICE_V:';
            ismultichoice=1;
        case 'MULTICHOICE_S'
            multicell='{1:MULTICHOICE_S:';
            ismultichoice=1;
        case 'MULTICHOICE_HS'
            multicell='{1:MULTICHOICE_HS:';
            ismultichoice=1;
        case 'MULTICHOICE_VS'
            multicell='{1:MULTICHOICE_VS:';
            ismultichoice=1;
        otherwise
            multicell='{1:MULTICHOICE_S:';
            ismultichoice=1;
    end
    
    
    if ismultichoice   %   MULTICHOICE
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

