function  out = buck01func2(parvalues) % Function 1 for ct04

% circuit.parnamesim={'Vi','fs','D','L0','C0','R0'};

Vi = parvalues(1);
D = parvalues(3);
R0 = parvalues(6);

out = Vi*D/R0;