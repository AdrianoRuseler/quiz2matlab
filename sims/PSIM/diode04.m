clear all
clc

% Sets simulation dir
circuit.dir='E:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
circuit.name = 'diode04'; % File name
circuit.parname={'Ii','Von','Vz','Vled','R1'}; % Variables names
circuit.parnamesim={'Ii','Von','Vz','Vled','R1'}; % Variables names
circuit.parunit={'A','V','V','V','&Omega;'}; % Variables unit


% parameters input
Ii=(15:5:30)*1e-3; 
Von=0.5:0.05:0.7;
Vled=1:0.05:2;
Vz=[2.7 3.3 3.9 4.7 5.6  6.8  8.2];
% Vz2=[ 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,[10],'E24'); %
% R2 = combres(1,[100],'E24'); %
% R3 = combres(1,[100],'E24'); %


circuit.Xi=CombVec(Ii,Von,Vz,Vled,R1); %%
circuit.nsims =250;

% Generate question
quiz.enunciado = ['Para o circuito contendo um diodo LED com tensão de polarização direta Vled'...
    ' e um diodo zener com tensão de polarização reversa Vz apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='a) Qual a corrente no resistor R1?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'IR1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual a corrente no diodo zener Z1?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IZ1'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='c) Qual a tensão no diodo zener (Vx)?';
quiz.question{3}.units={'V'};
quiz.question{3}.options={'Vx'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';


quiz.question{4}.str='d) Qual a potência dissipada no diodo zener?';
quiz.question{4}.units={'W'};
quiz.question{4}.options={'Pz'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';


%% Generates questions

psimdc2xml(circuit,quiz);

