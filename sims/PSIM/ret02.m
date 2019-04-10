clear all
clc

% Sets simulation dir
% quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR


% Config simulation
circuit.parname={'Vi','fi','Von','ron','C0','R0'}; % Variables names
circuit.parunit={' V',' Hz','V','&Omega;','F','&Omega;'}; % Variables unit

% Simulation setup 
circuit.name = 'ret01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Parameters setup

Vi=(15:5:30); 
fi=50:5:100;
Von=0.5:0.05:0.7;
ron = combres(1,1e-3,'E12');
R0 = combres(1,[10],'E12'); %
C0 = combcap(1,10e-6,'E12');

circuit.Xi=CombVec(Vi,fi,Von,ron,C0,R0); %%
circuit.fundfreqind=2; % 
circuit.cycles = 3; % Total number of cycles
circuit.printcycle = 2; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito retificador de meia onda com filtro capacitivo apresentado na Figura 1, determine:'; % Enunciado da pergunta!

quiz.question{1}.str='a) Qual a corrente media na carga (R0)?';
quiz.question{1}.units={'A'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.options={'I0'};
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual a tensão media na carga?';
quiz.question{2}.units={'V'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.options={'V0'};
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='c) Qual a corrente média no diodo?';
quiz.question{3}.units={'A'}; % 
quiz.question{3}.vartype={'mean'}; % Not implemented
quiz.question{3}.options={'ID1'}; % Variables from PSIM simulation
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='Qual a potência média na carga?';
quiz.question{4}.units={'W'}; % 
quiz.question{4}.vartype={'mean'}; % Not implemented
quiz.question{4}.options={'p0'}; % Variables from PSIM simulation
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';

quiz.question{5}.str='d) Qual a potência dissipada no diodo?';
quiz.question{5}.units={'W'}; % 
quiz.question{5}.vartype={'mean'}; % Not implemented
quiz.question{5}.options={'pd'}; % Variables from PSIM simulation
quiz.question{5}.optscore=[100]; % Score per option
quiz.question{5}.opttol=[10]; % tolerance in percentage %
quiz.question{5}.type='NUMERICAL';


%% Generate quizes

psimca2xml(circuit,quiz)

