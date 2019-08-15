% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'TBJ04a'; % File name
circuit.dir = getsimdir([circuit.name '.m'],'LTspice'); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Rb','Rc'}; % Variables names
circuit.parname={'Vcc','Rb','Rc'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [15];

Rb = combres(1,10000,'E12'); % 12 resistores
Rc = combres(1,10,'E12'); % 12 resistores
% Re = combres(1,10,'E12'); % 12 resistores

circuit.X=CombVec(Rb,Rc);

% circuit.Xi(3,:)=circuit.Xi(2,:);
% % 
% circuit.X = circuit.Xi;
% 
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
quiz.tablecaption{t}='Tabela 1: Grandezas medidas com mult�metro digital (Valor m�dio)!';
quiz.tablequestion{t}='Utilize o mult�metro digital no modo CC:';
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


quiz.tablecaption{2}='Tabela 2: Polariza��o das jun��es BE e BC e modo de opera��o do transistor TBJ.';
quiz.tablequestion{2}='Complete a tabela abaixo com base nos valores medidos na Tabela 1.';

t=2;
quiz.table{t,1}.header = 'Vcc';
quiz.table{t,1}.units='V';
quiz.table{t,1}.options='Vv1';
quiz.table{t,1}.vartype='op'; %
quiz.table{t,1}.optscore=100; % Score per option
quiz.table{t,1}.opttol=20; % tolerance in percentage %
quiz.table{t,1}.type='STRING';

quiz.table{t,2}.header = 'Polariza��o BE';
quiz.table{t,2}.units='V';
quiz.table{t,2}.options='q1:npn';
quiz.table{t,2}.vartype='pbe'; % pbc pbe mop
quiz.table{t,2}.optscore=100; % Score per option
quiz.table{t,2}.opttol=20; % tolerance in percentage %
quiz.table{t,2}.weight='1'; % Item weight
quiz.table{t,2}.type='TBJ';

quiz.table{t,3}.header = 'Polariza��o BC';
quiz.table{t,3}.units='V';
quiz.table{t,3}.options='q1:npn';
quiz.table{t,3}.vartype='pbc'; % pbc pbe mop
quiz.table{t,3}.optscore=100; % Score per option
quiz.table{t,3}.opttol=20; % tolerance in percentage %
quiz.table{t,3}.weight='1'; % Item weight
quiz.table{t,3}.type='TBJ';

quiz.table{t,4}.header = 'Modo';
quiz.table{t,4}.units='V';
quiz.table{t,4}.options='q1:npn';
quiz.table{t,4}.vartype='mop'; % pbc pbe mop
quiz.table{t,4}.optscore=100; % Score per option
quiz.table{t,4}.opttol=20; % tolerance in percentage %
quiz.table{t,4}.weight='1'; % Item weight
quiz.table{t,4}.type='TBJ';




quiz.tablecaption{3}='Tabela 3: Grandezas medidas com mult�metro digital (Valor m�dio)!';
quiz.tablequestion{3}='Utilize o mult�metro digital no modo CC:';

t=3;
c=1;
quiz.table{t,1}.header = 'Vcc';
quiz.table{t,1}.units='V';
quiz.table{t,1}.options='Vv1';
quiz.table{t,1}.vartype='op'; %
quiz.table{t,1}.optscore=100; % Score per option
quiz.table{t,1}.opttol=20; % tolerance in percentage %
quiz.table{t,1}.type='STRING';

quiz.table{t,2}.header = 'VRb (medido)';
quiz.table{t,2}.units='V';
quiz.table{t,2}.options='vrb';
quiz.table{t,2}.vartype='meas'; % Single only
quiz.table{t,2}.optscore=100; % Score per option
quiz.table{t,2}.opttol=20; % tolerance in percentage %
quiz.table{t,2}.weight='1'; % Item weight
quiz.table{t,2}.type='NUMERICAL';

quiz.table{t,3}.header = 'VRb (escala)';
quiz.table{t,3}.units='V';
quiz.table{t,3}.options='vrb';
quiz.table{t,3}.vartype='meas'; % Single only
quiz.table{t,3}.optscore=100; % Score per option
quiz.table{t,3}.opttol=20; % tolerance in percentage %
quiz.table{t,3}.weight='1'; % Item weight
quiz.table{t,3}.type='SCALE';

quiz.table{t,4}.header = 'VRc (medido)';
quiz.table{t,4}.units='V';
quiz.table{t,4}.options='vrc';
quiz.table{t,4}.vartype='meas'; % Single only
quiz.table{t,4}.optscore=100; % Score per option
quiz.table{t,4}.opttol=20; % tolerance in percentage %
quiz.table{t,4}.weight='1'; % Item weight
quiz.table{t,4}.type='NUMERICAL';

quiz.table{t,5}.header = 'VRc (escala)';
quiz.table{t,5}.units='V';
quiz.table{t,5}.options='vrc';
quiz.table{t,5}.vartype='meas'; % Single only
quiz.table{t,5}.optscore=100; % Score per option
quiz.table{t,5}.opttol=20; % tolerance in percentage %
quiz.table{t,5}.weight='1'; % Item weight
quiz.table{t,5}.type='SCALE';


% c=4;
% quiz.table{t,c}.header = 'VRe (medido)';
% quiz.table{t,c}.units='V';
% quiz.table{t,c}.options='vre';
% quiz.table{t,c}.vartype='meas'; % Single only
% quiz.table{t,c}.optscore=100; % Score per option
% quiz.table{t,c}.opttol=20; % tolerance in percentage %
% quiz.table{t,c}.weight='1'; % Item weight
% quiz.table{t,c}.type='NUMERICAL';
% c=5;
% quiz.table{t,c}.header = 'VRe (escala)';
% quiz.table{t,c}.units='V';
% quiz.table{t,c}.options='vre';
% quiz.table{t,c}.vartype='meas'; % Single only
% quiz.table{t,c}.optscore=100; % Score per option
% quiz.table{t,c}.opttol=20; % tolerance in percentage %
% quiz.table{t,c}.weight='1'; % Item weight
% quiz.table{t,c}.type='SCALE';




quiz.tablecaption{4}='Tabela 4: Grandezas calculadas com base na tabela 03.';
quiz.tablequestion{4}='Calcule as grandezas da tabela 4 com base nas medi��es da tabela 3;';
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


c=4;
quiz.table{t,c}.header = 'Ic (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='q1:Ic';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=3;
quiz.table{t,c}.header = 'IRc (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='IRc';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=5;
quiz.table{t,c}.header = 'Ic/Ib (calculado)';
quiz.table{t,c}.units='A/A';
quiz.table{t,c}.options='beta';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';




t=5;
quiz.tablecaption{t}='Tabela 5: Grandezas calculadas com base na tabela 03 e tabela 04.';
quiz.tablequestion{t}='Calcule a pot�ncia dissipada nos resistores com base nas medi��es da tabela 3 e c�lculos da tabela 4;';

c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=2;
quiz.table{t,c}.header = 'PRb (calculado)';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='prb';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';


c=3;
quiz.table{t,c}.header = 'PRc (calculado)';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='prc';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

% c=3;
% quiz.table{t,c}.header = 'PRe (calculado)';
% quiz.table{t,c}.units='W';
% quiz.table{t,c}.options='pre';
% quiz.table{t,c}.vartype='meas'; % Single only
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










