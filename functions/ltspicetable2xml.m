

function ltspicetable2xml(circuit,quiz)

circuit.LTspice.name = circuit.name; % File name
circuit.LTspice.simsdir= circuit.dir; % sim file dir

circuit.LTspice.tmpfile = 1; % Create tmp file?
circuit.LTspice.tmpdir = 1; % Use system temp dir?
circuit.LTspice.tmpfiledel = 1; % Delete tmp files?
circuit = ltasc2net(circuit); % Generates the .net file
circuit = ltgetnet(circuit); % Reads net file

steps=length(circuit.stepvalues);
for c=1:length(circuit.X)
    for s=1:steps
        tmpcircuits{c,s}=circuit;
        tmpcircuits{c,s}.parvalue=[circuit.stepvalues(s) circuit.X(:,c)']; % Variables values
        [tmpparstr,tmpnostepparstr]=param2str(tmpcircuits{c,s});
        tmpcircuits{c,s}.parstr = tmpparstr;
        tmpcircuits{c,s}.nostepparstr = tmpnostepparstr;
    end
end


%   Runs simulation OK!
[~,y]=size(circuit.X);
parfor n=1:y
    for s=1:steps
        tmpcircuits{n,s} = ltspicefromcmd(tmpcircuits{n,s}); % Simula via CMD
    end
end
% tmpcircuits=circuits;

% Clear empty simulated data
a=1;
b=1;
[x,y]=size(tmpcircuits); % x-> configs; y->steps
for c=1:x
    for s=1:y
        if isfield(tmpcircuits{c,s}.LTspice,'data')
            circuits{a,b}=tmpcircuits{c,s};
            b=b+1;
        else
            disp(['No data file in simulation with ' tmpcircuits{c,s}.parstr '!'])
        end
    end
    b=1; % reset indice
    a=a+1;
end

% Quiz fig
pngfile=[circuit.dir circuit.name '.png']; % Fig png file
if isfield(circuit,'theme')
    imgout=[circuit.dir circuit.name circuit.theme '.png']; % Fig png file
    pngchangewhite(pngfile,imgout,circuit.theme)
else
    imgout=[circuit.dir circuit.name 'clean.png']; % Fig png file
    pngchangewhite(pngfile,imgout,'clean')
end

% quiz.name = [circuit.name 'quiz'];
quiz.name = circuit.name;

%% 
[x,~]=size(circuits); % x-> configs; y->steps
for n=1:x
    stepcircuits{n}.quiz=quiz;
    figlegendastr=['Figura 1: Considere' circuits{n,1}.nostepparstr ';']; % Legenda da figura
    stepcircuits{n}.quiz.fightml = psimfigstr(imgout,'left',figlegendastr); % html code for fig      
    stepcircuits{n}=ltspiceXtable(stepcircuits{n},{circuits{n,:}});    % Generates moodle question string
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

quizstruct = ltspiceclozegen(stepcircuits,quizopts); % Generate quizstruct
cloze2moodle(quizstruct) % Generates xml file
% 