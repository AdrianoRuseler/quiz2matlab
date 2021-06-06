clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'NE55501'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','RA','RB','RL','CA'}; % Variables names
circuit.parname={'Vcc','RA','RB','RL','CA'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;','F'}; % Variables unit

circuit.funcstr  = {'ne555func1(parvalues)','ne555func2(parvalues)','ne555func3(parvalues)','ne555func4(parvalues)'}; % Array of strings evalstr


% parameters input
Vcc=10:5:20; 
% Vi=15:5:20; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
RA = combnres(1,100,'E24',12);
RB = combnres(1,100,'E24',12);
RL = combnres(1,100,'E24',6);
CA = combnres(1,1e-9,'E24',12);


% Is=[10e-15 15e-15 20e-15];
% Beta=50:50:300;
% Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vcc,RA,RB,RL,CA); %%
circuit.timeout = 50; % Simulation timeout in seconds
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 10; % Numero de circuitos a serem simulados

% 
% circuit.parind=1:4;
% 
% circuit.model.parnamesim={'IS','BF','VAF'};
% circuit.model.parname={'IS','BF','VAF'};
% circuit.model.parunit={'A','','V'};
% % circuit.model.parvalue=[10e-15 250 100];
% circuit.modind=5:7;

% circuit.Xm=CombVec(Is,Beta,Va); %%
% circuit.model.name='TBJ';
% circuit.model.tipo='NPN';

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % 
% circuit.cmdvarind
% 
% quiz.tbjtype = 'q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
% % Generate question
quiz.enunciado = 'Para o circuito oscilador com NE555 no modo astável apresentado na Figura 1, determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

% Text a ser colocado abaixo da figura
% quiz.extratext{1} = [' .model LedRed D (IS=93.2P RS=42M N=3.73 BV=4 IBV=10U  <br>' ...
%                     ' +CJO=2.97P VJ=.75 M=.333 TT=4.32U Iave=40m Vpk=4 type=LED)']; % modelo do diodo
q=0;
% q=q+1;
% quiz.question{q}.str='Qual o valor de comparação V+ para Vo positivo?';
% quiz.question{q}.units={'V'};
% quiz.question{q}.options={'vx'}; % Only lowcase
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% 
q=q+1;
quiz.question{q}.str='Qual o valor da duração do nível alto na saída?';
quiz.question{q}.units={'s'};
quiz.question{q}.options={'th'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação \( t_H = ln(2)(R_A+R_B)C_A \)?'; % out = log(2)*(RA+RB)*CA; % tH
quiz.question{q}.units={'s'};
quiz.question{q}.options={1}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da duração do nível baixo na saída?';
quiz.question{q}.units={'s'};
quiz.question{q}.options={'tl'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação \( t_L = ln(2) R_B C_A \)?'; % out = log(2)*(RB)*CA; % tL
quiz.question{q}.units={'s'};
quiz.question{q}.options={2}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da frequência de oscilação?';
quiz.question{q}.units={'Hz'};
quiz.question{q}.options={'fosc'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação \( f_{OSC} = \dfrac{1}{ln(2) (R_A+2R_B) C_A}\)?'; % out = 1/(log(2)*(RA+2*RB)*CA); % freq.
quiz.question{q}.units={'Hz'};
quiz.question{q}.options={3}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da razão de trabalho na saída?';
quiz.question{q}.units={'%'};
quiz.question{q}.options={'duty'}; % Only lowcase
quiz.question{q}.vartype={'meas'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da relação \( D = 100(1- \dfrac{R_B}{R_A+2R_B}) \)?'; % out = RB/(RA+2*RB); % freq.
quiz.question{q}.units={'%'};
quiz.question{q}.options={4}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da frequência de oscilação?';
% quiz.question{q}.units={'Hz'};
% quiz.question{q}.options={'fosc'}; % Only lowcase
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor da relação \( \dfrac{-1}{2 R_0 C_0 ln(\frac{R_2}{2 R_1+R_2}) } \)?';
% quiz.question{q}.units={'Hz'};
% quiz.question{q}.options={1}; % Only lowcase
% quiz.question{q}.vartype={'func'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

% q=2;
% quiz.question{q}.str='b) Qual o valor da impedância de saída Zo?';
% quiz.question{q}.units={'&Omega;'};
% quiz.question{q}.options={'zo'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=3;
% quiz.question{q}.str='c) Qual o valor do ganho de tensão vo/vi?';
% quiz.question{q}.units={'V/V'};
% quiz.question{q}.options={'av'};
% quiz.question{q}.vartype={'meas'}; % meas 
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[5]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';



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



