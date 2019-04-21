clear all
clc

circuit.dir = getsimdir('logtest.m'); % Sets simulation dir
circuit.LTspice.log.file=[circuit.dir 'DR01op.log'];

%%

[circuit] = ltlogread(circuit);

%%


clc
clear all
% tline=circuit.LTspice.log.lines;

circuit.name = 'TBJ01'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir
circuit.theme  = 'clean'; % clean or boost

% Config simulation
circuit.parnamesim={'Vcc','Rb','Rc'}; % Variables names
circuit.parname={'Vcc','Rb','Rc'}; % Variables names
circuit.parunit={'V','&Omega;','&Omega;'}; % Variables unit


circuit.parvalue=[50 680e3 150]; % Variables values
circuit.parstr = param2str(circuit);

circuit.LTspice.name = circuit.name; % File name
circuit.LTspice.simsdir=circuit.dir; % PSIM file dir

circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file

circuit.LTspice.tmpfile=1; % Create tmp file?
circuit.LTspice.tmpdir=1; % Use system temp dir?
circuit.LTspice.tmpfiledel=1; % Delete tmp files?
circuit = ltspicefromcmd(circuit); % run LTspice simulation

%%  

[circuit] = ltlogread(circuit);