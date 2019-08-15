% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'lab11a0'; % File name
% circuit.dir = 'A:\Dropbox\GitHub\quiz2matlab\et52b\lab11\'; % Sets simulation dir
circuit.dir = 'C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab11\'; % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost, classic

% Config simulation
circuit.parnamesim={'Vg','Vdd'}; % Variables names
circuit.parname={'Vg','Vdd'}; % Variables names
circuit.parunit={'V','V'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [0 1 2 3 4 5];

% Rd = combres(1,100,'E12'); % 12 resistores
Vdd=5;
%Rb = combres(1,1000,'E12'); % 12 resistores
% Rc = combres(1,10,'E12'); % 12 resistores
circuit.X=CombVec(Vdd);

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

% Name:       q1
% Model:    bc546b
% Ib:       7.25e-05
% Ic:       3.18e-02
% Vbe:      7.32e-01
% Vbc:     -4.61e+01
% Vce:      4.68e+01
% BetaDC:   4.39e+02
% 
% vrc: v(v1)-v(c)=3.17813
% vrb: v(v1)-v(b)=49.2677

% Figura 1: Considere o MOSFET sendo o contido no CI4007
quiz.enunciado = 'Monte o circuito apresentado na Figura 1 e preencha as tabelas a seguir:';

quiz.tablecaption{1}='Tabela 1: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{1}='Utilize o multímetro digital no modo CC:';

t=1; % Table
c=1; % Coluna

quiz.table{t,c}.header = 'Vg';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vg';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2; % Coluna
quiz.table{t,c}.header = 'Vg (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vg';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3; % Coluna
quiz.table{t,c}.header = 'Vg (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vg';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=4; % Coluna
quiz.table{t,c}.header = 'Vo (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vo';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=5; % Coluna
quiz.table{t,c}.header = 'Vo (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vo';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';
% 
% c=6; % Coluna
% quiz.table{t,c}.header = 'VRd (medido)';
% quiz.table{t,c}.units='V';
% quiz.table{t,c}.options='vrd';
% quiz.table{t,c}.vartype='meas'; % Single only
% quiz.table{t,c}.optscore=100; % Score per option
% quiz.table{t,c}.opttol=20; % tolerance in percentage %
% quiz.table{t,c}.weight='1'; % Item weight
% quiz.table{t,c}.type='NUMERICAL';
% 
% c=7; % Coluna
% quiz.table{t,c}.header = 'VRd (escala)';
% quiz.table{t,c}.units='V';
% quiz.table{t,c}.options='vrd';
% quiz.table{t,c}.vartype='meas'; % Single only
% quiz.table{t,c}.optscore=100; % Score per option
% quiz.table{t,c}.opttol=20; % tolerance in percentage %
% quiz.table{t,c}.weight='1'; % Item weight
% quiz.table{t,c}.type='SCALE';


% 
% %
% 
% quiz.tablecaption{2}='Tabela 2: Grandezas calculadas com base na tabela 01.';
% quiz.tablequestion{2}='Calcule as grandezas da tabela 2 com base nas medições da tabela 1;';
% t=2;
% c=1;
% quiz.table{t,c}.header = 'Vdd';
% quiz.table{t,c}.units='V';
% quiz.table{t,c}.options='Vdd';
% quiz.table{t,c}.vartype='op'; %
% quiz.table{t,c}.optscore=100; % Score per option
% quiz.table{t,c}.opttol=20; % tolerance in percentage %
% quiz.table{t,c}.type='STRING';
% 
% c=2;
% quiz.table{t,c}.header = 'Id (calculado)';
% quiz.table{t,c}.units='A';
% quiz.table{t,c}.options='m1:Id';
% quiz.table{t,c}.vartype='log'; % Single only
% quiz.table{t,c}.optscore=100; % Score per option
% quiz.table{t,c}.opttol=20; % tolerance in percentage %
% quiz.table{t,c}.weight='1'; % Item weight
% quiz.table{t,c}.type='NUMERICAL';



%%
quiz.nquiz=length(circuit.X);
% 
% circuit.nsims = 500; % Number of simulations
% quiz.nquiz = 5; % Number of quizes

ltspicetable2xml(circuit,quiz); % 










