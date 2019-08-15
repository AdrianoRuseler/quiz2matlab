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
% NUMERICAL Only at first
function [tablecircuit]=ltspiceXtable(tablecircuit,circs)

% tablecircuit=stepcircuits{n};
% circs={circuits{n,:}};

% Tipo:
% STRING
% NUMERICAL
% Verifies parrmeters
% parstrs={circs{:}.nostepparstr};
% tf = strcmp(circs{1}.nostepparstr,parstrs);
% nequal=find(tf);

steps = length(circs); % How many steps?


% if steps == length(nequal)
%     disp('tablecircuit.nostepparstr=circs{1}.nostepparstr;')
tablecircuit.nostepparstr=circs{1}.nostepparstr;
% else
%     disp('Different parameters!')
%     tablecircuit.nostepparstr='';
% end


[x,y]=size(tablecircuit.quiz.table); % x-> n tabelas, y-> n colunas por tabela
for t=1:x % n tabels loop
    for s=1:steps    % n steps or n row in table
        circuit=circs{s}; % Pick the circuit from steps
        
        for c=1:y % y-> n colunas por tabela
            if isempty(tablecircuit.quiz.table{t,c})
                continue
            end
            
            switch tablecircuit.quiz.table{t,c}.vartype
                case 'opstep' % Not sure
                    labels={circuit.LTspice.data.signals.label}; % Data variables
                    optind=find(contains(labels,tablecircuit.quiz.table{t,c}.options,'IgnoreCase',true));
                    tablecircuit.quiz.table{t,c}.labelsind = optind(1);
                    tablecircuit.quiz.table{t,c}.values=[circuit.LTspice.data.signals(tablecircuit.quiz.table{t,c}.labelsind).op];
                case 'op'
                    try % error in simulation
                        labels={circuit.LTspice.data.signals.label}; % Data variables
                        optind=find(contains(labels,tablecircuit.quiz.table{t,c}.options,'IgnoreCase',true));
                        tablecircuit.quiz.table{t,c}.labelsind = optind(1);
                        tablecircuit.quiz.table{t,c}.values=[circuit.LTspice.data.signals(tablecircuit.quiz.table{t,c}.labelsind).op];
                    catch
                        tablecircuit.quiz.table{t,c}.values=0;
                    end
                case 'meas' % meas
                    try % error in simulation
                        fields = fieldnames(circuit.LTspice.log.meas);
                        optind=find(contains(fields,tablecircuit.quiz.table{t,c}.options));
                        if optind
                            eval(['tablecircuit.quiz.table{t,c}.values=circuit.LTspice.log.meas.' tablecircuit.quiz.table{t,c}.options ';']);
                        else
                            disp([ tablecircuit.quiz.table{t,c}.options ' -> meas not FOUND!!'])
                        end
                    catch
                        tablecircuit.quiz.table{t,c}.values=0;
                    end
                case 'log'
                    tmpstr=strsplit(tablecircuit.quiz.table{t,c}.options,':'); %
                    labels={circuit.LTspice.log.sdop{:}.Name}; % Data variables
                    optind=find(contains(labels,tmpstr{1},'IgnoreCase',true));
                    fields = fieldnames(circuit.LTspice.log.sdop{optind});
                    if find(contains(fields,tmpstr{2}))
                        eval(['tablecircuit.quiz.table{t,c}.values=circuit.LTspice.log.sdop{optind}.' tmpstr{2} ';'])
                    else
                        disp([ tmpstr{2} ' -> Log not FOUND!!']) % O que fazer?
                    end
                case 'pbc'
                    tbj=tbj2quiz(circuit,tablecircuit.quiz.table{t,c}.options);
                    tbjmchoice = tbj.pbc;
                case 'pbe'
                    tbj=tbj2quiz(circuit,tablecircuit.quiz.table{t,c}.options);
                    tbjmchoice = tbj.pbe;
                case 'pcb'
                    tbj=tbj2quiz(circuit,tablecircuit.quiz.table{t,c}.options);
                    tbjmchoice = tbj.pcb;
                case 'peb'
                    tbj=tbj2quiz(circuit,tablecircuit.quiz.table{t,c}.options);
                    tbjmchoice = tbj.peb;
                case 'mop'
                    tbj=tbj2quiz(circuit,tablecircuit.quiz.table{t,c}.options);
                    tbjmchoice = tbj.mop;
                    
                otherwise
                    disp([ tablecircuit.quiz.table{t,c}.vartype ' -> vartype not FOUND!!'])
            end
            
            switch tablecircuit.quiz.table{t,c}.type
                case 'STRING' % For step tables
                    tablecell{s,c} = real2eng(tablecircuit.quiz.table{t,c}.values,tablecircuit.quiz.table{t,c}.units);
                case 'NUMERICAL' % '{1:NUMERICAL:~%100%' num2str(varcalc*mult,'%03.3f') ':' num2str(Xres,'%03.3f') '}'
                    tablecell{s,c}=['{' tablecircuit.quiz.table{t,c}.weight ':NUMERICAL:'];
                    [~,~, expstr, mantissa] = real2eng(tablecircuit.quiz.table{t,c}.values,tablecircuit.quiz.table{t,c}.units);
                    tempstr=[sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*tablecircuit.quiz.table{t,c}.opttol/100))];  %  sprintf('%3.3f',mantissa)
                    tablecell{s,c} = strcat(tablecell{s,c},['~%' num2str(tablecircuit.quiz.table{t,c}.optscore) '%' tempstr '} ' expstr]);
                case 'SCALE'
                    tablecell{s,c} = num2scale(tablecircuit.quiz.table{t,c}.values,tablecircuit.quiz.table{t,c}.units);
                    
                case 'TBJ'
                    %                     disp('TBJ case!!')
                    %                     disp(tbjmchoice)
                    tablecell{s,c} = tbjmchoice;
                otherwise
                    disp([ tablecircuit.quiz.table{t,c}.type ' -> type not FOUND!!'])
            end
            
            
        end % y-> n colunas por tabela
    end % n steps or n row in table
    %     disp(tablecell)
    
    for c=1:y % y-> n colunas por tabela
        if isempty(tablecircuit.quiz.table{t,c})
            continue
        else
            tableheader{1,c}= tablecircuit.quiz.table{t,c}.header;
        end
    end
    
    tablecircuit.quiz.tables{t}.cells=tablecell;
    tablecircuit.quiz.tabletext{t}=clozetabgen(tablecell,tableheader); % Parece funcionar
    tablecell={}; % Reset
    tableheader={}; % Reset header
end % n tabels loop


% Generates text for cloze quiz
tablecircuit.quiz.text = [ '<p>'  tablecircuit.quiz.enunciado  '<br></p>'  tablecircuit.quiz.fightml ];

if isfield(tablecircuit.quiz,'extratext') % Add extra text
    for e=1:length(tablecircuit.quiz.extratext)
        tablecircuit.quiz.text=[tablecircuit.quiz.text '<p>' tablecircuit.quiz.extratext{e} '<br></p>'];
    end
end


for t=1:length(tablecircuit.quiz.tabletext)
    tablecircuit.quiz.text = [tablecircuit.quiz.text '<p>' tablecircuit.quiz.tablequestion{t} '<br>'  tablecircuit.quiz.tabletext{t} tablecircuit.quiz.tablecaption{t} '<br></p>' ];
end






