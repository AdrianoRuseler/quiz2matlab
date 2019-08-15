clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'DR03op'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% Config simulation
circuit.parnamesim={'Vcc','R1'}; % Variables names
circuit.parname={'Vcc','R1'}; % Variables names
circuit.parunit={'V','&Omega;'}; % Variables unit

% parameters input

Vcc=5:2.5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
% R1 = combres(1,10,'E48'); %
% Rb = combres(1,[100],'E12'); %
R1 = combres(1,[10 100],'E24'); % 36 resistores

circuit.Xi=CombVec(Vcc,R1); %%

% V(n001):	 25	 voltage
% V(vr1):	 24.2933	 voltage
% I(D1):	 0.0121467	 device_current
% I(R1):	 0.0121467	 device_current
% I(V1):	 -0.0121467	 device_current

% Generate question
quiz.enunciado = 'Utilize a diretiva .model conforme indicado na Figura 1 e determine:';

% Text a ser colocado abaixo da figura
quiz.extratext{1} = [' .model 1N4007 D(IS=7.02767n RS=0.0341512 N=1.80803 EG=1.05743 XTI=5 <br>' ...
                    '        +BV=1000 IBV=5e-08 CJO=1e-11 VJ=0.7 M=0.5 FC=0.5 TT=1e-07)']; % modelo do diodo

quiz.question{1}.str='a) Qual a tensão no resistor R1?';
quiz.question{1}.units={'V'};
quiz.question{1}.options={'Vr1'};
quiz.question{1}.vartype={'op'}; % meas 
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual a corrente no resistor R1?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IR1'};
quiz.question{2}.vartype={'op'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';
% 
quiz.question{3}.str='c) Qual a tensão sobre o diodo?';
quiz.question{3}.units={'V'};
quiz.question{3}.options={'vd'};
quiz.question{3}.vartype={'meas'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';
% % 
quiz.question{4}.str='d) Qual o valor da potência dissipada no diodo?';
quiz.question{4}.units={'W'};
quiz.question{4}.options={'pd'};
quiz.question{4}.vartype={'meas'}; %
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';


%% 
% circuit.nsims=255; % Number of simulations
% quiz.nquiz = 250; % Number of quizes
circuit.nsims=length(circuit.Xi);
quiz.nquiz = length(circuit.Xi);

ltspice2xml(circuit,quiz); % 



