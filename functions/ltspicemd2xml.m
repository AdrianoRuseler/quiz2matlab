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

function ltspicemd2xml(circuit,quiz) % Added device model

circuit.LTspice.name = circuit.name; % File name
circuit.LTspice.simsdir= circuit.dir; % sim file dir

circuit.LTspice.tmpfile = 1; % Create tmp file?
circuit.LTspice.tmpdir = 1; % Use system temp dir?
circuit.LTspice.tmpfiledel = 1; % Delete tmp files?

circuit.LTspice.ascfile = [circuit.LTspice.simsdir circuit.LTspice.name '.asc']; % Sim base file

circuit = ltgetasc(circuit); % reads asc file
circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file

if ~isfield(circuit.LTspice.net,'run')
    circuit.LTspice.net.run =0;
end

if ~isfield(quiz,'modelfile') % Create file with model
    quiz.modelfile=0;
end

if ~isfield(quiz,'scriptfile') % Create file with PSIM script
    quiz.scriptfile=0;
end

% circuit.nsims=600; % Number of simulations
[~,y]=size(circuit.Xi);
if y>circuit.nsims
    nq=randperm(y,circuit.nsims); % escolha as questoes
    X=circuit.Xi(:,nq);
else
    X=circuit.Xi;
    circuit.nsims=y;
end

circuit.Xi=[]; % Clear

if isfield(circuit,'parind') && isfield(circuit,'modind')
    for c=1:circuit.nsims
        tmpcircuits{c}=circuit;
        tmpcircuits{c}.parvalue=X(circuit.parind,c); % Variables values
        tmpcircuits{c}.parstr = param2str(tmpcircuits{c});

        for m=1:length(circuit.model)
            if iscell(circuit.modind)
                tmpcircuits{c}.model(m).parvalue=X(circuit.modind{m,:},c); % Variables values
            else
                tmpcircuits{c}.model(m).parvalue=X(circuit.modind(m,:),c); % Variables values
            end
        end

        tmpcircuits{c} = model2str(tmpcircuits{c});

        if quiz.modelfile
            tmpcircuits{c} = model2file(tmpcircuits{c}); % Creates file with model
        end

        tmpcircuits{c}.funcvalues = X(:,c); % Function Variables values

        %         circuit.model(m).parstr=parstr;
        %         circuit.model(m).modelstr=modelstr;

    end
elseif isfield(circuit,'parind') && isfield(circuit,'level')
    for c=1:circuit.nsims
        tmpcircuits{c}=circuit;
        tmpcircuits{c}.parvalue=X(circuit.parind,c); % Variables values
        tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
        tmpcircuits{c}.level.varvalue=X(circuit.level.lvlind,c);
        tmpcircuits{c} = level2str(tmpcircuits{c});
        tmpcircuits{c}.funcvalues = X(:,c); % Function Variables values
    end
else
    for c=1:circuit.nsims
        tmpcircuits{c}=circuit;
        tmpcircuits{c}.parvalue=X(:,c); % Variables values
        tmpcircuits{c}.funcvalues = X(:,c); % Function Variables values
        tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
    end
end

% Eval functions
[~,y]=size(X);
if isfield(circuit,'funcstr')
    for c=1:y
        parvalues = tmpcircuits{c}.funcvalues; % Its used in function input eval
        for f=1:length(circuit.funcstr) % Functions loop
            tmpcircuits{c}.funcvalue(f)=eval(circuit.funcstr{f}); % Eval functions
        end
    end
end

%   Runs simulation OK!
% [~,y]=size(X);
parfor n=1:circuit.nsims
    tmpcircuits{n} = ltspicefromcmd(tmpcircuits{n}); % Simula via CMD
end

% for n=1:y
%     tmpcircuits{n} = ltspicefromcmd(tmpcircuits{n}); % Simula via CMD
% end
% tmpcircuits=circuits;

if ~isfield(quiz,'feteval')
    quiz.feteval=0;
end

