% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'steptest'; % File name
circuit.dir = getsimdir([circuit.name '.m'],'LTspice'); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1','R2'}; % Variables names
circuit.parname={'Vcc','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [1 2 3 4 5];

R1 = combres(1,100,'E12'); % 12 resistores
R2 = combres(1,100,'E12'); % 12 resistores
circuit.Xi=CombVec(R1,R2);

circuit.nsims=5; % Number of simulations
[~,y]=size(circuit.Xi);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.X=circuit.Xi(:,nq);


%%

quiz.enunciado = 'Simule o circuito apresentado na Figura 1 e determine:';

quiz.table{1,1}.header = 'STRING';
quiz.table{1,1}.units='V';
quiz.table{1,1}.options='Vv1';
quiz.table{1,1}.vartype='op'; %
quiz.table{1,1}.optscore=100; % Score per option
quiz.table{1,1}.opttol=1; % tolerance in percentage %
quiz.table{1,1}.type='STRING';


quiz.table{1,2}.header = 'NUMERICAL';
quiz.table{1,2}.units='V';
quiz.table{1,2}.options='d1:Vd';
quiz.table{1,2}.vartype='log'; % Single only
quiz.table{1,2}.optscore=100; % Score per option
quiz.table{1,2}.opttol=10; % tolerance in percentage %
quiz.table{1,2}.weight='1'; % Item weight
quiz.table{1,2}.type='NUMERICAL';


quiz.table{1,3}.header = 'SCALE';
quiz.table{1,3}.units='V';
quiz.table{1,3}.options='d1:Vd';
quiz.table{1,3}.vartype='log'; % Single only
quiz.table{1,3}.optscore=100; % Score per option
quiz.table{1,3}.opttol=10; % tolerance in percentage %
quiz.table{1,3}.weight='1'; % Item weight
quiz.table{1,3}.type='SCALE';

quiz.tablecaption{1}='Tabela 1: Grandezas calculadas e medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{1}='Complete a tabela abaixo:';


quiz.table{2,1}.header = 'STRING';
quiz.table{2,1}.units='V';
quiz.table{2,1}.options='Vv1';
quiz.table{2,1}.vartype='op'; %
quiz.table{2,1}.optscore=100; % Score per option
quiz.table{2,1}.opttol=1; % tolerance in percentage %
quiz.table{2,1}.type='STRING';


quiz.table{2,2}.header = 'NUMERICAL';
quiz.table{2,2}.units='W';
quiz.table{2,2}.options='pd';
quiz.table{2,2}.vartype='meas'; % Single only 
quiz.table{2,2}.optscore=100; % Score per option
quiz.table{2,2}.opttol=10; % tolerance in percentage %
quiz.table{2,2}.weight='1'; % Item weight
quiz.table{2,2}.type='NUMERICAL';

quiz.tablecaption{2}='Tabela 2: Grandezas calculadas e medidas com multímetro digital (Valor médio)';
quiz.tablequestion{2}='Complete a tabela abaixo:';

% quiz.table{2,3}.header = 'SCALE';
% quiz.table{2,3}.units='V';
% quiz.table{2,3}.options='Vv1';
% quiz.table{2,3}.vartype='op'; % Single only
% quiz.table{2,3}.optscore=100; % Score per option
% quiz.table{2,3}.opttol=10; % tolerance in percentage %
% quiz.table{2,3}.weight='2'; % Item weight
% quiz.table{2,3}.type='SCALE';


%%

circuit.nsims = 5; % Number of simulations
quiz.nquiz = 5; % Number of quizes

ltspicetable2xml(circuit,quiz); % 










