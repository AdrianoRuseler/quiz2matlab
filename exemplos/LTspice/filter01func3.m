function  out = filter01func3(parvalues) % Function 1 for filter 01

% circuit.parnamesim={'Vs','R1','R2','RL','C2'}; % Variables names

Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
C2 = parvalues(4);
RL = parvalues(5);


out = 1/(R2*C2); % w0