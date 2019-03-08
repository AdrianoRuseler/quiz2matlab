
quiz2matlabdir='F:\Dropbox\GitHub\quiz2matlab';
quiz2matlabspdir=[quiz2matlabsdir '\PSIM'];
circuit.parname={'Vi','fi','R1','R2'}; % Variables names
circuit.parvalue=[10 100 1e3 1e3]; % Variables values
circuit.PSIMCMD.name = 'plottest'; % File name
circuit.PSIMCMD.simsdir=quiz2matlabspdir; % PSIM file dir
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?

% Simulação 
circuit.PSIMCMD.totaltime=0.01; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

circuit = psimfromcmd(circuit); % Simula via CMD