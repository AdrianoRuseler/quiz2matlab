clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'Filter01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','R1','R2','C2','RL'}; % Variables names
circuit.parname={'Vs','R1','R2','C2','RL'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','F','&Omega;'}; % Variables unit

circuit.funcstr  = {'filter01func1(parvalues)','filter01func2(parvalues)','filter01func3(parvalues)','filter01func4(parvalues)'}; % Array of strings evalstr


% parameters input
Vs=15:5:20; 
% Vi=[-5:-1 1:5]; 

% Vz=[2.7 3.3 3.9 4.7 5.6 6.8 8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
R1 = combnres(1,100,'E24',6);
R2 = combnres(1,100,'E24',6);
RL = combnres(1,10000,'E24',6);

C2 = combnres(1,1e-9,'E24',6);
% Is=[10e-15 15e-15 20e-15];
% Beta=50:50:300;
% Va=100:50:200;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,R1,R2,C2,RL); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 10; % Numero de circuitos a serem simulados

circuit.cmdtype = '.ac'; % AC analysis
circuit.cmdupdate = 0; % 

% 
% quiz.tbjtype = 'q1:npn';
% quiz.tbjeval = 0; % Evaluate tbj op
% % Generate question
quiz.enunciado = 'Para o filtro passa-baixas apresentado na Figura 1, determine:';

% Text a ser colocado abaixo da figura
quiz.extratext{1} = 'Forma padronizada: \(H(s) = H_o\dfrac{1}{1+\dfrac{s}{ \omega_o }} \)';

quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor de \(H_o\)?';
quiz.question{q}.units={'V/V'};
quiz.question{q}.options={1}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de \(H_o\) em decibels?';
quiz.question{q}.units={'dB'};
quiz.question{q}.options={2}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor de \(\omega_o\)?';
quiz.question{q}.units={'rad/s'};
quiz.question{q}.options={3}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da frequência de corte?';
quiz.question{q}.units={'Hz'};
quiz.question{q}.options={4}; % Only lowcase
quiz.question{q}.vartype={'func'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';




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


