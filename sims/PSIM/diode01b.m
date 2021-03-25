
% addpath('C:\Users\adria\Dropbox\GitHub\quiz2matlab\functions') % Note
% addpath('C:\Users\adria\Dropbox\GitHub\quiz2matlab\questions') % Note
% savepath % Save search path

%%
clear all
clc

% Sets simulation dir
circuit.dir='E:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% Config simulation
circuit.name = 'diode01'; % File name
circuit.parname={'Vi','Von1','Von2','Von3','R1'}; % Variables names
circuit.parnamesim={'Vi','Von1','Von2','Von3','R1'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;'}; % Variables unit


% parameters input
Vi=10:5:30; 
Von1=0.4:0.05:0.8;
Von2=0.4:0.05:0.8;
Von3=1:0.1:2;
R1 = combres(1,[10 100],'E12'); %

circuit.Xi=CombVec(Vi,Von1,Von2,Von3,R1);
circuit.nsims =250;
% Generate question


quiz.enunciado = 'Para o circuito apresentado na Figura 1, determine:'; % Enunciado da pergunta!

quiz.question{1}.str='Qual o valor médio da corrente no diodo D1?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'ID1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='Qual o valor médio da corrente no diodo D2?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'ID2'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='Qual o valor médio da corrente no LED?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'ILED1'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='Qual o valor médio da tensão no resistor R1?';
quiz.question{4}.units={'V'};
quiz.question{4}.options={'VR1'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';

%%  Generates questions

psimdc2xml(circuit,quiz);


