clc
clear all

% Sets simulation dir
quiz2matlabdir='C:\Users\Ruseler\Documents\GitHub\quiz2matlab'; % Home
% quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\PSIM\'];

circuit.name = 'plottest2'; % File name 

% Config simulation
circuit.parname={'Vi','fi','R1','R2'}; % Variables names
circuit.parnamesim={'Vi','fi','R1','R2'}; % Variables names
circuit.parunit={' V',' Hz','&Omega;','&Omega;'}; % Variables unit

circuit.parvalue=[10 100 1e3 1e3]; % Variables values
circuit.PSIMCMD.name = circuit.name; % File name 
circuit.PSIMCMD.simsdir=quiz2matlabspdir; % PSIM file dir
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?
circuit.PSIMCMD.net.run = 0;
% circuit = getpsimnet(circuit); % Reads or generates net file from psim

circuit.nsims =1; % Numero de circuitos a serem simulados

% circuit.nsims =100; % Numero de circuitos a serem simulados
circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print
circuit.PSIMCMD.script.run=1;
   

% Simulação 
% circuit.PSIMCMD.totaltime=0.01; % Total simulation time, in sec.
circuit.PSIMCMD.totaltime=circuit.cycles/circuit.parvalue(circuit.fundfreqind); % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
% circuit.PSIMCMD.printtime=0; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printtime=(circuit.printcycle-1)/circuit.parvalue(circuit.fundfreqind);
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

% Runs simulation
circuit = psimfromcmd(circuit); % Simula via CMD

%% Generate quiz

% Generate question
quiz.enunciado = 'Para o circuito retificador trifásico ponte de Graetz com carga RLE apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 
quiz.scriptfile=1; % Add link to script file

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor médio da tensão na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'vR2'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

p=1;
quiz.plot{p}.legend='Figura 2: Formas de onda provenientes da simulação do circuito apresentado na Figura 1.';
quiz.plot{p}.curves={'opt1','opt2','opt3','opt4'};
% quiz.plot{p}.curleg={'opt1','opt2','opt3','opt4'};
% quiz.plot{p}.yyaxis={'right','left','left','left'};
quiz.plot{p}.scale=0.6; % Plot scale
quiz.plot{p}.FontSize=7; % Plot FontSize
% quiz.plot{p}.LineStyle={'-','--',':','-.'};
quiz.plot{p}.LineWidth=1.5;
% quiz.plot{p}.title='title';
% quiz.plot{p}.xlabel='xlabel';
quiz.plot{p}.ylabel='Amplitude';

p=2;
quiz.plot{p}.legend='Figura 3: Formas de onda provenientes da simulação do circuito apresentado na Figura 1.';
quiz.plot{p}.curves={'opt1'};
% quiz.plot{p}.curleg={'opt2','opt3','opt4'};
% quiz.plot{p}.yyaxis={'right','left','left','left'};
% quiz.plot{p}.LineWidth=1.5;
% quiz.plot{p}.scale=0.6; % Plot scale
% quiz.plot{p}.FontSize=7; % Plot FontSize
% quiz.plot{p}.title='title';
% quiz.plot{p}.xlabel='xlabel';
% quiz.plot{p}.ylabel='ylabel';
quiz.plot{p}.ylabel='Amplitude';

quiz.nquiz=1;
quiz.name = [circuit.name];
circuit.quiz=quiz;
circuit = psimXmultichoice(circuit); % Generate multichoice

% Create new function
pngfile=[pwd '\' circuit.name '.png']; % Fig png file
imgout=png2mdl(pngfile,'classic');

circuit.parstr = param2str(circuit);
figlegendastr=['Figura 1: Considere ' circuit.parstr ';']; % Legenda da figura
circuit.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig

circuit = psimplothtml(circuit);

circuit.quiz.modelfile=0;
circuit = quiztextgen(circuit); % Generates quiz text field

%% Generate quizstruct moodle question
quizopts.name=[circuit.name 'quiz'];
quizopts.nquiz=quiz.nquiz; % Number of quizes
quizopts.permutquiz =0; % Permut quiz?
quizopts.nquizperxml=500; % Number of quizes per file
quizopts.type = 'cloze';
quizopts.xmlpath = [ pwd '\xmlfiles']; % Folder for xml files
quizopts.generalfeedback='';
quizopts.penalty='0.25';
quizopts.hidden='0';

quizstruct = psimclozegen(circuit,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file


%% 
% A:\Dropbox\GitHub\quiz2matlab\sims\PSIM
% FileName = [circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '.ini']; % Sim base file

% Result = ini2struct(circuit.PSIMCMD.inifile)
% circuit = simview2matlab(circuit); % Importa dados do simview
% circuit = simview2data(circuit); % Gera dados para o plot
% status = simview2plot(circuit); % Plots simview

        
        