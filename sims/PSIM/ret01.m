clear all
clc

% Sets simulation dir
quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\PSIM\'];
% Config simulation
circuit.parname={'Vi','fi','Von','ron','R0'}; % Variables names


% Simulation setup 
circuit.PSIMCMD.name = 'ret01'; % File name
circuit.PSIMCMD.simsdir=quiz2matlabspdir; % PSIM file dir
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=0; % Delete tmp files?
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; % No output is saved before this time. 
circuit.PSIMCMD.printstep=1; % Print step (default = 1).  

circuit.PSIMCMD.net.run = 1; % run simulation fron netlist file?
circuit = getpsimnet(circuit); % Generates net file from psim


%% Parameters setup

circuit.parvalue=[10 150 0 0 15]; % Variables values
nper=1; % Number of periods
circuit.PSIMCMD.totaltime=nper/circuit.parvalue(2); % Total simulation time, in sec.


% Runs simulation
circuit = psimfromcmd(circuit); % Simula via CMD




%% Simview

circuit = simview2matlab(circuit); % Importa dados do simview
circuit = simview2data(circuit); % Gera dados para o plot
circuit = simview2plot(circuit); % Plots simview


