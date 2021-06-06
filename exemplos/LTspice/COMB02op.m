clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'COMB02op'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','RD','RE','R1','R2'}; % Variables names
circuit.parname={'Vcc','RD','RE','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vcc=20:5:30; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];

% Rg = combres(1,100000,'E12'); %
% Ry = combres(1,10000,'E12'); %

R1 = combnres(1,10000,'E24',6);
R2 = combnres(1,10000,'E24',6);


% Rb = combres(1,10000,'E12'); %
RD = combnres(1,10,'E24',6); %
RE = combnres(1,10,'E24',6); %

IS=[10e-15 15e-15 20e-15];
BF=50:25:100;
% VAF=100:50:200;

% Is=[10e-15 15e-15 20e-15];
Beta=[2:5]*1e-3;
Vto=-[5:10];

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,RD,RE,R1,R2,Beta,Vto,IS,BF); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 10; % Numero de circuitos a serem simulados


circuit.parind=[1:5];

circuit.modind(1,:)=[6 7]; % Index for model parameters
circuit.modind(2,:)=[8 9]; % Index for model parameters

% '.model ' circuit.model.name ' ' circuit.model.tipo '('];
circuit.model(1).name='JFET'; % for .model 
circuit.model(1).tipo='NJF'; % for .model 

circuit.model(2).name='TBJ'; % for .model 
circuit.model(2).tipo='NPN'; % for .model 

circuit.model(1).parnamesim={'Beta','Vto'};
circuit.model(1).parname={'Beta','Vto'};
circuit.model(1).parunit={'\( \frac{A}{V^2} \)','V'};

circuit.model(2).parnamesim={'IS','BF'};
circuit.model(2).parname={'IS','BF'};
circuit.model(2).parunit={'A',''};

% circuit.model.parvalue=[10e-15 250 100];

%% circuit.Xm=CombVec(Is,Beta,Va); %%



circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
circuit.LTspice.net.run = 0;

% Generate question
quiz.enunciado = 'Simule no LTspice o ponto de operação (.op) do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo


quiz.fettype='j1:NJF';
quiz.feteval = 0; % Evaluate fet op

% 
% quiz.tbjtype='q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente de base Ib?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ib'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de coletor Ic?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'q1:Ic'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o modo de operação do TBJ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'q1:npn'}; % Device:Var
quiz.question{q}.vartype={'mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='TBJ';

q=q+1;
quiz.question{q}.str='Qual o valor da corrente de dreno Id?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'j1:Id'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Gate-Source Vgs?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:Vgs'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Dreno-Source Vds?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:Vds'};
quiz.question{q}.vartype={'log'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão Vds de saturação Vds<sub>sat</sub> = Vgs - Vto?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:NJF'}; % Device:Var
quiz.question{q}.vartype={'feteval:Vgst'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual a região de operação do JFET?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'j1:NJF'}; % Device:Var
quiz.question{q}.vartype={'feteval:mop'}; % From log file
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='FET';



% 
% q=2;
% quiz.question{q}.str='b) Qual o valor da corrente Dreno-Source de saturação Idss?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:Idss'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 

% q=4;
% quiz.question{q}.str='d) Qual o valor da tensão Dreno-Source Vds?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'j1:Vds'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 




% q=3;
% quiz.question{q}.str='c) Qual o valor do ganho &beta; em CC?';
% quiz.question{q}.units={'A/A'};
% quiz.question{q}.options={'q1:BetaDC'};
% quiz.question{q}.vartype={'log'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=4;
% quiz.question{q}.str='d) Qual a tensão Base-Emissor Vbe?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbe'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=5;
% quiz.question{q}.str='e) Qual a tensão Base-Coletor Vbc?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vbc'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=6;
% quiz.question{q}.str='e) Qual a tensão Coletor-Emissor Vce?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'q1:Vce'}; % Device:Var
% quiz.question{q}.vartype={'log'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[1]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=7;
% quiz.question{q}.str='f) Qual o valor da resistência re?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'re'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=8;
% quiz.question{q}.str='g) Qual o valor da resistência ro?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'q1:npn'}; % Device:Var
% quiz.question{q}.vartype={'ro'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 

% q=5;
% quiz.question{q}.str='e) Qual o valor da tensão Vgst = Vgs - Vto?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:Vgst'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% 
% q=7;
% quiz.question{q}.str='g) Qual o valor da resistência rd?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'j1:NJF'}; % Device:Var
% quiz.question{q}.vartype={'feteval:rd'}; % From log file
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        quiz.nquiz = circuit.nsims;
        ltspicemd2xml(circuit,quiz);
    end
else
    quiz.nquiz = circuit.nsims;
    ltspicemd2xml(circuit,quiz);
end


