clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'DR01tran'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% Config simulation
circuit.parnamesim={'Vpk','freq','R1'}; % Variables names
circuit.parname={'Vpk','freq','R1'}; % Variables names
circuit.parunit={'V','Hz','&Omega;'}; % Variables unit

% parameters input
Vcc=10:1:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,10,'E24'); %
% Rb = combres(1,[100],'E12'); %
freq=60;

circuit.Xi=CombVec(Vcc,freq,R1); %%

circuit.cmdtype='.tran';
circuit.cmdvarind=2;
% .tran Tprint Tstop Tstart

% V(n001):	 25	 voltage
% V(vr1):	 24.2933	 voltage
% I(D1):	 0.0121467	 device_current
% I(R1):	 0.0121467	 device_current
% I(V1):	 -0.0121467	 device_current

% Generate question
quiz.enunciado = ['Altere os parâmetros do circuito (.param Vpk=?? freq=?? R1=??) e (.tran 0 ?? 0) conforme apresentado na Figura 1 e determine:' ]; % Enunciado da pergunta!
% Text a ser colocado abaixo da figura
quiz.extratext{1} = '.meas Pout AVG V(R1)*I(R1)<br>.meas V1rms RMS V(V1)<br>.meas I1rms RMS I(V1)<br>.meas Sin param V1rms*I1rms<br>.meas Pin AVG -V(V1)*I(V1)<br>.meas Pf param Pin/Sin';

quiz.question{1}.str='a) Qual a potência ativa no resistor R1?';
quiz.question{1}.units={'W'};
quiz.question{1}.options={'pout'};
quiz.question{1}.vartype={'meas'}; % meas 
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';
% 
quiz.question{2}.str='b) Qual a potência aparente de entrada?';
quiz.question{2}.units={'VA'};
quiz.question{2}.options={'sin'};
quiz.question{2}.vartype={'meas'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';
% 
quiz.question{3}.str='c) Qual a potência ativa de entrada?';
quiz.question{3}.units={'W'};
quiz.question{3}.options={'pin'};
quiz.question{3}.vartype={'meas'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';
% % 
quiz.question{4}.str='d) Qual o fator de potência?';
quiz.question{4}.units={'W/VA'};
quiz.question{4}.options={'pf'};
quiz.question{4}.vartype={'meas'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';


%% 
% circuit.nsims=252; % Number of simulations
% quiz.nquiz = 250; % Number of quizes

circuit.nsims=length(circuit.Xi);
quiz.nquiz = length(circuit.Xi);
ltspice2xml(circuit,quiz); % 



