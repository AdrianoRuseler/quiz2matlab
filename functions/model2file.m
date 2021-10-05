% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2021 AdrianoRuseler
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

% length(tmpcircuits{c}.model)

% Name Description Units
% Is  saturation current  A
% Rs  Ohmic resistance  Ohm
% N  Emission coefficient  -
% Tt  Transit-time  sec
% Cjo  Zero-bias junction cap
% M  Grading coefficient  -
% BV  Reverse breakdown voltage  V
% Ibv  Current at breakdown voltage  A

% circuit=tmpcircuits{c};
% str=param2str(Valor,parname,parunit)
function [circuit]=model2file(circuit)

modelpath=[pwd '\models\'];
if ~exist(modelpath,'dir')
    mkdir(modelpath) % Sem verificação de erro
end

% for m=1:length(circuit.model) % Number of models - writes all models in a single file
m=1;
if isfield(circuit.model(m),'modelstr')
    outstring = char(mlreportgen.utils.hash(circuit.model(m).modelstr));
    circuit.model(m).modelnane=[circuit.model(m).tipo upper(outstring(1:5))];
    circuit.model(m).modelfile=[circuit.model(m).modelnane '.MOD'];
    modeldata = replace(circuit.model(m).modelstr,circuit.model(m).name,circuit.model(m).modelnane);
    
    fileID = fopen([modelpath circuit.model(m).modelfile],'w');
    fprintf(fileID,'* Standard Berkeley SPICE semiconductor diode\n');
    fprintf(fileID,'%s\n',modeldata);
    fclose(fileID);
    
    %         disp(Yc)
else
    disp('Field modelstr not found!!!')
end
% end


fileID = fopen([modelpath circuit.model(m).modelfile],'r');
A = fread(fileID);
fclose(fileID);

Yc = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(A)))'; % Encode
circuit.model(m).filebase64code=Yc;
%         disp(Yc)

delete([modelpath circuit.model(m).modelfile])



