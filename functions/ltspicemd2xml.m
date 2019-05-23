

function ltspicemd2xml(circuit,quiz) % Added device model

circuit.LTspice.name = circuit.name; % File name
circuit.LTspice.simsdir= circuit.dir; % sim file dir

circuit.LTspice.tmpfile = 1; % Create tmp file?
circuit.LTspice.tmpdir = 1; % Use system temp dir?
circuit.LTspice.tmpfiledel = 1; % Delete tmp files?
circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file

% circuit.nsims=600; % Number of simulations
[~,y]=size(circuit.Xi);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.X=circuit.Xi(:,nq);

circuit.Xi=[]; % Clear

for c=1:length(circuit.X)
    tmpcircuits{c}=circuit;
    tmpcircuits{c}.parvalue=circuit.X(circuit.parind,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c});    
    
    tmpcircuits{c}.model.parvalue=circuit.X(circuit.modind,c); % Variables values
    tmpcircuits{c} = model2str(tmpcircuits{c});
end

%   Runs simulation OK!
[~,y]=size(circuit.X);
parfor n=1:y
    tmpcircuits{n} = ltspicefromcmd(tmpcircuits{n}); % Simula via CMD
end
% tmpcircuits=circuits;

% Clear empty simulated data
y=1;
for c=1:length(tmpcircuits)
    if isfield(tmpcircuits{c}.LTspice,'data')
        if(~tmpcircuits{c}.LTspice.data.error)
            if(quiz.tbjeval)
                tbj=tbj2quiz(tmpcircuits{c},quiz.tbjtype);
                %          if(tbj.ampmode)
                if(tbj.BetaDC>=tmpcircuits{c}.model.parvalue(2))
                    disp([num2str(tbj.BetaDC) '>=' num2str(tmpcircuits{c}.model.parvalue(2))])
                    circuits{y}=tmpcircuits{c};
                    y=y+1;
                end
            else
                circuits{y}=tmpcircuits{c};
                y=y+1;
            end            
        end
    else
        disp(['No data file in simulation ' num2str(c) ' with ' tmpcircuits{c}.parstr ' and ' tmpcircuits{c}.model.parstr '!'])
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

quiz.name = [circuit.name 'quiz'];
for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura modelstr
    circuits{n}.quiz.extratext{1}=['Parâmetros do TBJ: ' circuits{n}.model.parstr];
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

quizstruct = psimclozegen(circuits,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file

