clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ02CA'; % File name
% circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir 
circuit.dir = 'A:\Dropbox\GitHub\quiz2matlab\et52b\lab09\';
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1','Rc','R2','Re'}; % Variables names
circuit.parname={'Vcc','R1','Rc','R2','Re'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=15; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
% R1 = combres(1,1000,'E12');
% R2 = combres(1,1000,'E12');
Rx = combres(1,10,'E12'); %
Ry = combres(1,1000,'E12'); %

% Is=[10e-15 15e-15 20e-15];
% Beta=100:50:300;
% Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
% circuit.Xi=CombVec(Vcc,Rb,Rc,Is,Beta,Va); %%
circuit.Xi=CombVec(Vcc,Ry,Rx); %%


circuit.Xi(4,:)=circuit.Xi(2,:);
circuit.Xi(5,:)=circuit.Xi(3,:);

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
quiz.tbjtype = 'q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op
% Generate question
quiz.enunciado = 'Monte o circuito apresentado na Figura 1 e determine:';

quiz.extratext{1} = 'Entre com um sinal de 1 mV e 10 kHZ.';
% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

q=1;
quiz.question{q}.str='a) Qual o valor da tensão eficaz de entrada?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'virms'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[25]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=2;
quiz.question{q}.str='b) Qual o valor da tensão pico a pico na base?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vbpp'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[25]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=3;

quiz.question{q}.str='c) Qual o valor da tensão pico a pico no coletor?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vcpp'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[25]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=4;

quiz.question{q}.str='d) Qual o valor da tensão eficaz na saída?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vorms'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[25]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=5;
quiz.question{q}.str='e) Qual o valor do ganho de tensão |vo/vi|?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={'av'};
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[25]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';





%% 
% circuit.nsims=505; % Number of simulations
% quiz.nquiz = 500; % Number of quizes

circuit.nsims=length(circuit.Xi);
quiz.nquiz = length(circuit.Xi);

ltspice2xml(circuit,quiz); % 



