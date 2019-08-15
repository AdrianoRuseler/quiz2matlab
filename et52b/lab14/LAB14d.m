% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'lab14d'; % File name
circuit.dir = 'A:\Dropbox\GitHub\quiz2matlab\et52b\lab14\'; % Sets simulation dir
% circuit.dir = 'C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab12\'; % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost, classic

% Config simulation
circuit.parnamesim={'Vi','Vpp','Vnn','R1','R0'}; % Variables names
circuit.parname={'Vi','Vpp','Vnn','R1','R0'}; % Variables names
circuit.parunit={'V','V','V','&Omega;','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [-0.4 -0.5 -0.6 -0.7];

% Rd = combres(1,100,'E12'); % 12 resistores
Vpp=10;
Vnn=10;
% R1 = combres(1,1000,'E12'); % 12 resistores
% R2 = combres(1,100,'E12'); % 12 resistores
% Rc = combres(1,10,'E12'); % 12 resistores

R1=[100 150];
R0=[1000 1500];


circuit.X=CombVec(Vpp,Vnn,R1,R0);


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

quiz.tablecaption{1}='Tabela 1: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{1}='Utilize o multímetro digital no modo CC:';

t=1; % Table
c=1; % Coluna

quiz.table{t,c}.header = 'Vi';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vi';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2; % Coluna
quiz.table{t,c}.header = 'Vi (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vi';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3; % Coluna
quiz.table{t,c}.header = 'Vi (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vi';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=4; % Coluna
quiz.table{t,c}.header = 'Vout (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vout';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=5; % Coluna
quiz.table{t,c}.header = 'Vout (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vout';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';


%
quiz.tablecaption{2}='Tabela 2: Grandezas calculadas com base na tabela 01.';
quiz.tablequestion{2}='Calcule as grandezas da tabela 2 com base nas medições da tabela 1;';
t=2;
c=1;
quiz.table{t,c}.header = 'Vi';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vi';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2;
quiz.table{t,c}.header = 'Ganho (Vout/Vi)';
quiz.table{t,c}.units='V/V';
quiz.table{t,c}.options='gio';
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










