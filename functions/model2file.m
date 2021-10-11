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

outstring=strrep(char(java.util.UUID.randomUUID),'-','');
modelfilename=['MF' upper(outstring(1:6)) '.MOD'];
fileID = fopen([modelpath modelfilename],'w');
if fileID==-1
    disp('File error!!')
    return
end

for m=1:length(circuit.model) % Number of models - writes all models in a single file
    if ~isfield(circuit.model(m),'comments') || isempty(circuit.model(m).comments)
        circuit.model(m).comments = '* SPICE Model';
    end
    fprintf(fileID,'%s\n',circuit.model(m).comments);
    fprintf(fileID,'%s\n\n',circuit.model(m).modelstr);
end

fclose(fileID);

fileID = fopen([modelpath modelfilename],'r');
if fileID==-1
    disp('File error!!')
    return
end
A = fread(fileID);
fclose(fileID);

Yc = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(A)))'; % Encode
circuit.modelfilebase64code=Yc;
circuit.modelfilename=modelfilename;

for m=1:length(circuit.model) % Number of models - writes all models in a single file
    circuit.model(m).filebase64code=Yc;
end


%         disp(Yc)

delete([modelpath modelfilename])



