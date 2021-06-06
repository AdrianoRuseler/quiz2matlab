function  out = buck01func3(parvalues) % Function 1 for ct04

% circuit.parnamesim={'Vi','fs','D','L0','C0','R0'};

fs = parvalues(2);
D = parvalues(3);
R0 = parvalues(6);

out = R0*(1-D)/(2*fs);