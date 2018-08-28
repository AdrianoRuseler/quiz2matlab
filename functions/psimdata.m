% =========================================================================
% ***
% *** The MIT License (MIT)
% *** 
% *** Copyright (c) 2018 AdrianoRuseler
% *** 
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% *** 
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% *** 
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================

function psimdata(circuit)

if nargin < 1
    disp('Dados do conversor não foram fornecidos!')
    return
end

circuit.PSIMCMD.paramfile=[circuit.PSIMCMD.simsdir '\' circuit.PSIMCMD.name '_params.txt'];
% names = fieldnames(circuit);
% call fprintf to print the updated text strings
fid = fopen(circuit.PSIMCMD.paramfile,'w');
if fid==-1
    disp('Erro ao abrir o arquivo para escrita!')
    return
end

for ind=1:length(circuit.PSIMCMD.params)    
    if isfield(circuit,circuit.PSIMCMD.params{ind}) % Apenas imprime o que for numerico
        strdata=[char(circuit.PSIMCMD.params(ind)) ' = ' num2str(getfield(circuit,circuit.PSIMCMD.params{ind}),'%10.8e')];
        fprintf(fid, '%s%c%c', strdata,13,10);
    end
end
fclose(fid);

winopen(circuit.PSIMCMD.paramfile ) % Abre arquivo criado

