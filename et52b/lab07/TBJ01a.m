% LTspice Table Test

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'TBJ01a'; % File name
circuit.dir = getsimdir([circuit.name '.m'],'LTspice'); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Rb','Rc'}; % Variables names
circuit.parname={'Vcc','Rb','Rc'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [5 10];

Rb = combres(1,10000,'E12'); % 12 resistores
Rc = combres(1,10,'E12'); % 12 resistores
circuit.X=CombVec(Rb,Rc);
circuit.timeout = 5; % Simulation timeout in seconds

circuit.nsims=length(circuit.X);
% circuit.multiplesims=[5 5]; % Number of simulations
circuit.nsims = 5; % Numero de circuitos a serem simulados

% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);
circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
circuit.LTspice.net.run =1;

quiz.tbjtype = 'q1:npn';
quiz.tbjeval = 0; % Evaluate tbj op

%%
quiz.enunciado = 'Simule no LTspice o circuito apresentado na Figura 1 e preencha as tabelas a seguir:';

t=1;
quiz.tablecaption{t}='Tabela 1: Grandezas medidas (Valor médio)!';
quiz.tablequestion{t}='Analogia de medição com o multímetro digital no modo CC:';

c=1;
quiz.table{1,1}.header = 'Vcc';
quiz.table{1,1}.units='V';
quiz.table{1,1}.options='Vv1';
quiz.table{1,1}.vartype='op'; %
quiz.table{1,1}.optscore=100; % Score per option
quiz.table{1,1}.opttol=20; % tolerance in percentage %
quiz.table{1,1}.type='STRING';

c=c+1;
quiz.table{1,2}.header = 'Vbe (medido)';
quiz.table{1,2}.units='V';
quiz.table{1,2}.options='q1:Vbe';
quiz.table{1,2}.vartype='log'; % Single only
quiz.table{1,2}.optscore=100; % Score per option
quiz.table{1,2}.opttol=20; % tolerance in percentage %
quiz.table{1,2}.weight='1'; % Item weight
quiz.table{1,2}.type='NUMERICAL';

c=c+1;
quiz.table{1,3}.header = 'Vbe (escala)';
quiz.table{1,3}.units='V';
quiz.table{1,3}.options='q1:Vbe';
quiz.table{1,3}.vartype='log'; % Single only
quiz.table{1,3}.optscore=100; % Score per option
quiz.table{1,3}.opttol=20; % tolerance in percentage %
quiz.table{1,3}.weight='1'; % Item weight
quiz.table{1,3}.type='SCALE';

c=c+1;
quiz.table{1,4}.header = 'Vbc (medido)';
quiz.table{1,4}.units='V';
quiz.table{1,4}.options='q1:Vbc';
quiz.table{1,4}.vartype='log'; % Single only
quiz.table{1,4}.optscore=100; % Score per option
quiz.table{1,4}.opttol=20; % tolerance in percentage %
quiz.table{1,4}.weight='1'; % Item weight
quiz.table{1,4}.type='NUMERICAL';

c=c+1;
quiz.table{1,5}.header = 'Vbc (escala)';
quiz.table{1,5}.units='V';
quiz.table{1,5}.options='q1:Vbc';
quiz.table{1,5}.vartype='log'; % Single only
quiz.table{1,5}.optscore=100; % Score per option
quiz.table{1,5}.opttol=20; % tolerance in percentage %
quiz.table{1,5}.weight='1'; % Item weight
quiz.table{1,5}.type='SCALE';

c=c+1;
quiz.table{1,6}.header = 'Vce (medido)';
quiz.table{1,6}.units='V';
quiz.table{1,6}.options='q1:Vce';
quiz.table{1,6}.vartype='log'; % Single only
quiz.table{1,6}.optscore=100; % Score per option
quiz.table{1,6}.opttol=20; % tolerance in percentage %
quiz.table{1,6}.weight='1'; % Item weight
quiz.table{1,6}.type='NUMERICAL';

