clear all
clc

% Sets simulation dir
% quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
quiz2matlabdir='A:\Dropbox\GitHub\quiz2matlab'; % UTFPR

quiz2matlabsdir=[quiz2matlabdir '\sims'];
quiz2matlabspdir=[quiz2matlabsdir '\Ngspice'];

% Config simulation
circuit.parname={'Vi','R1','R2'}; % Variables names
circuit.parvalue=[10 1e3 1e3]; % Variables values
circuit.parunit={' V','&Omega;','&Omega;'}; % Variables unit
circuit.parstr = param2str(circuit);

circuit.Ngspice.name = 'netfiletest'; % File name
circuit.Ngspice.simsdir=quiz2matlabspdir; % PSIM file dir
circuit.LTspice.net.file = [circuit.Ngspice.simsdir '\' circuit.Ngspice.name '.net'];
 
circuit = ltnet2ngcir(circuit); % Generates the .cir file from LTspice
% net file

circuit = ngspicegetnet(circuit); % Reads .cir file


%% circuit.LTspice.type='op'; % tran, ac, dc, noise, tf, op 

circuit.Ngspice.tmpfile=1; % Create tmp file?
circuit.Ngspice.tmpdir=1; % Use system temp dir?
circuit.Ngspice.tmpfiledel=1; % Delete tmp files?

circuit = ngspicefromcmd(circuit); % run Ngspice simulation


% circuit.Ngspice.cir.file
% [circuit] = ltlogread(circuit);

% circuit.LTspice.net.lines
% circuit.LTspice.log.lines

% data = LTspiceASCII2Matlab(circuit.LTspice.raw.file,1);


