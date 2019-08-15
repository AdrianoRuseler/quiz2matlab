clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'DR04op'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1','R2'}; % Variables names
circuit.parname={'Vcc','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=10:5:25; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,10,'E12'); %
R2 = combres(1,10,'E12'); %
% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,R1,R2); %%

% Generate question
quiz.enunciado = 'Utilize a diretiva .model conforme indicado na Figura 1 e determine:';

% Text a ser colocado abaixo da figura
quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
                    ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

% .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U 
% +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)
% 
% .MODEL LedGreen D (IS=93.2P RS=42M N=4.61 BV=4 IBV=10U CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)
% .MODEL LedBLUE D (IS=93.2P RS=42M N=7.47 BV=5 IBV=10U CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=5 type=LED)
% .model LedWHITE D(Is=0.27n Rs=5.65 N=6.79 Cjo=42p Iave=30m Vpk=5 type=LED)

% vled: v(d1)-v(r2)=1.66812
% pled: vled*i(d2)=0.00501452
% pz: -i(d1)*v(d1)=0.0575849

% V(v1):	 20	 voltage
% V(d1):	 4.67421	 voltage
% V(r2):	 3.00609	 voltage
% I(D1):	 -0.0123197	 device_current
% I(D2):	 0.00300609	 device_current
% I(R2):	 0.00300609	 device_current
% I(R1):	 -0.0153258	 device_current
% I(V1):	 -0.0153258	 device_current


quiz.question{1}.str='a) Qual a corrente no diodo LED?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'ID2'};
quiz.question{1}.vartype={'op'}; % meas 
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual a corrente no diodo Zener?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'ID1'};
quiz.question{2}.vartype={'op'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';
% 
quiz.question{3}.str='c) Qual o valor da potência dissipada no diodo LED?';
quiz.question{3}.units={'W'};
quiz.question{3}.options={'pled'};
quiz.question{3}.vartype={'meas'}; %
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';
% % 
quiz.question{4}.str='d) Qual o valor da potência dissipada no diodo Zener?';
quiz.question{4}.units={'W'};
quiz.question{4}.options={'pz'};
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



