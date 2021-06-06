clear all
clc

% Sets simulation dir
% circuit.dir ='F:\Dropbox\GitHub\quiz2matlab\sims\LTspice\'; % Home
circuit.name = 'OPAMPTBJ01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vs','Vi','R1','RL'}; % Variables names
circuit.parname={'Vs','Vi','R1','RL'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;'}; % Variables unit

circuit.funcstr  = {'OPAMPTBJ01func1(parvalues)'}; % Array of strings evalstr

% parameters input
R1 = combnres(1,100,'E24',12);
RL = combnres(1,1000,'E24',6);

Vs=15:5:25; 
Vi=1:1:10; 

Is=[10:30]*1e-15;
Beta=50:50:250;
nf=1:0.1:2;

% Rb = combres(1,[100],'E12'); %
circuit.Xi=CombVec(Vs,Vi,R1,RL,Is,Beta,nf); %%
circuit.timeout = 5; % Simulation timeout in seconds

% circuit.multiplesims=[50 50]; % Number of simulations
circuit.nsims = 10; % Numero de circuitos a serem simulados


circuit.parind=[1 2 3 4];
circuit.modind=[5 6 7];

circuit.model.parnamesim={'IS','BF','NF'};
circuit.model.parname={'IS','BF','NF'};
circuit.model.parunit={'A','V/V',''};

% circuit.Xm=CombVec(Is,Beta,Va); %%
circuit.model.name='TBJ';
circuit.model.tipo='NPN';
quiz.tbjtype='q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0; % Update the cmdtype from sim file
% Generate question
quiz.enunciado = 'Simule o ponto de operação do circuito apresentado na Figura 1 e determine:';
quiz.rowfigdirective=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente em R1?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'ir1'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor do ganho &beta; em CC?';
quiz.question{q}.units={'A/A'};
quiz.question{q}.options={'q1:BetaDC'};
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
quiz.question{q}.str='Qual o valor da tensão de saída Vo?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'vo'}; % Only lowcase
quiz.question{q}.vartype={'op'}; % meas 
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[5]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da expressão \( -nV_T ln \left ( \dfrac{V_i}{R_1I_s} \right ) \) ?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={1}; % Only lowcase
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



