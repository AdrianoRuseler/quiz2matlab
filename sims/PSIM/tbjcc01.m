clear all
clc

% Sets simulation dir
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
% circuit.name = 'zener01'; % File name
circuit.parname={'Vcc','Rb','Rc','Beta','Vbe','Vcesat'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;','','V','V'}; % Variables unit

% Simulation setup 
circuit.name = 'tbjcc01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost


% parameters input
Vcc=15:5:30; 
% Vz=[2.7 3.3 3.9 4.7 5.6  6.8  8.2 3.0 3.6 4.3 5.1 6.2 7.5 9.1];
Rb = combres(1,[1000],'E12'); %
Rc = combres(1,[100],'E12'); %
Vbe=0.7;
Beta=[50:50:350];
Vcesat=0.2;

circuit.Xi=CombVec(Vcc,Rb,Rc,Beta,Vbe,Vcesat); %%


% Select
[~,y]=size(Xi);
u0=1;
for z=1:y
    R1=Xi(1,z); % R
    R2=Xi(2,z); % R
    RC=Xi(3,z); % R
    RE=Xi(4,z); % R  
    VEE=Xi(5,z);
    Beta=Xi(6,z);
    Veb=Xi(7,z);
    VecSat=Xi(8,z);
    
    Rx=RE+RC;
    
    iB=(VEE*R1^2-(R1^2+R2^2)*Veb)/(R1^2*R2^2 +(Rx*R1^2+R2^2*RE)*(Beta+1));
    iCsat=(VEE-VecSat)/Rx;

    if (iCsat-Beta*iB)>0 % Regi�o ativa
        X0(:,u0)=Xi(:,z);
        u0=u0+1;
    end    
end

%%


% Generate question
quiz.enunciado = ['Para o circuito contendo um transistor NPN apresentado na Figura 1, determine:' ]; % Enunciado da pergunta!

quiz.question{1}.str='a) Qual o valor da corrente de base?';
quiz.question{1}.units={'A'};
quiz.question{1}.options={'IRb'};
quiz.question{1}.vartype={'mean'}; %
quiz.question{1}.optscore=[100]; % Score per option
quiz.question{1}.opttol=[10]; % tolerance in percentage %
quiz.question{1}.type='NUMERICAL';

quiz.question{2}.str='b) Qual o valor da corrente de coletor?';
quiz.question{2}.units={'A'};
quiz.question{2}.options={'IRc'};
quiz.question{2}.vartype={'mean'}; %
quiz.question{2}.optscore=[100]; % Score per option
quiz.question{2}.opttol=[10]; % tolerance in percentage %
quiz.question{2}.type='NUMERICAL';

% quiz.question{3}.str='c) Qual o valor da pot�ncia m�dia dissipada no diodo zener?';
% quiz.question{3}.units={'W'};
% quiz.question{3}.options={'Pz'};
% quiz.question{3}.vartype={'mean'}; %
% quiz.question{3}.optscore=[100]; % Score per option
% quiz.question{3}.opttol=[10]; % tolerance in percentage %
% quiz.question{3}.type='NUMERICAL';
% 
% quiz.question{4}.str='d) Qual o valor da corrente m�dia no resistor R2?';
% quiz.question{4}.units={'A'};
% quiz.question{4}.options={'IR2'};
% quiz.question{4}.vartype={'mean'}; %
% quiz.question{4}.optscore=[100]; % Score per option
% quiz.question{4}.opttol=[10]; % tolerance in percentage %
% quiz.question{4}.type='NUMERICAL';
% 
% quiz.question{5}.str='e) Qual o valor da corrente m�dia no resistor R1?';
% quiz.question{5}.units={'A'};
% quiz.question{5}.options={'IR1'};
% quiz.question{5}.vartype={'mean'}; %
% quiz.question{5}.optscore=[100]; % Score per option
% quiz.question{5}.opttol=[10]; % tolerance in percentage %
% quiz.question{5}.type='NUMERICAL';


%% Generates questions

circuit.nsims=505; % Number of simulations
quiz.nquiz = 500; % Number of quizes

psimdc2xml(circuit,quiz); 

