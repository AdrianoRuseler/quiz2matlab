% LTspice Table Test
% .include C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab14\LMx24.lib

clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'lab01a'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'boost'; % clean or boost, classic

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
% circuit.multiplesims=[5 5]; % Number of simulations
circuit.nsims = 5; % Numero de circuitos a serem simulados

% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);
circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
circuit.LTspice.net.run = 0;

quiz.tbjtype = 'm1:nmos';
quiz.tbjeval = 0; % Evaluate tbj op

%%


% Figura 1: Considere o MOSFET sendo o contido no CI4007
quiz.enunciado = 'Monte o circuito apresentado na Figura 1 e preencha as tabelas a seguir:';

t=1; % Table
quiz.tablecaption{t}='Tabela 1: Grandezas medidas com multímetro digital (Valor médio)!';
quiz.tablequestion{t}='Utilize o multímetro digital no modo CC:';


c=1; % Coluna
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=c+1; % Coluna
quiz.table{t,c}.header = 'Vcc (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;  % Coluna
quiz.table{t,c}.header = 'Vcc (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=c+1;  % Coluna
quiz.table{t,c}.header = 'VR1 (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vr1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;  % Coluna
quiz.table{t,c}.header = 'VR1 (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vr1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';

c=c+1;  % Coluna
quiz.table{t,c}.header = 'VD1 (medido)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vd';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1;  % Coluna
quiz.table{t,c}.header = 'VD1 (escala)';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='vd';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='SCALE';


%
t=2;
quiz.tablecaption{t}='Tabela 2: Grandezas calculadas com base na tabela 01.';
quiz.tablequestion{t}='Calcule as grandezas da tabela 2 com base nas medições da tabela 1;';

c=1;
quiz.table{t,c}.header = 'Vcc';
quiz.table{t,c}.units='V';
quiz.table{t,c}.options='Vcc';
quiz.table{t,c}.vartype='op'; %
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.type='STRING';

c=c+1; 
quiz.table{t,c}.header = 'iD1';
quiz.table{t,c}.units='A';
quiz.table{t,c}.options='id1';
quiz.table{t,c}.vartype='op'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1; 
quiz.table{t,c}.header = 'pD1';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pd';
quiz.table{t,c}.vartype='meas'; % Single only
quiz.table{t,c}.optscore=100; % Score per option
quiz.table{t,c}.opttol=20; % tolerance in percentage %
quiz.table{t,c}.weight='1'; % Item weight
quiz.table{t,c}.type='NUMERICAL';

c=c+1; 
quiz.table{t,c}.header = 'pR1';
quiz.table{t,c}.units='W';
quiz.table{t,c}.options='pr';
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




