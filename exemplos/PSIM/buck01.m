clear all
clc

% Config simulation
circuit.parname={'Vi','fs','D','L0','C0','R0'}; % Variables names
circuit.parunit={' V','Hz','V/V','H','F','&Omega;'}; % Variables unit
circuit.parnamesim={'Vi','fs','D','L0','C0','R0'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'buck01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% eval(circuit.func1str) % Must return a escalar
circuit.funcstr  = {'buck01func1(parvalues)','buck01func2(parvalues)','buck01func3(parvalues)','buck01func4(parvalues)'}; % Array of strings evalstr

% Parameters setup

Vi=(100:25:200); 
fs=[50:5:100]*1e3;


D = 0.2:0.05:0.85;
R0 = [4.7 5.6 6.8 8.2 10 12 15 18 22 27 33 39]; %

% R0 = combres(1,1,'E12'); %
L0 = combcap(1,1e-5,'E12');
C0 = combcap(1,1e-7,'E12');

circuit.Xi=CombVec(Vi,fs,D,L0,C0,R0);

% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims =10; % Numero de circuitos a serem simulados

circuit.fundfreqind=2; % 
circuit.cycles = 15e3; % Total number of cycles
circuit.printcycle = 14e3; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o conversor CC-CC Buck apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  

q=0;
q=q+1;

% q=6;
% quiz.question{q}.str='b) Qual o valor eficaz de Db?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'rms'}; %
% quiz.question{q}.options={'IDb'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

quiz.question{q}.str='Qual o valor médio da tensão na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='Qual o valor médio da corrente na indutância L0?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'IL0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da indutância L0 crítica?';
quiz.question{q}.units={'H'};
quiz.question{q}.vartype={'func'}; %
quiz.question{q}.options={3};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da resistência R0 crítica?';
quiz.question{q}.units={'&Omega;'};
quiz.question{q}.vartype={'func'}; %
quiz.question{q}.options={4};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 

% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da corrente no MOSFET Sb?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'rms'}; %
% quiz.question{q}.options={'ISb'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';


% q=q+1;
% quiz.question{q}.str='b) Qual o valor eficaz de Db?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'rms'}; %
% quiz.question{q}.options={'IDb'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor eficaz da corrente no capacitor C0?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'rms'}; %
% quiz.question{q}.options={'IC0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='b) Qual o valor de delta IC0?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'delta'}; %
% quiz.question{q}.options={'IC0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da ondulação de corrente no indutor L0?';
quiz.question{q}.units={'A'};
quiz.question{q}.vartype={'delta'}; %
quiz.question{q}.options={'IL0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


q=q+1;
quiz.question{q}.str='Qual o valor da ondulação de tensão na carga R0?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'delta'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';


%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimca2xml(circuit,quiz);
    end
else
    psimca2xml(circuit,quiz);
end

