% LTspice Table Test
% .include C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab14\LMx24.lib

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'lab01a'; % File name
circuit.dir = 'C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab01\'; % Sets simulation dir
% circuit.dir = 'C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab12\'; % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost, classic

% Config simulation
circuit.parnamesim={'Vcc','R1'}; % Variables names
circuit.parname={'Vcc','R1'}; % Variables names with special caracteres
circuit.parunit={'V','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 5 10];


R1 = combres(1,100,'E12'); % 12 resistores
circuit.X=CombVec(R1);


circuit.nsims=length(circuit.X);
% circuit.nsims=5; % Number of simulations
% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);
circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
quiz.tbjtype = 'm1:nmos';
quiz.tbjeval = 0; % Evaluate tbj op

%%


% Figura 1: Considere o MOSFET sendo o contido no CI4007
quiz.enunciado = 'Monte o circuito apresentado na Figura 1 e preencha as tabelas a seguir:';

quiz.tablecaption{1}='Tabela 1: Grandezas medidas com mult�metro digital (Valor m�dio)!';
quiz.tablequestion{1}='Utilize o mult�metro digital no modo CC:';

t=1; % Table
c=1; % Coluna

quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2; % Coluna
quiz.table{t,c}.header = 'Vcc (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3; % Coluna
quiz.table{t,c}.header = 'Vcc (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=4; % Coluna
quiz.table{t,c}.header = 'VR1 (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vr1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=5; % Coluna
quiz.table{t,c}.header = 'VR1 (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vr1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=6; % Coluna
quiz.table{t,c}.header = 'VD1 (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vd';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=7; % Coluna
quiz.table{t,c}.header = 'VD1 (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vd';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';


%
quiz.tablecaption{2}='Tabela 2: Grandezas calculadas com base na tabela 01.';
quiz.tablequestion{2}='Calcule as grandezas da tabela 2 com base nas medi��es da tabela 1;';
t=2;
c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2;
quiz.table{t,c}.header = 'iD1';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='id1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3;
quiz.table{t,c}.header = 'pD1';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pd';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=4;
quiz.table{t,c}.header = 'pR1';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pr';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';


%%
quiz.nquiz=length(circuit.X);
% 
% circuit.nsims = 500; % Number of simulations
% quiz.nquiz = 5; % Number of quizes

ltspicetable2xml(circuit,quiz); % 









