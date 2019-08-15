clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'TBJ01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Rb','Rc'}; % Variables names
circuit.parname={'Vcc','Rb','Rc'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Rb = combres(1,10000,'E12'); %
Rc = combres(1,10,'E12'); %
% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,Rb,Rc); %%

circuit.cmdtype = '.op'; % Operation Point Simulation

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


quiz.question{1}.str='a) Qual o valor da corrente de base Ib?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'q1:Ib'};
quiz.question{1}.vartype={'log'}; % meas 
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual o valor da corrente de base Ic?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'q1:Ic'};
quiz.question{2}.vartype={'log'}; % meas 
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';


quiz.question{3}.str='c) Qual o valor do ganho &beta; em CC?';
quiz.question{3}.units={'A/A'};
quiz.question{3}.options={'q1:BetaDC'};
quiz.question{3}.vartype={'log'}; % meas 
quiz.question{3}.optscore=[100]; % Score per option
quiz.question{3}.opttol=[10]; % tolerance in percentage %
quiz.question{3}.type='NUMERICAL';

quiz.question{4}.str='d) Qual a tensão Base-Emissor Vbe?';
quiz.question{4}.units={'V'};
quiz.question{4}.options={'q1:Vbe'}; % Device:Var
quiz.question{4}.vartype={'log'}; % From log file
quiz.question{4}.optscore=[100]; % Score per option
quiz.question{4}.opttol=[10]; % tolerance in percentage %
quiz.question{4}.type='NUMERICAL';

quiz.question{5}.str='e) Qual a tensão Base-Coletor Vbc?';
quiz.question{5}.units={'V'};
quiz.question{5}.options={'q1:Vbc'}; % Device:Var
quiz.question{5}.vartype={'log'}; % From log file
quiz.question{5}.optscore=[100]; % Score per option
quiz.question{5}.opttol=[1]; % tolerance in percentage %
quiz.question{5}.type='NUMERICAL';

q=6;
quiz.question{q}.str='f) Qual a tensão Coletor-Emissor Vce?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:Vce'}; % Device:Var
quiz.question{q}.vartype={'log'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=7;
quiz.question{q}.str='g) Qual o modo de operação do TBJ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='TBJ';



%% 
% circuit.nsims=250; % Number of simulations
% quiz.nquiz = 250; % Number of quizes

circuit.nsims=length(circuit.Xi);
quiz.nquiz = length(circuit.Xi);

ltspice2xml(circuit,quiz); % 



