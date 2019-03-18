% F:\Dropbox\GitHub\quiz2matlab\et52b\lab01
clear all
clc

Vcc=[0.1 0.2 0.3 0.4 0.5 0.55 0.6 0.65 0.7 0.8 0.9 1.0 3.0 5.0 10.0 15.0];
R1 = combres(1,[100],'E12');
R2 = combres(1,[100],'E12');
Xi=CombVec(R1,R2); 


datac=simlab01a(Vcc(7),R1(4),R2(6)); 


%% Simulation

for n=1:length(Xi)
    for ln=1:length(Vcc)
       datac{n}{ln}=simlab01a(Vcc(ln),R1{n},R2{n}); % Correto 

    end
end
% circuit = ngspicefromcmd(circuit)