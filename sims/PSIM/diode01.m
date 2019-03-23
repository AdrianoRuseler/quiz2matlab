clear all
clc

% Sets simulation dir
quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\PSIM\'];

% Config simulation

circuit.parname={'Vi','Von1','Von2','Von3','R1'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;'}; % Variables unit
circuit.PSIMCMD.name = 'diode01'; % File name
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

circuit = getpsimnet(circuit); % Reads or generates net file from psim
circuit.PSIMCMD.net.run = 1;

%% parameters input
Vi=10:5:30; 
Von1=0.4:0.05:0.8;
Von2=0.4:0.05:0.8;
Von3=1:0.1:2;
R1 = combres(1,[10 100],'E24'); %

Xi=CombVec(Vi,Von1,Von2,Von3,R1);

[~,y]=size(Xi);
sortnquestions=500;
nq=randperm(y,sortnquestions); % escolha as questoes
X=Xi(:,nq);

for c=1:length(X)
    tmpcircuits{c}=circuit;
    tmpcircuits{c}.parvalue=X(:,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
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

quiz.name = 'diode01quiz';
quiz.enunciado = 'Para o circuito apresentado na Figura 1, determine:'; % Enunciado da pergunta!

quiz.question{1}.str='Qual a corrente no diodo D1?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'ID1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='Qual a corrente no diodo D2?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'ID2'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='Qual a corrente no LED?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'ILED1'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='Qual a tensão no resistor R1?';
quiz.question{4}.units={'V'};
quiz.question{4}.options={'VR1'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.type='NUMERICAL';

%% 
pngfile=[quiz2matlabspdir '\diode01.png']; % Fig png file
imgout=[quiz2matlabspdir '\diode01clean.png']; % Fig png file
pngchangewhite(pngfile,imgout,'clean')

for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura
    circuits{n}.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig     
    circuits{n} = psimXmultichoice(circuits{n}); % Generate multichoice        
    circuits{n} = quiztextgen(circuits{n}); % Generates quiz text field    
end

%% Generate quizstruct moodle question
quizopts.name='diode01quiz';
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

