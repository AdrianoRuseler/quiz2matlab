clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'netfiletest'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% Config simulation
circuit.parnamesim={'Vi','R1','R2'}; % Variables names
circuit.parname={'Vi','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=10:5:40; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Ra = combres(1,[100],'E12'); %
Rb = combres(1,[100],'E12'); %


circuit.Xi=CombVec(Vcc,Ra,Rb); %%

% Generate question
quiz.enunciado = ['Para o circuito apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='a) Vn002?';
quiz.question{1}.units={'V'};
quiz.question{1}.options={'Vn002'};
quiz.question{1}.vartype={'op'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Vn001?';
quiz.question{2}.units={'V'};
quiz.question{2}.options={'Vn001'};
quiz.question{2}.vartype={'op'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';
% % 
quiz.question{3}.str='c) IR2?';
quiz.question{3}.units={'A'};
quiz.question{3}.options={'IR2'};
quiz.question{3}.vartype={'op'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';
% % % 
% quiz.question{4}.str='d) Qual o valor da tensão no emissor do transistor PNP?';
% quiz.question{4}.units={'V'};
% quiz.question{4}.options={'Ve'};
% quiz.question{4}.vartype={'mean'}; %
% quiz.question{4}.optscore=[100]; % Score per option
% quiz.question{4}.opttol=[10]; % tolerance in percentage %
% quiz.question{4}.type='NUMERICAL';


%% 
circuit.nsims=5; % Number of simulations
quiz.nquiz = 5; % Number of quizes
ltspice2xml(circuit,quiz); 



