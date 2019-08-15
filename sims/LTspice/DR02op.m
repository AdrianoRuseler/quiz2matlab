clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'DR02op'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% Config simulation
circuit.parnamesim={'Vcc','R1'}; % Variables names
circuit.parname={'Vcc','R1'}; % Variables names
circuit.parunit={'V','&Omega;'}; % Variables unit

% parameters input
Vcc=10:2.5:35; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,10,'E48'); %
% Rb = combres(1,[100],'E12'); %


circuit.Xi=CombVec(Vcc,R1); %%

% V(n001):	 25	 voltage
% V(vr1):	 24.2933	 voltage
% I(D1):	 0.0121467	 device_current
% I(R1):	 0.0121467	 device_current
% I(V1):	 -0.0121467	 device_current

% Generate question
quiz.enunciado = ['Utilize a diretiva .meas conforme indicado na Figura 1 e determine:' ]; % Enunciado da pergunta!

% quiz.question{1}.str='a) Qual a tensão no resistor R1?';
% quiz.question{1}.units={'V'};
% quiz.question{1}.options={'Vr1'};
% quiz.question{1}.vartype={'op'}; % meas 
% quiz.question{1}.optscore=[100]; % Score per option
% quiz.question{1}.opttol=[1]; % tolerance in percentage %
% quiz.question{1}.type='NUMERICAL';
% 
% quiz.question{2}.str='b) Qual a corrente no resistor R1?';
% quiz.question{2}.units={'A'};
% quiz.question{2}.options={'IR1'};
% quiz.question{2}.vartype={'op'}; %
% quiz.question{2}.optscore=[100]; % Score per option
% quiz.question{2}.opttol=[1]; % tolerance in percentage %
% quiz.question{2}.type='NUMERICAL';
% % 

quiz.question{1}.str='a) Qual a tensão sobre o diodo?';
quiz.question{1}.units={'V'};
quiz.question{1}.options={'vd'};
quiz.question{1}.vartype={'meas'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';
% % 
quiz.question{2}.str='b) Qual o valor da potência dissipada no diodo?';
quiz.question{2}.units={'W'};
quiz.question{2}.options={'pd'};
quiz.question{2}.vartype={'meas'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';


%% 
% circuit.nsims=525; % Number of simulations
% quiz.nquiz = 500; % Number of quizes
circuit.nsims=length(circuit.Xi);
quiz.nquiz = length(circuit.Xi);

ltspice2xml(circuit,quiz); % 



