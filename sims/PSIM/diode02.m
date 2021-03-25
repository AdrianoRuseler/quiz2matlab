clear all
clc

% Sets simulation dir
circuit.dir='E:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR
% circuit.dir='C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Note

% Config simulation
circuit.name = 'diode02'; % File name

circuit.parname={'Vi','Von','Vz','R1','R2'}; % Variables names
circuit.parnamesim={'Vi','Von','Vz','R1','R2'}; % Variables names
circuit.parunit={'V','V','V','&Omega;','&Omega;'}; % Variables unit


% parameters input
Vi=15:5:30; 
Von=0.4:0.05:0.8;
Vz=[2.7 3.0 3.3 3.6 3.9 4.3 4.7 5.1 5.6 6.2 6.8 7.5 8.2 9.1];
R1 = combres(1,[10],'E24'); %
R2 = combres(1,[10],'E24'); %
% R3 = combres(1,[100],'E24'); %
circuit.Xi=CombVec(Vi,Von,Vz,R1,R2); %%
circuit.nsims =250;

% Generate question

quiz.enunciado = ['Para o circuito contendo diodos com tensão de polarização direta Von'...
    ' e um zener com tensão de polarização reversa Vz apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='Qual a corrente no resistor R1?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'IR1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='Qual a corrente no diodo zener Z1?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IZ1'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='Qual a corrente no resistor R2?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'IR2'};
quiz.question{3}.vartype={'mean'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='Qual a tensão sobre o resistor R2 (Vx)?';
quiz.question{4}.units={'V'};
quiz.question{4}.options={'Vx'};
quiz.question{4}.vartype={'mean'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';

%% 

psimdc2xml(circuit,quiz);
