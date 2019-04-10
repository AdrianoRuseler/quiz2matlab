% harmonics
clear all
clc


% quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab'; % Home
% circuit.dir='F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % Home
% circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\'; % UTFPR

% Config simulation
circuit.parname={'Vi','fi','vh1','fh1','vh2','fh2'}; % Variables names
circuit.parunit={'V','Hz','V','Hz','V','Hz'}; % Variables unit

% Simulation setup 
circuit.name = 'harmonics'; % File name
circuit.dir = getsimdir([circuit.name '.m']); % Sets simulation dir

circuit.parvalue=[380 60 25 3*60 15 5*60]; % Variables values

circuit.parstr = param2str(circuit);
circuit.PSIMCMD.name = circuit.name; % File name
circuit.PSIMCMD.simsdir = circuit.dir; % PSIM file dir
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?

% Simulation control settings
circuit.PSIMCMD.data.cycles = 10;
circuit.PSIMCMD.data.fundamental = circuit.parvalue(2);
circuit.PSIMCMD.totaltime=circuit.PSIMCMD.data.cycles/circuit.PSIMCMD.data.fundamental; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; % No output is saved before this time. 
circuit.PSIMCMD.printstep=1; % Print step (default = 1). 
% Runs simulation
circuit = getpsimnet(circuit); % Reads or generates net file from psim
circuit.PSIMCMD.net.run = 1;

circuit = psimfromcmd(circuit); % Simula via CMD

%%

datain = circuit.PSIMCMD.data;

%           time: [16667×1 double]
%             Ts: 1.0000e-05
%        signals: [1×3 struct]
%      blockName: 'harmonicsb75a55b6d96948b8be023605a475f248'
%     PSIMheader: {4×1 cell}
    
datain.input = 'Va'; % teste!!
datain.startTime=datain.time(1);
datain.maxFrequency = 1000;
datain.THDmaxFrequency  = 1000;

power_fftscope(datain)



% time	The time vector of the simulation data signal saved in the ScopeData variable.
% signals	The signals saved in the ScopeData variable.
% blockName	The name of the Scope block associated to the ScopeData variable.
% input	The input signal of the selected simulation data variable.
% signal	The index of the selected input signal specified by the input field.
% startTime	The start time of the FFT window.
% cycles	The number of cycles of the FFT window.
% fundamental	The fundamental frequency of analyzed signal.
% maxFrequency	The maximum frequency evaluated by the FFT analysis.
% THDmaxFrequency	The maximum frequency for the THD calculation. Set the value to inf to calculate the THD at the Nyquist frequency.
% FFTdata	The analyzed signal (FFT window data).
% THDbase	The base used to compute the THD. Set to fund to normalize the THD with respect to fundamental value. Set the THDbase to DC to normalize the THD with respect to the DC component value.
% freqAxis	The type of frequency axis, in hertz or harmonic orders, of the FFT analysis plot.
% mag	The computed magnitude of FFT.
% phase	The computed phase of FFT.
% freq	The frequency vector.
% THD	The computed total harmonic distortion for the analyzed signal. The THD calculation includes all the inter-harmonics of the selected input signal.
% samplingTime	Return the sampling time of the selected input signal.
% samplePerCycle	Return the number of samples per cycle of the selected input signal.
% DCcomponent	Return the DC component value of the selected input signal.
% magFundamental	Return the fundamental component value of the selected input signal.