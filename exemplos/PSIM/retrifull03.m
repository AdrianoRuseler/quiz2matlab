clear all
clc

% Config simulation
circuit.parname={'Vi','fi','alpha','L0','R0','a'}; % Variables names
circuit.parunit={' V',' Hz','deg','H','&Omega;','V/V'}; % Variables unit
circuit.parnamesim={'Vi','fi','alpha','L0','R0','a'}; % Variables names utilizados na similação

% Simulation setup 
circuit.name = 'retrifull03'; % File name
circuit.dir = [pwd '\']; % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% eval(circuit.func1str) % Must return a escalar
% circuit.funcstr  = {'retrifull03func1(parvalues)','retrifull03func3(parvalues)','retrifull03func3(parvalues)'}; % Array of strings evalstr
circuit.funcstr  = {'retrifull03func1(parvalues)','retrifull03func2(parvalues)','retrifull03func3(parvalues)'}; % Array of strings evalstr

% Parameters setup

Vi=(100:25:250); 
fi=50:5:100;
alpha=5:5:45;
% ron = combres(1,1e-3,'E12');
R0 = combres(1,0.1,'E12'); %
L0 = combcap(1,1e-3,'E12');
a=0.1:0.05:0.5;

circuit.Xi=CombVec(Vi,fi,alpha,L0,R0,a); %%
% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims =10; % Numero de circuitos a serem simulados

% circuit.nsims =100; % Numero de circuitos a serem simulados
circuit.fundfreqind=2; % 
circuit.cycles = 10; % Total number of cycles
circuit.printcycle = 8; % Cycle to start print

% Generate question
quiz.enunciado = 'Para o circuito retificador trifásico ponte de Graetz com carga RLE apresentado na Figura 1, determine:'; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122; 

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor médio da tensão na carga?';
quiz.question{q}.units={'V'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.options={'V0'};
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor médio da corrente na carga?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'i0'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
q=q+1;
quiz.question{q}.str='Qual o valor mínimo do ângulo de disparo dos tiristores \( \alpha \) em graus?';
quiz.question{q}.units={'Graus'}; % 
quiz.question{q}.vartype={'func'}; % MATLAB Function
quiz.question{q}.options={2}; % Number of the function
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=q+1;
% quiz.question{q}.str='Qual o valor do ângulo de extinção da corrente \( \beta \) em graus?';
% quiz.question{q}.units={'Graus'}; % 
% quiz.question{q}.vartype={'func'}; % MATLAB Function
% quiz.question{q}.options={1}; % Number of the function
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor limite para condução contínua do ângulo \( \beta \) em graus?';
quiz.question{q}.units={'Graus'}; % 
quiz.question{q}.vartype={'func'}; % MATLAB Function
quiz.question{q}.options={3}; % Number of the function
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

% q=3;
% quiz.question{q}.str='c) Qual o valor médio da corrente no tiristor T3?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.options={'iT3'};
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
% 
% q=q+1;
% quiz.question{q}.str='Qual a potência ativa na carga?';
% quiz.question{q}.units={'W'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'p0'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% % 
% q=q+1;
% quiz.question{q}.str='Qual a potência aparente na fonte?';
% quiz.question{q}.units={'VA'}; % 
% quiz.question{q}.vartype={'mean'}; % Not implemented
% quiz.question{q}.options={'VAPF_VA'}; % Variables from PSIM simulation
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o fator de potência?';
quiz.question{q}.units={'W/VA'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'VAPF_PF'}; % Variables from PSIM simulation
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
q=q+1;
quiz.question{q}.str='Qual o valor da THD da corrente na fonte?';
quiz.question{q}.units={'A/A'}; % 
quiz.question{q}.vartype={'mean'}; % Not implemented
quiz.question{q}.options={'thdi'}; % Variables from PSIM simulation
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
