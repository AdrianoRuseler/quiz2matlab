% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'TBJ05a'; % File name
circuit.dir = getsimdir([circuit.name '.m'],'LTspice'); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Re','R1','R2'}; % Variables names
circuit.parname={'Vcc','Re','R1','R2'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [15];

R1 = combres(1,10000,'E12'); % 12 resistores
% R2 = combres(1,10000,'E12'); % 12 resistores
% Rc = combres(1,10,'E12'); % 12 resistores
Re = combres(1,10,'E12'); % 12 resistores

circuit.Xi=CombVec(Re,R1);

circuit.Xi(3,:)=circuit.Xi(2,:);
% 
circuit.X = circuit.Xi;
% 
circuit.nsims=length(circuit.X);


% circuit.nsims=5; % Number of simulations
% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);
circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
quiz.tbjtype = 'q1:pnp';
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




quiz.enunciado = 'Monte o circuito apresentado na Figura 1 e preencha as tabelas a seguir:';
t=1;
quiz.tablecaption{t}='Tabela 1: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{t}='Utilize o multímetro digital no modo CC:';
c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';
c=2;
quiz.table{t,c}.header = 'Vbe (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='q1:Vbe';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

quiz.table{t,3}.header = 'Vbe (escala)';
quiz.table{t,3}.units='V';
quiz.table{t,3}.options='q1:Vbe';
quiz.table{t,3}.vartype='log'; % Single only
quiz.table{t,3}.optscore=100; % Score per option
quiz.table{t,3}.opttol=20; % tolerance in percentage %
quiz.table{t,3}.weight='1'; % Item weight
quiz.table{t,3}.type='SCALE';

quiz.table{t,4}.header = 'Vbc (medido)';
quiz.table{t,4}.units='V';
quiz.table{t,4}.options='q1:Vbc';
quiz.table{t,4}.vartype='log'; % Single only
quiz.table{t,4}.optscore=100; % Score per option
quiz.table{t,4}.opttol=20; % tolerance in percentage %
quiz.table{t,4}.weight='1'; % Item weight
quiz.table{t,4}.type='NUMERICAL';

quiz.table{t,5}.header = 'Vbc (escala)';
quiz.table{t,5}.units='V';
quiz.table{t,5}.options='q1:Vbc';
quiz.table{t,5}.vartype='log'; % Single only
quiz.table{t,5}.optscore=100; % Score per option
quiz.table{t,5}.opttol=20; % tolerance in percentage %
quiz.table{t,5}.weight='1'; % Item weight
quiz.table{t,5}.type='SCALE';

quiz.table{t,6}.header = 'Vce (medido)';
quiz.table{t,6}.units='V';
quiz.table{t,6}.options='q1:Vce';
quiz.table{t,6}.vartype='log'; % Single only
quiz.table{t,6}.optscore=100; % Score per option
quiz.table{t,6}.opttol=20; % tolerance in percentage %
quiz.table{t,6}.weight='1'; % Item weight
quiz.table{t,6}.type='NUMERICAL';

quiz.table{t,7}.header = 'Vce (escala)';
quiz.table{t,7}.units='V';
quiz.table{t,7}.options='q1:Vce';
quiz.table{t,7}.vartype='log'; % Single only
quiz.table{t,7}.optscore=100; % Score per option
quiz.table{t,7}.opttol=20; % tolerance in percentage %
quiz.table{t,7}.weight='1'; % Item weight
quiz.table{t,7}.type='SCALE';


quiz.tablecaption{2}='Tabela 2: Polarização das junções BE e BC e modo de operação do transistor TBJ.';
quiz.tablequestion{2}='Complete a tabela abaixo com base nos valores medidos na Tabela 1.';

t=2;
quiz.table{t,1}.header = 'Vcc';
quiz.table{t,1}.units='V';
quiz.table{t,1}.options='Vv1';
quiz.table{t,1}.vartype='op'; %
quiz.table{t,1}.optscore=100; % Score per option
quiz.table{t,1}.opttol=20; % tolerance in percentage %
quiz.table{t,1}.type='STRING';

quiz.table{t,2}.header = 'Polarização EB';
quiz.table{t,2}.units='V';
quiz.table{t,2}.options='q1:pnp';
quiz.table{t,2}.vartype='peb'; % pbc pbe mop
quiz.table{t,2}.optscore=100; % Score per option
quiz.table{t,2}.opttol=20; % tolerance in percentage %
quiz.table{t,2}.weight='1'; % Item weight
quiz.table{t,2}.type='TBJ';

