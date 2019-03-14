clear all
clc

% Sets simulation dir
quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\PSIM'];

% Config simulation

circuit.parname={'Vi','R1','R2'}; % Variables names
circuit.parunit={' V','&Omega;','&Omega;'}; % Variables unit
circuit.PSIMCMD.name = 'quiztest'; % File name
circuit.PSIMCMD.simsdir=quiz2matlabspdir; % PSIM file dir
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?

% Simulation control settings
circuit.PSIMCMD.totaltime=10E-005; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

%% parameters input
Vi=5:5:30; 
R1 = combres(1,[100],'E12'); %
R2 = combres(1,[1000],'E12'); %
Xi=CombVec(Vi,R1,R2);

[~,y]=size(Xi);
sortnquestions=500;
nq=randperm(y,sortnquestions); % escolha as questoes
X=Xi(:,nq);

for c=1:length(X)
    tmpcircuits{c}=circuit;
    tmpcircuits{c}.parvalue=X(:,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c}.parvalue,tmpcircuits{c}.parname,tmpcircuits{c}.parunit);
end
%%   Runs simulation OK!
[~,y]=size(X);
parfor n=1:y
    tmpcircuits{n} = psimfromcmd(tmpcircuits{n}); % Simula via CMD
end
% tmpcircuits=circuits;
%% Clear empty simulated data
y=1;
for c=1:length(tmpcircuits)
    if isfield(tmpcircuits{c}.PSIMCMD,'data')
        circuits{y}=tmpcircuits{c};
        y=y+1;
    else
        disp(['No data file in simulation ' num2str(c) ' with ' tmpcircuits{c}.parstr '!'])
    end
end

%% Generate question

quiz.name = 'sometestquiz';
quiz.enunciado = 'Para o circuito divisor resistivo apresentado na Figura 1, determine:'; % Enunciado da pergunta!

quiz.question{1}.str='Qual a tensão em R1?';
quiz.question{1}.units={' V',' V',' V',' V',' V'};
quiz.question{1}.options={'opt1','opt2','opt3','opt4','opt5'}; % Variables from PSIM simulation
quiz.question{1}.optscore=[0 0 100 0 0]; % Score per option
quiz.question{1}.choicetype='MULTICHOICE_S';

% circuit.quiz.question{2}.choicestr

quiz.question{2}.str='Qual a tensão em R2?';
quiz.question{2}.units={' V',' V',' V',' V',' V'};
quiz.question{2}.options={'opt1','opt2','opt3','opt4','opt5'};
quiz.question{2}.optscore=[0 100 0 0 0]; % Score per option
quiz.question{2}.choicetype='MULTICHOICE_S';

quiz.question{3}.str='Qual a corrente na fonte?';
quiz.question{3}.units={'A','A','A','A','A','A'};
quiz.question{3}.options={'opt6','opt7','opt8','opt9','opt10','opt11'};
quiz.question{3}.optscore=[100 0 0 0 0 0]; % Score per option
quiz.question{3}.choicetype='MULTICHOICE_S';

%% 
pngfile=[quiz2matlabspdir '\quiztestfig.png']; % Fig png file
for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura
    circuits{n}.quiz.fightml = psimfigstr(pngfile,'left',figlegendastr); % html code for fig     
    circuits{n} = psimXmultichoice(circuits{n}); % Generate multichoice        
    circuits{n} = quiztextgen(circuits{n}); % Generates quiz text field    
end

%% Generate quizstruct moodle question
quizopts.name='quizstructtest';
quizopts.nquiz=250; % Number of quizes
quizopts.permutquiz =1; % Permut quiz?
quizopts.nquizperxml=500; % Number of quizes per file
quizopts.type = 'cloze';
quizopts.xmlpath = [ pwd '\xmlfiles']; % Folder for xml files
quizopts.generalfeedback='';
quizopts.penalty='0.25';
quizopts.hidden='0';

quizstruct = psimclozegen(circuits,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file