if ~isfield(quiz,'tbjeval')
    quiz.tbjeval=0;
end


% Clear empty simulated data
y=1;
for c=1:length(tmpcircuits)
    if isfield(tmpcircuits{c}.LTspice,'data') % Simulation OK!
        if(~tmpcircuits{c}.LTspice.data.error)
            if(quiz.feteval)
                fet=fet2quiz(tmpcircuits{c},quiz.fettype);

                circuits{y}=tmpcircuits{c};
                y=y+1;
            else
                circuits{y}=tmpcircuits{c};
                y=y+1;
            end


            if(quiz.tbjeval)
                tbj=tbj2quiz(tmpcircuits{c},quiz.tbjtype);
                disp(tbj)
                %          if(tbj.ampmode)
                if(tbj.BetaDC>=tmpcircuits{c}.model.parvalue(2))
                    disp([num2str(tbj.BetaDC) '>=' num2str(tmpcircuits{c}.model.parvalue(2)) ' ==> Modo Ativo Direto!'])
                    circuits{y}=tmpcircuits{c};
                    y=y+1;
                end
            else
                circuits{y}=tmpcircuits{c};
                y=y+1;
            end
        else
            circuits{y}=tmpcircuits{c}; % .ac error
            y=y+1;
        end
    else
        if isfield(tmpcircuits{c},'model')
            disp(['No data file in simulation ' num2str(c) ' with ' tmpcircuits{c}.parstr ' and ' tmpcircuits{c}.model.parstr '!'])
        else
            disp(['No data file in simulation ' num2str(c) ' with ' tmpcircuits{c}.parstr '!'])
        end
    end
end



pngfile=[circuit.dir circuit.name '.png']; % Fig png file
if isfield(circuit,'theme')
    imgout=[circuit.dir circuit.name circuit.theme '.png']; % Fig png file
    pngchangewhite(pngfile,imgout,circuit.theme)
else
    imgout=[circuit.dir circuit.name 'clean.png']; % Fig png file
    pngchangewhite(pngfile,imgout,'clean')
end

quiz.name = [circuit.name];

% Auto add item letter: a), b)... 97 - 122; 65 - 90
if isfield(quiz,'autoitem') && quiz.autoitem
    for q=1:length(quiz.question)
        quiz.question{q}.str=[ char(96+q) ') ' quiz.question{q}.str];
        disp(quiz.question{q}.str)
    end
end

for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura modelstr

    if isfield(circuit,'model') && ~(quiz.modelfile)
        for ml=1:length(circuit.model) % number of .model lines
            circuits{n}.quiz.extratext{ml}=['Parâmetros do ' circuit.model(ml).name ': ' circuits{n}.model(ml).parstr];
        end
    end

    if isfield(circuit,'level')
        if isfield(circuit.level,'tipo')
            circuits{n}.quiz.extratext{1}=['Parâmetros do ' circuit.level.tipo ': ' circuits{n}.level.parstr];
        end
    end


    %     circuits{n}.quiz.extratext{2}=tmpcircuits{c}.model.modelstr;
    circuits{n}.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig
    circuits{n} = ltspiceXmultichoice(circuits{n}); % Generate multichoice
    circuits{n} = quiztextgen(circuits{n}); % Generates quiz text field
end

%% Generate quizstruct moodle question
quizopts.name=circuit.name;
quizopts.nquiz=quiz.nquiz; % Number of quizes
quizopts.permutquiz =1; % Permut quiz?
quizopts.nquizperxml=1000; % Number of quizes per file
quizopts.type = 'cloze';
quizopts.xmlpath = [ pwd '\xmlfiles']; % Folder for xml files
quizopts.generalfeedback='';
quizopts.penalty='0.25';
quizopts.hidden='0';

if ~isfield(quiz,'incfrom') % Increment question from
    quizopts.incfrom=0;
else
    quizopts.incfrom=quiz.incfrom;
end

quizstruct = psimclozegen(circuits,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file

