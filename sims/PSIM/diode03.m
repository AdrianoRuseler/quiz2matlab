clear all
clc

% Sets simulation dir
quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\PSIM\'];

% Config simulation
circuit.parname={'Vi','Von','Vz1','Vz2','R1','R2','R3'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;','&Omega;','&Omega;'}; % Variables unit
circuit.PSIMCMD.name = 'diode03'; % File name
circuit.PSIMCMD.simsdir=quiz2matlabspdir; % PSIM file dir

% Simulation control settings
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?
circuit.PSIMCMD.totaltime=10E-005; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

circuit = getpsimnet(circuit); % Reads or generates net file from psim
circuit.PSIMCMD.net.run = 1;

%% parameters input
Vi=15:5:30; 
Von=0.5:0.05:0.7;
Vz1=[2.7 3.3 3.9 4.7 5.6  6.8  8.2];
Vz2=[ 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,[100],'E24'); %
R2 = combres(1,[100],'E24'); %
R3 = combres(1,[100],'E24'); %
Xi=CombVec(Vi,Von,Vz1,Vz2,R1,R2,R3); %%


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

quiz.name = 'diode03quiz';
quiz.enunciado = ['Para o circuito contendo diodos com tensão de polarização direta Von'...
    ' e diodos zener com tensão de polarização reversa Vz1 e Vz2 apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='Qual a corrente no resistor R1?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'IR1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='Qual a corrente no diodo zener Z1?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IZ1'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='Qual a corrente no diodo zener Z2?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'IZ2'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='Qual a corrente no resistor R2?';
quiz.question{4}.units={'A'};
quiz.question{4}.options={'IR2'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.type='NUMERICAL';

quiz.question{5}.str='Qual a corrente no resistor R3?';
quiz.question{5}.units={'A'};
quiz.question{5}.options={'IR3'};
quiz.question{5}.vartype={'mean'}; %
quiz.question{5}.optscore=[100]; % Score per option
quiz.question{5}.type='NUMERICAL';

% 
% quiz.question{4}.str='Qual a tensão no resistor R1 (Vx)?';
% quiz.question{4}.units={'V'};
% quiz.question{4}.options={'Vx'};
% quiz.question{4}.vartype={'mean'}; %
% quiz.question{4}.optscore=[100]; % Score per option
% quiz.question{4}.type='NUMERICAL';

%% 
pngfile=[quiz2matlabspdir '\diode03.png']; % Fig png file
imgout=[quiz2matlabspdir '\diode03clean.png']; % Fig png file
pngchangewhite(pngfile,imgout,'clean')

for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura
    circuits{n}.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig     
    circuits{n} = psimXmultichoice(circuits{n}); % Generate multichoice        
    circuits{n} = quiztextgen(circuits{n}); % Generates quiz text field    
end

%% Generate quizstruct moodle question
quizopts.name='diode03quiz';
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

