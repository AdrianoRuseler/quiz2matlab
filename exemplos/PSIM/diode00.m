clear all
clc

% Config simulation
circuit.name = 'diode00'; % File name
circuit.dir = [pwd '\']; %
circuit.theme  = 'boost'; % clean or boost
circuit.parname={'Vi','Von','Ron','R0'}; % Variables names
circuit.parnamesim={'Vi','Von','Ron','R0'}; % Variables names
circuit.parunit={'V','V','&Omega;','&Omega;'}; % Variables unit

% parameters input
Vi=5:5:30; 
Von=0.5:0.05:0.7;

Ron = combres(1,0.001,'E24'); %
R0 = combres(1,10,'E24'); %


circuit.Xi=CombVec(Vi,Von,Ron,R0); %%
% circuit.multiplesims=[25 25]; % Number of simulations
circuit.nsims = 10; % Numero de circuitos a serem simulados

% circuit.engine ='psim'; % PSIM simulation
circuit.engine ='ltspice'; % LTspice simulation


% Generate question

quiz.enunciado = ['Para o circuito contendo um diodo com tensão de polarização direta Von'...
    ', e resistência de condução Ron apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!
quiz.rowfigparam=1; % Imprima os parâmetros ao lado da figura
quiz.autoitem=1; % Auto add item letter: a), b)... 97 - 122;  
quiz.incfrom=0; % Increment from

q=0;
q=q+1;
quiz.question{q}.str='Qual o valor da corrente média no resistor R0?';
quiz.question{q}.units={'A'};
quiz.question{q}.options={'IR0'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da tensão média no resistor R0?';
quiz.question{q}.units={'V'};
quiz.question{q}.options={'VR0'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da corrente média no diodo zener Z1?';
% quiz.question{q}.units={'A'};
% quiz.question{q}.options={'Iz'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';
% 
% q=q+1;
% quiz.question{q}.str='Qual o valor da potência média no diodo zener Z1?';
% quiz.question{q}.units={'W'};
% quiz.question{q}.options={'Pz'};
% quiz.question{q}.vartype={'mean'}; %
% quiz.question{q}.optscore=[100]; % Score per option
% quiz.question{q}.opttol=[10]; % tolerance in percentage %
% quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da potência média na fonte Vi?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'PVi'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da potência média no diodo D0?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'Pd'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';

q=q+1;
quiz.question{q}.str='Qual o valor da potência média no resistor R0?';
quiz.question{q}.units={'W'};
quiz.question{q}.options={'Pr'};
quiz.question{q}.vartype={'mean'}; %
quiz.question{q}.optscore=[100]; % Score per option
quiz.question{q}.opttol=[10]; % tolerance in percentage %
quiz.question{q}.type='NUMERICAL';



%% Generate quizes
if isfield(circuit,'multiplesims')
    for ms=1:length(circuit.multiplesims)
        circuit.nsims=circuit.multiplesims(ms); % Number of simulations
        psimdc2xml(circuit,quiz);
    end
else
    psimdc2xml(circuit,quiz);
end




