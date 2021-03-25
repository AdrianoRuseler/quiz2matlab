clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ04CA'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Rb','Ra','Cx'}; % Variables names
circuit.parname={'Vcc','Rb','Ra','Cx'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','F'}; % Variables unit

% parameters input
Vcc=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
% R1 = combres(1,1000,'E12');
% R2 = combres(1,1000,'E12');
Rc = combres(1,10,'E12'); %
Rb = combres(1,10000,'E12'); %
Cx=100e-6;

Is=[10e-15 15e-15 20e-15];
Beta=100:50:300;
Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,Rb,Rc,Cx,Is,Beta,Va); %%
circuit.timeout = 5; % Simulation timeout in seconds

circuit.parind=1:4;
circuit.model.parnamesim={'IS','BF','VAF'};
circuit.model.parname={'IS','BF','VAF'};
circuit.model.parunit={'A','','V'};
% circuit.model.parvalue=[10e-15 250 100];
circuit.modind=5:7;

% circuit.Xm=CombVec(Is,Beta,Va); %%
circuit.model.name='TBJ';
circuit.model.tipo='NPN';

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
quiz.tbjtype = 'q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

% Generate question
quiz.enunciado = 'Para o circuito apresentado na Figura 1, determine:';

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

q=1;
quiz.question{q}.str='a) Qual o valor da impedância de entrada Zi?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'zi'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=2;
quiz.question{q}.str='b) Qual o valor da impedância de saída Zo?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'zo'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=3;
quiz.question{q}.str='c) Qual o valor do ganho de tensão |vo/vi|?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={'av'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


%% 
circuit.nsims=150; % Number of simulations
quiz.nquiz = 150; % Number of quizes

% circuit.nsims=length(circuit.Xi);
% quiz.nquiz = length(circuit.Xi);

circuit.LTspice.net.run =1;
ltspicemd2xml(circuit,quiz); % 



