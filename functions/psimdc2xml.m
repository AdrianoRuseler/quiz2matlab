

function circuits=psimdc2xml(circuit,quiz)


circuit.PSIMCMD.name = circuit.name; % File name
circuit.PSIMCMD.simsdir=circuit.dir; % PSIM file dir

% Simulation control settings
circuit.PSIMCMD.tmpfile=1; % Create tmp file?
circuit.PSIMCMD.tmpdir=1; % Use system temp dir?
circuit.PSIMCMD.tmpfiledel=1; % Delete tmp files?

circuit.PSIMCMD.totaltime=10E-005; % Total simulation time, in sec.
circuit.PSIMCMD.steptime=1E-005; % Simulation time step, in sec.  
circuit.PSIMCMD.printtime=5E-005; %Time from which simulation results are saved to the output file (default = 0). No output is saved before this time. 
circuit.PSIMCMD.printstep=1; %Print step (default = 1). If the print step is set to 1, every data point will be saved to the output file. 
% If it is 10, only one out of 10 data points will be saved. This helps to reduce the size of the output file. 

circuit.PSIMCMD.net.run = 0; % Generate netlist and run from it?
if ~isfield(circuit.PSIMCMD,'script')
    circuit.PSIMCMD.script.run=0;  % Flag to use script file in simulation
    quiz.scriptfile=0; % Add link to script file
end

if circuit.PSIMCMD.net.run
    circuit = getpsimnet(circuit); % Reads or generates net file from psim
end


if ~isfield(circuit,'engine')
    circuit.engine ='psim'; % PSIM ou LTspice simulation
end

% sortnquestions=250; % Number of simulations
[~,y]=size(circuit.Xi);
nq=randperm(y,circuit.nsims); % escolha as questoes
circuit.X=circuit.Xi(:,nq);

% circuit.Xi=[]; % Clear

for c=1:length(circuit.X)
    tmpcircuits{c}=circuit;
    tmpcircuits{c}.parvalue=circuit.X(:,c); % Variables values
    tmpcircuits{c}.parstr = param2str(tmpcircuits{c});
end

% Run simulation test
tmptest = psimfromcmdtest(tmpcircuits{1}); % Simula via CMD
% //		0: Success							   							   
% //		Errors: 							   
% //		2:  Failed to run simulation or generate an XML file or generate Simcoder C code. 
% //		3:  Can not open input schematic file  
% //		4:  Input file is missing		
% //        5:  Key word in cmdout file: ERROR ou Failed
% //        6:  Key word in msg file: ERROR ou Failed
% //		10: unable to retrieve valid license.  
% //		-1: Failed to run script otherwise it returns the script return value or 0
if tmptest
    return
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

if ~isfield(quiz,'nquiz')
    quiz.nquiz=length(circuits);
end


if ~isfield(quiz,'modelfile') % Create file with model
   quiz.modelfile=0;    
end

if ~isfield(quiz,'scriptfile') % Create file with model
    quiz.scriptfile=0;
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
% quiz.name = [circuit.name 'quiz'];

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

quizopts.name=circuit.name;
quizopts.nquiz=quiz.nquiz; % Number of quizes
quizopts.permutquiz =1; % Permut quiz?
quizopts.nquizperxml=1000; % Number of quizes per file
quizopts.type = 'cloze';
quizopts.xmlpath = [ pwd '\xmlfiles']; % Folder for xml files
quizopts.generalfeedback='';
quizopts.penalty='0.25';
quizopts.hidden='0';

quizopts.permutquiz =1; % Permut quiz?
if ~isfield(quiz,'incfrom') % Increment question from
    quizopts.incfrom=0;
else
    quizopts.incfrom=quiz.incfrom;
end

quizstruct = psimclozegen(circuits,quizopts); % Generate quizstruct
% cloze2moodle(quizstruct) % Generates xml file

cloze2mdl(quizstruct) % Generates xml file


