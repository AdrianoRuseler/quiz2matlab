clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'netfiletest'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% Config simulation
circuit.parname={'Vi','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

circuit.parvalue=[10 1e3 1e3]; % Variables values
circuit.parstr = param2str(circuit);

circuit.LTspice.name = 'netfiletest'; % File name
circuit.LTspice.simsdir=circuit.dir; % PSIM file dir

circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file


%% circuit.LTspice.type='op'; % tran, ac, dc, noise, tf, op 

circuit.LTspice.tmpfile=1; % Create tmp file?
circuit.LTspice.tmpdir=1; % Use system temp dir?
circuit.LTspice.tmpfiledel=1; % Delete tmp files?


circuit = ltspicefromcmd(circuit); % run LTspice simulation
% circuit = ltlogread(circuit);

% circuit.LTspice.net.lines
% circuit.LTspice.log.lines

% data = LTspiceASCII2Matlab(circuit.LTspice.raw.file,1);



















%% Generate question

circuit.quiz.name = 'sometestquiz';
circuit.quiz.enunciado = 'Para o circuito divisor resistivo apresentado na Figura 1, determine:'; % Enunciado da pergunta!
pngfile=[quiz2matlabspdir '\quiztestfig.png']; % Fig png file
figlegendastr=['Figura 1: Considere ' circuit.parstr ';']; % Legenda da figura
circuit.quiz.fightml = psimfigstr(pngfile,'left',figlegendastr); % html code for fig


circuit.quiz.question{1}.str='Qual a tens�o em R1?';
circuit.quiz.question{1}.units={' V',' V',' V',' V',' V'};
circuit.quiz.question{1}.options={'opt1','opt2','opt3','opt4','opt5'}; % Variables from PSIM simulation
circuit.quiz.question{1}.optscore=[0 0 100 0 0]; % Score per option
circuit.quiz.question{1}.choicetype='MULTICHOICE_S';

% circuit.quiz.question{2}.choicestr


circuit.quiz.question{2}.str='Qual a tens�o em R2?';
circuit.quiz.question{2}.units={' V',' V',' V',' V',' V'};
circuit.quiz.question{2}.options={'opt1','opt2','opt3','opt4','opt5'};
circuit.quiz.question{2}.optscore=[0 100 0 0 0]; % Score per option
circuit.quiz.question{2}.choicetype='MULTICHOICE_S';

circuit.quiz.question{3}.str='Qual a corrente na fonte?';
circuit.quiz.question{3}.units={'A','A','A','A','A','A'};
circuit.quiz.question{3}.options={'opt6','opt7','opt8','opt9','opt10','opt11'};
circuit.quiz.question{3}.optscore=[100 0 0 0 0 0]; % Score per option
circuit.quiz.question{3}.choicetype='MULTICHOICE_S';

circuit = psimXmultichoice(circuit); % Generate multichoice


circuit = quiztextgen(circuit); % Generates quiz text field


circuits{1}=circuit; % Circuits array (multiple quizes)
% circuits{2}=circuit; % Circuits array (multiple quizes)
% circuits{3}=circuit; % Circuits array (multiple quizes)

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


% quizstruct 

%% simview
% A:\Dropbox\GitHub\quiz2matlab\sims\PSIM
% FileName = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.ini']; % Sim base file

% Result = ini2struct(circuit.PSIMCMD.inifile)
circuit = simview2matlab(circuit); % Importa dados do simview
circuit = simview2data(circuit); % Gera dados para o plot
status = simview2plot(circuit); % Plots simview


