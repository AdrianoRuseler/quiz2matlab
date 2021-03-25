clear all
clc

% Sets simulation dir
circuit.dir='E:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
circuit.name = 'diode03'; % File name
circuit.parname={'Vi','Von','Vz1','Vz2','R1','R2','R3'}; % Variables names
circuit.parnamesim={'Vi','Von','Vz1','Vz2','R1','R2','R3'}; % Variables names
circuit.parunit={'V','V','V','V','&Omega;','&Omega;','&Omega;'}; % Variables unit


% parameters input
Vi=15:5:30; 
Von=0.5:0.05:0.7;
Vz2=[2.7 3.3 3.9 4.7 5.6  6.8  8.2];
Vz1=[ 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,[10],'E12'); %
R2 = combres(1,[10],'E12'); %
R3 = combres(1,[10],'E12'); %

circuit.Xi=CombVec(Vi,Von,Vz1,Vz2,R1,R2,R3); %%
circuit.nsims =250;

% Generate question

quiz.enunciado = ['Para o circuito contendo diodos com tensão de polarização direta Von'...
    ' e diodos zener com tensão de polarização reversa Vz1 e Vz2 apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='a) Qual o valor da corrente média no resistor R1?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'IR1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual o valor da corrente média no diodo zener Z1?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IZ1'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='c) Qual o valor da corrente média no diodo zener Z2?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'IZ2'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='d) Qual o valor da corrente média no resistor R2?';
quiz.question{4}.units={'A'};
quiz.question{4}.options={'IR2'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';

quiz.question{5}.str='e) Qual o valor da corrente média no resistor R3?';
quiz.question{5}.units={'A'};
quiz.question{5}.options={'IR3'};
quiz.question{5}.vartype={'mean'}; %
quiz.question{5}.optscore=[100]; % Score per option
quiz.question{5}.opttol=[10]; % tolerance in percentage %
quiz.question{5}.type='NUMERICAL';


%% Generates questions
psimdc2xml(circuit,quiz);

