clear all
clc

% Sets simulation dir
% quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\PSIM\'];
% Config simulation
circuit.parname={'Vi','fi','Von','ron','R0'}; % Variables names
circuit.parunit={' V',' Hz','V','&Omega;','&Omega;'}; % Variables unit

% Simulation setup 
circuit.PSIMCMD.name = 'ret01'; % File name
circuit.PSIMCMD.simsdir=quiz2matlabspdir; % PSIM file dir
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=0; % Delete tmp files?
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; % No output is saved before this time. 
circuit.PSIMCMD.printstep=1; % Print step (default = 1).  

circuit.PSIMCMD.net.run = 1; % run simulation fron netlist file?
circuit = getpsimnet(circuit); % Generates net file from psim


%% Parameters setup

circuit.parvalue=[10 150 0 0 1500]; % Variables values
nper=1; % Number of periods
circuit.PSIMCMD.totaltime=nper/circuit.parvalue(2); % Total simulation time, in sec.


% Runs simulation
circuit = psimfromcmd(circuit); % Simula via CMD

%% Generate question

circuit.quiz.name = 'ret01testquiz';
circuit.quiz.enunciado = 'Para o circuito retificador de meia onda apresentado na Figura 1, determine:'; % Enunciado da pergunta!
pngfile=[quiz2matlabspdir '\ret01quiztest.png']; % Fig png file
circuit.parstr = param2str(circuit);
figlegendastr=['Figura 1: Considere ' circuit.parstr ';']; % Legenda da figura
circuit.quiz.fightml = psimfigstr(pngfile,'left',figlegendastr); % html code for fig

circuit.quiz.question{1}.str='Qual a potência ativa na carga?';
circuit.quiz.question{1}.units={'W'}; % 
circuit.quiz.question{1}.vartype={'mean'}; % Not implemented
circuit.quiz.question{1}.options={'p0'}; % Variables from PSIM simulation
circuit.quiz.question{1}.optscore=[100]; % Score per option
circuit.quiz.question{1}.opttol=[10]; % tolerance in percentage %
circuit.quiz.question{1}.type='NUMERICAL';

circuit.quiz.question{2}.str='Qual a potência ativa na carga?';
circuit.quiz.question{2}.units={'W'}; % 
circuit.quiz.question{2}.vartype={'mean'}; % Not implemented
circuit.quiz.question{2}.options={'p0'}; % Variables from PSIM simulation
circuit.quiz.question{2}.optscore=[100]; % Score per option
circuit.quiz.question{2}.opttol=[10]; % tolerance in percentage %
circuit.quiz.question{2}.type='NUMERICAL';


circuit.quiz.question{3}.str='Qual a corrente na fonte?';
circuit.quiz.question{3}.units={'A','V','V','W'};
circuit.quiz.question{3}.vartype={'mean','mean','rms','mean'}; % Not implemented
circuit.quiz.question{3}.options={'I0','V0','Vi','p0'};
circuit.quiz.question{3}.optscore=[100 0 0 0]; % Score per option
circuit.quiz.question{3}.type='MULTICHOICE_S';


circuit = psimXmultichoice(circuit); % Generate multichoice
circuit = quiztextgen(circuit); % Generates quiz text field


circuits{1}=circuit; % Circuits array (multiple quizes)


%% Generate quizstruct moodle question

quizopts.name='ret01quizstructtest';
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




%% Simview

circuit = simview2matlab(circuit); % Importa dados do simview
circuit = simview2data(circuit); % Gera dados para o plot
circuit = simview2plot(circuit); % Plots simview


%% teste

% 
% [str, numstr, expstr, mantissa, exponent] = real2eng(16.568974e-6,'A');
% str=real2eng(16.568974e-6,'A');


