

function psimca2xml(circuit,quiz)


circuit.PSIMCMD.name = circuit.name; % File name
circuit.PSIMCMD.simsdir=circuit.dir; % PSIM file dir

% Simulation control settings
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?

% circuit.PSIMCMD.totaltime=10E-005; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=5E-007; % Simulation time step, in sec.  
% circuit.PSIMCMD.printtime=0; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

circuit.PSIMCMD.net.run = 0; % Flag to use netlist file in simulation
% circuit = getpsimnet(circuit); % Reads or generates net file from psim

% sortnquestions=300; % Number of simulations
[~,y]=size(circuit.Xi);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.X=circuit.Xi(:,nq);

circuit = rmfield(circuit,'Xi');
% circuit.cycles = 3; % Number of periods

[~,y]=size(circuit.X);
for c=1:y
    tmpcircuits{c}=rmfield(circuit,'X'); % Not used here
    tmpcircuits{c}.parnamesim = circuit.parnamesim;
    tmpcircuits{c}.parvalue=circuit.X(:,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
    tmpcircuits{c}.PSIMCMD.totaltime=circuit.cycles/tmpcircuits{c}.parvalue(circuit.fundfreqind); % Total simulation time, in sec.
    tmpcircuits{c}.PSIMCMD.printtime=(circuit.printcycle-1)/tmpcircuits{c}.parvalue(circuit.fundfreqind);   
end

% Eval functions
if isfield(circuit,'funcstr')     
    for c=1:y
        parvalues = tmpcircuits{c}.parvalue; % Its used in function input eval
        for f=1:length(circuit.funcstr) % Functions loop            
            tmpcircuits{c}.funcvalue(f)=eval(circuit.funcstr{f}); % Eval functions
        end
    end
end


%  Runs simulation OK!
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

if ~exist('circuits','var')
    return
end

if ~isfield(quiz,'nquiz')
    quiz.nquiz=length(circuits);
end

pngfile=[circuit.dir circuit.name '.png']; % Fig png file

if isfield(circuit,'theme')
    imgout=[circuit.dir circuit.name circuit.theme '.png']; % Fig png file
    pngchangewhite(pngfile,imgout,circuit.theme)
else
    imgout=[circuit.dir circuit.name 'boost.png']; % Fig png file
    pngchangewhite(pngfile,imgout,'boost')
end

quiz.name = [circuit.name];
% Auto add item letter: a), b)... 97 - 122; 65 - 90
if isfield(quiz,'autoitem') && quiz.autoitem
    for q=1:length(quiz.question)
        quiz.question{q}.str=[ char(96+q) ') ' quiz.question{q}.str]; 
        disp(quiz.question{q}.str)
    end
end

for n=1:length(circuits)
    circuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere ' circuits{n}.parstr ';']; % Legenda da figura
    circuits{n}.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig     
    circuits{n} = psimXmultichoice(circuits{n}); % Generate multichoice        
    circuits{n} = quiztextgen(circuits{n}); % Generates quiz text field    
end

%% Generate quizstruct moodle question
quizopts.name=[circuit.name 'quiz'];
quizopts.nquiz=quiz.nquiz; % Number of quizes
quizopts.permutquiz =1; % Permut quiz?
quizopts.nquizperxml=500; % Number of quizes per file
quizopts.type = 'cloze';
quizopts.xmlpath = [ pwd '\xmlfiles']; % Folder for xml files
quizopts.generalfeedback='';
quizopts.penalty='0.25';
quizopts.hidden='0';

quizstruct = psimclozegen(circuits,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file

