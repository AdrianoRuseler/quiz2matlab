clear all
clc

% Config simulation
circuit.parname={'Vi','Vz1','Vz2','R1','R2','R3'}; % Variables names
circuit.parunit={'V','V','V','&Omega;','&Omega;','&Omega;'}; % Variables unit

circuit.name = 'zener02'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% parameters input
Vi=15:5:30; 
Vz1=[2.7 3.3 3.9 4.7 5.6  6.8 8.2];
Vz2=[3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,[100],'E12'); %
R2 = combres(1,[100],'E12'); %
R3 = combres(1,[100],'E12'); %

circuit.Xi=CombVec(Vi,Vz1,Vz2,R1,R2,R3); %%


% Generate question

quiz.enunciado = ['Para o circuito contendo dois diodos zener com tensão zener Vz1 e Vz2 conforme apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

% quiz.question{1}.str='a) Qual o valor da tensão média no resistor R2 (Vx)?';
% quiz.question{1}.units={'V'};
% quiz.question{1}.options={'Vx'};
% quiz.question{1}.vartype={'mean'}; %
% quiz.question{1}.optscore=[100]; % Score per option
% quiz.question{1}.opttol=[10]; % tolerance in percentage %
% quiz.question{1}.type='NUMERICAL';
% 
% quiz.question{2}.str='b) Qual o valor da corrente média no diodo zener?';
% quiz.question{2}.units={'A'};
% quiz.question{2}.options={'IZ1'};
% quiz.question{2}.vartype={'mean'}; %
% quiz.question{2}.optscore=[100]; % Score per option
% quiz.question{2}.opttol=[10]; % tolerance in percentage %
% quiz.question{2}.type='NUMERICAL';

quiz.question{1}.str='a) Qual o valor da potência média dissipada no diodo zener Z1?';
quiz.question{1}.units={'W'};
quiz.question{1}.options={'Pz1'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual o valor da potência média dissipada no diodo zener Z2?';
quiz.question{2}.units={'W'};
quiz.question{2}.options={'Pz2'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

% quiz.question{4}.str='d) Qual o valor da corrente média no resistor R2?';
% quiz.question{4}.units={'A'};
% quiz.question{4}.options={'IR2'};
% quiz.question{4}.vartype={'mean'}; %
% quiz.question{4}.optscore=[100]; % Score per option
% quiz.question{4}.opttol=[10]; % tolerance in percentage %
% quiz.question{4}.type='NUMERICAL';
% 
% quiz.question{5}.str='e) Qual o valor da corrente média no resistor R1?';
% quiz.question{5}.units={'A'};
% quiz.question{5}.options={'IR1'};
% quiz.question{5}.vartype={'mean'}; %
% quiz.question{5}.optscore=[100]; % Score per option
% quiz.question{5}.opttol=[10]; % tolerance in percentage %
% quiz.question{5}.type='NUMERICAL';


%% Generates questions
psimdc2xml(circuit,quiz);

