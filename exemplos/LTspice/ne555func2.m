function  out = ne555func2(parvalues) % Function 1 for filter 01

% circuit.Xi=CombVec(Vs,R1,R2,R0,C0); %%

Vcc = parvalues(1);
RA = parvalues(2);
RB = parvalues(3);
RL = parvalues(4);
CA = parvalues(5);


out = log(2)*(RB)*CA; % tL