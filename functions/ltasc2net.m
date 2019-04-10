
% Generates netlist file .net from asc file
function [circuit] = ltasc2net(circuit)

circuit.LTspice.ascfile = [circuit.LTspice.simsdir circuit.LTspice.name '.asc']; % Sim base file

if ~exist(circuit.LTspice.ascfile,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.LTspice.ascfile])
    return;
end

disp(' -netlist Batch conversion of a schematic to a netlist.')
%         tic
[status,cmdout] = system(['XVIIx64.exe -Run -b -ascii -netlist ' circuit.LTspice.ascfile ]); % Cria o arquivo .net
disp(cmdout)

if ~status % Se simulação foi bem sucedida
    circuit.LTspice.net.name = circuit.LTspice.name;
    circuit.LTspice.net.file = [circuit.LTspice.simsdir circuit.LTspice.name '.net']; % Sim base file
else
    circuit.LTspice.net.file='';
    return;
end


