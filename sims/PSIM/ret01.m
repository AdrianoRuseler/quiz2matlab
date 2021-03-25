clear all
clc

% Sets simulation dir
% quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% circuit.dir='E:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR


% Config simulation
circuit.parname={'Virms','fi','Von','ron','R0'}; % Variables names utilizados no enunciado
circuit.parunit={' V',' Hz','V','&Omega;','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fi','Von','ron','R0'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'ret01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Parameters setup
Vi=(100:25:250); 
fi=50:5:100;
Von=0.5:0.05:0.7;
ron = combres(1,1e-3,'E24');
R0 = combres(1,[0.1],'E24'); %

circuit.Xi=CombVec(Vi,fi,Von,ron,R0); %%
circuit.nsims =100;
circuit.fundfreqind=2; % 
circuit.cycles = 5; % Total number of cycles
circuit.printcycle = 4; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito retificador de meia onda apresentado na Figura 1, determine:'; % Enunciado da pergunta!

q=1;
quiz.question{q}.str='a) Qual a tensão media na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=2;
quiz.question{q}.str='b) Qual a corrente media na carga?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'I0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=3;
quiz.question{q}.str='c) Qual o valor eficaz da tensão na carga?';
quiz.question{q}.units={'V'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'v0rms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=4;
quiz.question{q}.str='d) Qual o valor eficaz da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'i0rms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=5;
quiz.question{q}.str='e) Qual a potência ativa na carga?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=6;
quiz.question{q}.str='f) Qual a potência aparente na fonte?';
quiz.question{q}.units={'VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'Si'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=7;
quiz.question{q}.str='g) Qual a potência dissipada no diodo?';
quiz.question{q}.units={'W'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'pd'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=8;
quiz.question{q}.str='h) Qual o fator de potência?';
quiz.question{q}.units={'W/VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=9;
% quiz.question{q}.str='i) Qual a taxa de distorção harmônica da corrente?';
% quiz.question{q}.units={'A/A'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=9;
quiz.question{q}.str='j) Qual o valor eficaz da componente fundamental da corrente na fonte?';
quiz.question{q}.units={'A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'ifrms'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';





%% Generate quizes

psimca2xml(circuit,quiz)

