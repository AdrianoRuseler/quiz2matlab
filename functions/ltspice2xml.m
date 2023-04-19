

function ltspice2xml(circuit,quiz)

circuit.LTspice.name = circuit.name; % File name
circuit.LTspice.simsdir= circuit.dir; % sim file dir

circuit.LTspice.tmpfile = 1; % Create tmp file?
circuit.LTspice.tmpdir = 1; % Use system temp dir?
circuit.LTspice.tmpfiledel = 1; % Delete tmp files?
circuit.LTspice.ascfile = [circuit.LTspice.simsdir circuit.LTspice.name '.asc']; % Sim base file

circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file

% circuit.nsims=600; % Number of simulations
[~,y]=size(circuit.Xi);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.X=circuit.Xi(:,nq);

circuit.Xi=[]; % Clear

for c=1:length(circuit.X)
    tmpcircuits{c}=circuit;
    tmpcircuits{c}.parvalue=circuit.X(:,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
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
        circuits{y}=tmpcircuits{c};
        y=y+1;
    else
        disp(['No data file in simulation ' num2str(c) ' with ' tmpcircuits{c}.parstr '!'])
    end
end

pngfile=[circuit.dir circuit.name '.png']; % Fig png file
if isfield(circuit,'theme')
    imgout=[circuit.dir circuit.name circuit.theme '.png']; % Fig png file
    pngchangewhite(pngfile,imgout,circuit.theme)
else
    imgout=[circuit.dir circuit.name 'boost39.png']; % Fig png file
    pngchangewhite(pngfile,imgout,'boost39')
end

quiz.name = [circuit.name 'quiz'];
for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura
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

