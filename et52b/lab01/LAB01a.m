% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'LAB01a'; % File name
circuit.dir = getsimdir([circuit.name '.m'],'LTspice'); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','R1'}; % Variables names
circuit.parname={'Vcc','R1'}; % Variables names
circuit.parunit={'V','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 2.5 5];

R1 = combres(1,100,'E12'); % 12 resistores
R2 = combres(1,10,'E12'); % 12 resistores
circuit.X=CombVec(R1);

circuit.nsims=length(circuit.X);
% circuit.nsims=5; % Number of simulations
% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);


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




quiz.enunciado = 'Monte o circuito apresentado na Figura 1 e preencha as tabelas a seguir:';

t=1;
c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';
c=2;
quiz.table{t,c}.header = 'Vcc (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';
c=3;
quiz.table{t,c}.header = 'Vcc (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';
c=4;
quiz.table{t,c}.header = 'Vbc (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='q1:Vbc';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';
c=5;
quiz.table{t,c}.header = 'Vbc (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='q1:Vbc';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';
c=6;
quiz.table{t,c}.header = 'Vce (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='q1:Vce';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';
c=7;
quiz.table{t,c}.header = 'Vce (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='q1:Vce';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

quiz.tablecaption{1}='Tabela 1: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{1}='Utilize o multímetro digital no modo CC:';


quiz.table{2,1}.header = 'Vcc';
quiz.table{2,1}.units='V';
quiz.table{2,1}.options='Vv1';
quiz.table{2,1}.vartype='op'; %
quiz.table{2,1}.optscore=100; % Score per option
quiz.table{2,1}.opttol=20; % tolerance in percentage %
quiz.table{2,1}.type='STRING';


quiz.table{2,2}.header = 'Polarização BE';
quiz.table{2,2}.units='V';
quiz.table{2,2}.options='q1';
quiz.table{2,2}.vartype='pbe'; % pbc pbe mop
quiz.table{2,2}.optscore=100; % Score per option
quiz.table{2,2}.opttol=20; % tolerance in percentage %
quiz.table{2,2}.weight='1'; % Item weight
quiz.table{2,2}.type='TBJ';

quiz.table{2,3}.header = 'Polarização BC';
quiz.table{2,3}.units='V';
quiz.table{2,3}.options='q1';
quiz.table{2,3}.vartype='pbc'; % pbc pbe mop
quiz.table{2,3}.optscore=100; % Score per option
quiz.table{2,3}.opttol=20; % tolerance in percentage %
quiz.table{2,3}.weight='1'; % Item weight
quiz.table{2,3}.type='TBJ';

quiz.tablecaption{2}='Tabela 2: Polarização das junções BE e BC e modo de operação do transistor TBJ.';
quiz.tablequestion{2}='Complete a tabela abaixo com base nos valores medidos na Tabela 1.';

quiz.table{2,4}.header = 'Modo';
quiz.table{2,4}.units='V';
quiz.table{2,4}.options='q1';
quiz.table{2,4}.vartype='mop'; % pbc pbe mop
quiz.table{2,4}.optscore=100; % Score per option
quiz.table{2,4}.opttol=20; % tolerance in percentage %
quiz.table{2,4}.weight='1'; % Item weight
quiz.table{2,4}.type='TBJ';



quiz.tablecaption{3}='Tabela 3: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{3}='Utilize o multímetro digital no modo CC:';


t=3;
c=1;
quiz.table{3,1}.header = 'Vcc';
quiz.table{3,1}.units='V';
quiz.table{3,1}.options='Vv1';
quiz.table{3,1}.vartype='op'; %
quiz.table{3,1}.optscore=100; % Score per option
quiz.table{3,1}.opttol=20; % tolerance in percentage %
quiz.table{3,1}.type='STRING';

quiz.table{3,2}.header = 'VRb (medido)';
quiz.table{3,2}.units='V';
quiz.table{3,2}.options='vrb';
quiz.table{3,2}.vartype='meas'; % Single only
quiz.table{3,2}.optscore=100; % Score per option
quiz.table{3,2}.opttol=20; % tolerance in percentage %
quiz.table{3,2}.weight='1'; % Item weight
quiz.table{3,2}.type='NUMERICAL';

quiz.table{3,3}.header = 'VRb (escala)';
quiz.table{3,3}.units='V';
quiz.table{3,3}.options='vrb';
quiz.table{3,3}.vartype='meas'; % Single only
quiz.table{3,3}.optscore=100; % Score per option
quiz.table{3,3}.opttol=20; % tolerance in percentage %
quiz.table{3,3}.weight='1'; % Item weight
quiz.table{3,3}.type='SCALE';

quiz.table{3,4}.header = 'VRc (medido)';
quiz.table{3,4}.units='V';
quiz.table{3,4}.options='vrc';
quiz.table{3,4}.vartype='meas'; % Single only
quiz.table{3,4}.optscore=100; % Score per option
quiz.table{3,4}.opttol=20; % tolerance in percentage %
quiz.table{3,4}.weight='1'; % Item weight
quiz.table{3,4}.type='NUMERICAL';

quiz.table{3,5}.header = 'VRc (escala)';
quiz.table{3,5}.units='V';
quiz.table{3,5}.options='vrc';
quiz.table{3,5}.vartype='meas'; % Single only
quiz.table{3,5}.optscore=100; % Score per option
quiz.table{3,5}.opttol=20; % tolerance in percentage %
quiz.table{3,5}.weight='1'; % Item weight
quiz.table{3,5}.type='SCALE';


quiz.tablecaption{4}='Tabela 4: Grandezas calculadas com base na tabela 03.';
quiz.tablequestion{4}='Calcule as grandezas da tabela 4 com base nas medições da tabela 3;';
t=4;
c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2;
quiz.table{t,c}.header = 'IRb (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='q1:Ib';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';


c=3;
quiz.table{t,c}.header = 'IRc (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='q1:Ic';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';


c=4;
quiz.table{t,c}.header = 'IRc/IRb (calculado)';
quiz.table{t,c}.units='A/A';
quiz.table{t,c}.options='beta';
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