quiz.table{t,3}.header = 'Polarização CB';
quiz.table{t,3}.units='V';
quiz.table{t,3}.options='q1:pnp';
quiz.table{t,3}.vartype='pcb'; % pbc pbe mop
quiz.table{t,3}.optscore=100; % Score per option
quiz.table{t,3}.opttol=20; % tolerance in percentage %
quiz.table{t,3}.weight='1'; % Item weight
quiz.table{t,3}.type='TBJ';

quiz.table{t,4}.header = 'Modo';
quiz.table{t,4}.units='V';
quiz.table{t,4}.options='q1:pnp';
quiz.table{t,4}.vartype='mop'; % pbc pbe mop
quiz.table{t,4}.optscore=100; % Score per option
quiz.table{t,4}.opttol=20; % tolerance in percentage %
quiz.table{t,4}.weight='1'; % Item weight
quiz.table{t,4}.type='TBJ';




quiz.tablecaption{3}='Tabela 3: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{3}='Utilize o multímetro digital no modo CC:';

t=3;
c=1;
quiz.table{t,1}.header = 'Vcc';
quiz.table{t,1}.units='V';
quiz.table{t,1}.options='Vv1';
quiz.table{t,1}.vartype='op'; %
quiz.table{t,1}.optscore=100; % Score per option
quiz.table{t,1}.opttol=20; % tolerance in percentage %
quiz.table{t,1}.type='STRING';

quiz.table{t,2}.header = 'VR1 (medido)';
quiz.table{t,2}.units='V';
quiz.table{t,2}.options='vr1';
quiz.table{t,2}.vartype='meas'; % Single only
quiz.table{t,2}.optscore=100; % Score per option
quiz.table{t,2}.opttol=20; % tolerance in percentage %
quiz.table{t,2}.weight='1'; % Item weight
quiz.table{t,2}.type='NUMERICAL';

quiz.table{t,3}.header = 'VR1 (escala)';
quiz.table{t,3}.units='V';
quiz.table{t,3}.options='vr1';
quiz.table{t,3}.vartype='meas'; % Single only
quiz.table{t,3}.optscore=100; % Score per option
quiz.table{t,3}.opttol=20; % tolerance in percentage %
quiz.table{t,3}.weight='1'; % Item weight
quiz.table{t,3}.type='SCALE';

quiz.table{t,4}.header = 'VR2 (medido)';
quiz.table{t,4}.units='V';
quiz.table{t,4}.options='vr2';
quiz.table{t,4}.vartype='meas'; % Single only
quiz.table{t,4}.optscore=100; % Score per option
quiz.table{t,4}.opttol=20; % tolerance in percentage %
quiz.table{t,4}.weight='1'; % Item weight
quiz.table{t,4}.type='NUMERICAL';

quiz.table{t,5}.header = 'VR2 (escala)';
quiz.table{t,5}.units='V';
quiz.table{t,5}.options='vr2';
quiz.table{t,5}.vartype='meas'; % Single only
quiz.table{t,5}.optscore=100; % Score per option
quiz.table{t,5}.opttol=20; % tolerance in percentage %
quiz.table{t,5}.weight='1'; % Item weight
quiz.table{t,5}.type='SCALE';


c=6;
quiz.table{t,c}.header = 'VRe (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vre';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';
c=7;
quiz.table{t,c}.header = 'VRe (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vre';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';




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
quiz.table{t,c}.header = 'IR1 (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='IR1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3;
quiz.table{t,c}.header = 'IR2 (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='IR2';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=4;
quiz.table{t,c}.header = 'IRe (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='IRe';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=5;
quiz.table{t,c}.header = 'Ic (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='ic';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=6;
quiz.table{t,c}.header = 'Ib (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='ib';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=7;
quiz.table{t,c}.header = 'Ic/Ib (calculado)';
quiz.table{t,c}.units='A/A';
quiz.table{t,c}.options='q1:BetaDC';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';




t=5;
quiz.tablecaption{t}='Tabela 5: Grandezas calculadas com base na tabela 03 e tabela 04.';
quiz.tablequestion{t}='Calcule a potência dissipada nos resistores com base nas medições da tabela 3 e cálculos da tabela 4;';

c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2;
quiz.table{t,c}.header = 'PR1 (calculado)';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pr1';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3;
quiz.table{t,c}.header = 'PR2 (calculado)';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pr2';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=4;
quiz.table{t,c}.header = 'PRe (calculado)';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pre';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';



%%
quiz.nquiz=length(circuit.X);
% 
% circuit.nsims = 500; % Number of simulations
%  quiz.nquiz = 5; % Number of quizes

ltspicetable2xml(circuit,quiz); % 










