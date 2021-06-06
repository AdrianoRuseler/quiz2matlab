function  out = filter01func4(parvalues) % Function 1 for filter 01

% 
Vs = parvalues(1);
R1 = parvalues(2);
R2 = parvalues(3);
RL = parvalues(5);
C2 = parvalues(4);


out = 1/(2*pi*R2*C2); % f0