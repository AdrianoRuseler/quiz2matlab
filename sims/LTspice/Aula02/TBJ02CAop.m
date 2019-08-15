clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ02CAop'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1','R2','Rc','Re'}; % Variables names
circuit.parname={'Vcc','R1','R2','Rc','Re'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combres(1,1000,'E12');
R2 = combres(1,1000,'E12');
Re = combres(1,10,'E12'); %
Rc = combres(1,10,'E12'); %

Is=[10e-15 15e-15 20e-15];
Beta=100:50:300;
Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,R1,R2,Rc,Re,Is,Beta,Va); %%

circuit.parind=1:5;

circuit.model.parnamesim={'IS','BF','VAF'};
circuit.model.parname={'IS','BF','VAF'};
circuit.model.parunit={'A','','V'};
% circuit.model.parvalue=[10e-15 250 100];
circuit.modind=6:8;

% circuit.Xm=CombVec(Is,Beta,Va); %%
circuit.model.name='TBJ';
circuit.model.tipo='NPN';

circuit.cmdtype = '.op'; % Operation Point Simulation
quiz.tbjtype = 'q1:npn';

% Generate question
quiz.enunciado = 'Simule o circuito apresentado na Figura 1 e determine:';

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo

%  --- Bipolar Transistors ---
% Name:       q1
% Model:    bc546b
% Ib:       7.25e-05
% Ic:       3.18e-02
% Vbe:      7.32e-01
% Vbc:     -4.61e+01
% Vce:      4.68e+01
% BetaDC:   4.39e+02
% Gm:       1.09e+00
% Rpi:      3.60e+02
% Rx:       1.00e+00
% Ro:       3.38e+03
% Cbe:      5.59e-10
% Cbc:      5.67e-13
% Cjs:      0.00e+00
% BetaAC:   3.91e+02
% Cbx:      3.48e-13
% Ft:       3.09e+08
% vrc: v(v1)-v(c)=3.17813
% vrb: v(v1)-v(b)=49.2677
% prb: vrb*i(rb)=0.00356956
% prc: vrc*i(rc)=0.101005
% 
% q=1;
% quiz.question{q}.str='a) Qual o valor da corrente de base Ib?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'q1:Ib'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=2;
% quiz.question{q}.str='b) Qual o valor da corrente de base Ic?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'q1:Ic'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=1;
quiz.question{q}.str='a) Qual o valor do ganho &beta; em CC?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'q1:BetaDC'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=4;
% quiz.question{q}.str='d) Qual a tensão Base-Emissor Vbe?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbe'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=2;
% quiz.question{q}.str='e) Qual a tensão Base-Coletor Vbc?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbc'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=2;
quiz.question{q}.str='b) Qual o valor da resistência re?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'re'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=3;
quiz.question{q}.str='c) Qual o valor da resistência ro?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'ro'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=4;
quiz.question{q}.str='d) Qual o modo de operação do TBJ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='TBJ';

%% 
circuit.nsims=700; % Number of simulations
quiz.nquiz = 500; % Number of quizes

% circuit.nsims=length(circuit.Xi);
% quiz.nquiz = length(circuit.Xi);

ltspicemd2xml(circuit,quiz); % 



