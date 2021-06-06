function  out = buck01func4(parvalues) % Function 1 for ct04

% circuit.parnamesim={'Vi','fs','D','L0','C0','R0'};

fs = parvalues(2);
D = parvalues(3);
% R0 = parvalues(6);
L0 = parvalues(4);

out = (2*fs*L0)/(1-D);