c=c+1;
quiz.table{1,7}.header = 'Vce (escala)';
quiz.table{1,7}.units='V';
quiz.table{1,7}.options='q1:Vce';
quiz.table{1,7}.vartype='log'; % Single only
quiz.table{1,7}.optscore=100; % Score per option
quiz.table{1,7}.opttol=20; % tolerance in percentage %
quiz.table{1,7}.weight='1'; % Item weight
quiz.table{1,7}.type='SCALE';

t=2;
quiz.tablecaption{t}='Tabela 2: Polarização das junções BE e BC e modo de operação do transistor TBJ.';
quiz.tablequestion{t}='Complete a tabela abaixo com base nos valores medidos na Tabela 1.';

c=1;
quiz.table{2,1}.header = 'Vcc';
quiz.table{2,1}.units='V';
quiz.table{2,1}.options='Vv1';
quiz.table{2,1}.vartype='op'; %
quiz.table{2,1}.optscore=100; % Score per option
quiz.table{2,1}.opttol=20; % tolerance in percentage %
quiz.table{2,1}.type='STRING';

c=c+1;
quiz.table{2,2}.header = 'Polarização BE';
quiz.table{2,2}.units='V';
quiz.table{2,2}.options='q1:npn';
quiz.table{2,2}.vartype='pbe'; % pbc pbe mop
quiz.table{2,2}.optscore=100; % Score per option
quiz.table{2,2}.opttol=20; % tolerance in percentage %
quiz.table{2,2}.weight='1'; % Item weight
quiz.table{2,2}.type='TBJ';

c=c+1;
quiz.table{2,3}.header = 'Polarização BC';
quiz.table{2,3}.units='V';
quiz.table{2,3}.options='q1:npn';
quiz.table{2,3}.vartype='pbc'; % pbc pbe mop
quiz.table{2,3}.optscore=100; % Score per option
quiz.table{2,3}.opttol=20; % tolerance in percentage %
quiz.table{2,3}.weight='1'; % Item weight
quiz.table{2,3}.type='TBJ';

c=c+1;
quiz.table{2,4}.header = 'Modo';
quiz.table{2,4}.units='V';
quiz.table{2,4}.options='q1:npn';
quiz.table{2,4}.vartype='mop'; % pbc pbe mop
quiz.table{2,4}.optscore=100; % Score per option
quiz.table{2,4}.opttol=20; % tolerance in percentage %
quiz.table{2,4}.weight='1'; % Item weight
quiz.table{2,4}.type='TBJ';

%% 
t=3;
quiz.tablecaption{t}='Tabela 3: Grandezas medidas (Valor médio)!';
quiz.tablequestion{t}='Analogia de medição com o multímetro digital no modo CC:';

c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vv1';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=c+1;
quiz.table{t,c}.header = 'VRb (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vrb';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;
quiz.table{t,c}.header = 'VRb (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vrb';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=c+1;
quiz.table{t,c}.header = 'VRc (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vrc';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;
quiz.table{t,c}.header = 'VRc (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vrc';
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

c=c+1;
quiz.table{t,c}.header = 'IRb (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='q1:Ib';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;
quiz.table{t,c}.header = 'IRc (calculado)';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='q1:Ic';
quiz.table{t,c}.vartype='log'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;
quiz.table{t,c}.header = 'IRc/IRb (calculado)';
quiz.table{t,c}.units='A/A';
quiz.table{t,c}.options='beta';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';



%% Generate quizes
if quizcircheck(circuit,quiz) % Verify data entry
    if isfield(circuit,'multiplesims')
        for ms=1:length(circuit.multiplesims)
            circuit.nsims=circuit.multiplesims(ms); % Number of simulations
            quiz.nquiz = circuit.nsims;
            ltspicetable2xml(circuit,quiz); %
        end
    else
        quiz.nquiz = circuit.nsims;
        ltspicetable2xml(circuit,quiz); %
    end    
else
    disp('Verify data entry!!')
end










