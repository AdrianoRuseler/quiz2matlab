

function psim2xml(circuit,quiz)


circuit.PSIMCMD.name = circuit.name; % File name
circuit.PSIMCMD.simsdir=circuit.dir; % PSIM file dir

% Simulation control settings
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?
circuit.PSIMCMD.totaltime=10E-005; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=0; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

circuit = getpsimnet(circuit); % Reads or generates net file from psim
circuit.PSIMCMD.net.run = 1;

sortnquestions=500; % Number of simulations
[~,y]=size(circuit.Xi);
nq=randperm(y,sortnquestions); % escolha as questoes
circuit.X=circuit.Xi(:,nq);


for c=1:length(circuit.X)
    tmpcircuits{c}=circuit;
    tmpcircuits{c}.parvalue=circuit.X(:,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
end

%   Runs simulation OK!
[~,y]=size(circuit.X);
parfor n=1:y
    tmpcircuits{n} = psimfromcmd(tmpcircuits{n}); % Simula via CMD
end
% tmpcircuits=circuits;

% Clear empty simulated data
y=1;
for c=1:length(tmpcircuits)
    if isfield(tmpcircuits{c}.PSIMCMD,'data')
        circuits{y}=tmpcircuits{c};
        y=y+1;
    else
        disp(['No data file in simulation ' num2str(c) ' with ' tmpcircuits{c}.parstr '!'])
    end
end



pngfile=[circuit.dir circuit.name '.png']; % Fig png file
imgout=[circuit.dir circuit.name 'clean.png']; % Fig png file
pngchangewhite(pngfile,imgout,'clean')

quiz.name = [circuit.name 'quiz'];
for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura
    circuits{n}.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig     
    circuits{n} = psimXmultichoice(circuits{n}); % Generate multichoice        
    circuits{n} = quiztextgen(circuits{n}); % Generates quiz text field    
end

%% Generate quizstruct moodle question
quizopts.name=[circuit.name 'quiz'];
quizopts.nquiz=250; % Number of quizes
quizopts.permutquiz =1; % Permut quiz?
quizopts.nquizperxml=500; % Number of quizes per file
quizopts.type = 'cloze';
quizopts.xmlpath = [ pwd '\xmlfiles']; % Folder for xml files
quizopts.generalfeedback='';
quizopts.penalty='0.25';
quizopts.hidden='0';

quizstruct = psimclozegen(circuits,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file

