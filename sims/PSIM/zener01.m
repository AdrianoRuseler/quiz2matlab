clear all
clc

% Sets simulation dir
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
% circuit.name = 'zener01'; % File name
circuit.parname={'Vi','Vz','R1','R2'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;'}; % Variables unit

% Simulation setup 
circuit.name = 'zener01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% parameters input
Vi=15:5:30; 
Vz=[2.7 3.3 3.9 4.7 5.6  6.8  8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,[100],'E24'); %
R2 = combres(1,[100],'E24'); %


circuit.Xi=CombVec(Vi,Vz,R1,R2); %%


% Generate question

quiz.enunciado = ['Para o circuito contendo um diodo zener com tensão zener Vz apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='a) Qual o valor da tensão média no resistor R2 (Vx)?';
quiz.question{1}.units={'V'};
quiz.question{1}.options={'Vx'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual o valor da corrente média no diodo zener?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IZ1'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

quiz.question{3}.str='c) Qual o valor da potência média dissipada no diodo zener?';
quiz.question{3}.units={'W'};
quiz.question{3}.options={'Pz'};
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

quiz.question{5}.str='e) Qual o valor da corrente média no resistor R1?';
quiz.question{5}.units={'A'};
quiz.question{5}.options={'IR1'};
quiz.question{5}.vartype={'mean'}; %
quiz.question{5}.optscore=[100]; % Score per option
quiz.question{5}.opttol=[10]; % tolerance in percentage %
quiz.question{5}.type='NUMERICAL';


%% Generates questions
psimdc2xml(circuit,quiz); 

