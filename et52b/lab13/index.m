

circuit.name = 'lab13a'; % File name
circuit.dir = 'A:\Dropbox\GitHub\quiz2matlab\et52b\lab13\'; % Sets simulation dir
% circuit.dir = 'C:\Users\adria\Dropbox\GitHub\quiz2matlab\et52b\lab12\'; % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost, classic

% Config simulation
circuit.parnamesim={'Vi','Vpp','Vnn','RL'}; % Variables names
circuit.parname={'Vi','Vpp','Vnn','RL'}; % Variables names
circuit.parunit={'V','V','V','&Omega;'}; % Variables unit

% circuit.stepstr = '.step param Vcc list 1 2 3 4 5';
% circuit.parstep = 1; % Must be the first
circuit.stepvalues = [-5 -4 -3 -2 -1 1 2 3 4 5];
circuit.steppedstr='.step param Vi -5 5 1';


% Rd = combres(1,100,'E12'); % 12 resistores
Vpp=5;
Vnn=5;
Rl = combres(1,100,'E12'); % 12 resistores
% Rc = combres(1,10,'E12'); % 12 resistores
circuit.X=CombVec(Vpp,Vnn,Rl);


circuit.nsims=length(circuit.X);
% circuit.nsims=5; % Number of simulations
% [~,y]=size(circuit.Xi);
% nq=randperm(y,circuit.nsims); % escolha as questoes
% circuit.X=circuit.Xi(:,nq);
circuit.cmdtype = '.op'; % Operation Point Simulation
circuit.cmdupdate = 0;
quiz.tbjtype = 'm1:nmos';
quiz.tbjeval = 0; % Evaluate tbj op


circuit.LTspice.name = circuit.name; % File name
circuit.LTspice.simsdir= circuit.dir; % sim file dir

circuit.LTspice.tmpfile = 1; % Create tmp file?
circuit.LTspice.tmpdir = 1; % Use system temp dir?
circuit.LTspice.tmpfiledel = 1; % Delete tmp files?
circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file



circuit2 = ltspicefromcmd(circuit)



