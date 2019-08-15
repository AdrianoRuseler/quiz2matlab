% F:\Dropbox\GitHub\quiz2matlab\et52b\lab01
clear all
clc

% Resistores disponíveis para a disciplina.
% Re12 = combres(1,[10 100 1000],'E12'); % 36 resistores

Vcc=[0.1 0.2 0.3 0.4 0.5 0.55 0.6 0.65 0.7 0.8 0.9 1.0 3.0 5.0 10.0 15.0];
R1 = combres(1,100,'E12');
R2 = combres(1,100,'E12');
Xi=CombVec(R1,R2); % 144 combinações

%% LAB01a
clear all
clc

% circuit.Ngspice.simsdir='F:\Dropbox\GitHub\quiz2matlab\et52b\lab01'; % PSIM file dir
circuit.Ngspice.simsdir='A:\Dropbox\GitHub\quiz2matlab\et52b\lab01'; % PSIM file dir @ UTFPR
circuit = getlab01anet(circuit); % gets netlist file

circuit.Ngspice.tmpfile=1; % Create tmp file?
circuit.Ngspice.tmpdir=1; % Use system temp dir?
circuit.Ngspice.tmpfiledel=1; % Delete tmp files?

circuit.parname={'Vcc','R1','R2'};
circuit.parvalue=[10 1500 1000];

circuit = ngspicefromcmd(circuit); % run Ngspice simulation

%%


%%
% datac=simlab01a(Vcc(7),R1(4),R2(6)); 
clear all
clc

Vcc=[0.1 0.2 0.3 0.4 0.5 0.55 0.6 0.65 0.7 0.8 0.9 1.0 3.0 5.0 10.0 15.0];
R1 = combres(1,100,'E12');
R2 = combres(1,100,'E12');
Xi=CombVec(R1,R2); % 144 combinações

% circuit.Ngspice.simsdir='F:\Dropbox\GitHub\quiz2matlab\et52b\lab01'; % PSIM file dir
circuit.Ngspice.simsdir='A:\Dropbox\GitHub\quiz2matlab\et52b\lab01'; % PSIM file dir @ UTFPR
circuit = getlab01anet(circuit); % gets netlist file

circuit.Ngspice.tmpfile=1; % Create tmp file?
circuit.Ngspice.tmpdir=1; % Use system temp dir?
circuit.Ngspice.tmpfiledel=1; % Delete tmp files?

circuit.parname={'Vcc','R1','R2'};


for n=1:length(Xi)
    for ln=1:length(Vcc)
%        datac{n}{ln}=simlab01a(Vcc(ln),R1{n},R2{n}); % Correto 
       circuit.parvalue=[Vcc(ln) Xi(1,n) Xi(2,n)];
       circuit = ngspicefromcmd(circuit);
       datac{n}{ln} = circuit.Ngspice.raw.data;
    end
end
% circuit = ngspicefromcmd(circuit)

