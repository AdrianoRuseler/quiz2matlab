clear all
clc

% Sets simulation dir
circuit.dir='E:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
circuit.name = 'diode05'; % File name
circuit.parname={'Vi','Von1','ron1','Von2','ron2','R0'}; % Variables names
circuit.parnamesim={'Vi','Von1','ron1','Von2','ron2','R0'}; % Variables names
circuit.parunit={'V','V','&Omega;','V','&Omega;','&Omega;'}; % Variables unit


% parameters input
Vi=(15:5:30); 
Von1=0.5:0.05:0.9;
Von2=0.5:0.05:0.9;
% Vz=[2.7 3.3 3.9 4.7 5.6  6.8  8.2];
% Vz2=[ 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R0 = combres(1,[100],'E12'); %
ron1 = combres(1,0.001,'E12'); %
ron2 = combres(1,0.001,'E12'); %

circuit.Xi=CombVec(Vi,Von1,ron1,Von2,ron2,R0); %%
circuit.nsims =250;

% Generate question
quiz.enunciado = ['Para o circuito contendo dois diodos com tensão de polarização direta Von1 e Von2'...
    ' e resistência ron1 e ron2 apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='a) Qual a corrente no resistor R0?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'IR0'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual a corrente no diodo D1?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'ID1'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='c) Qual a corrente no diodo D2?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'ID2'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';

% 
quiz.question{4}.str='d) Qual a tensão sobre os diodos?';
quiz.question{4}.units={'V'};
quiz.question{4}.options={'Vd'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';


%% Generates questions

psimdc2xml(circuit,quiz);

