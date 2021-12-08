% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2019 AdrianoRuseler
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

% circuit=tmpcircuits{c};
% str=param2str(Valor,parname,parunit)
function circuit=level2str(circuit)

circuit.level.parstr='';
% circuit.level.name ?????
for v=1:length(circuit.level.varname) % update values
    k = strfind(circuit.level.name,circuit.level.varname{v});
    idx = find(not(cellfun('isempty',k)));
%     circuit.level.value{idx}=num2str(circuit.level.varvalue(v),'%10.8e');
    circuit.level.value{idx}=value2srt(circuit.level.varvalue(v));
    if v==length(circuit.level.varname)
        circuit.level.parstr = strcat(circuit.level.parstr, [' ' circuit.level.varname{v} '=' real2eng(circuit.level.varvalue(v),circuit.level.varunit{v},0) ';'] );
    elseif v==length(circuit.level.varname)-1
        circuit.level.parstr = strcat(circuit.level.parstr, [' ' circuit.level.varname{v} '=' real2eng(circuit.level.varvalue(v),circuit.level.varunit{v},0) ' e'] );
    else
        circuit.level.parstr = strcat(circuit.level.parstr, [circuit.level.varname{v} '=' real2eng(circuit.level.varvalue(v),circuit.level.varunit{v},0) ','] );
    end
end

lvlstr = strsplit(circuit.level.linestr,'Avol');
circuit.level.linestr = lvlstr{1}; % XU1 0 - Vpp Vnn o level.2 


for s=1:length(circuit.level.name)
    circuit.level.linestr=strcat(circuit.level.linestr,[ ' ' circuit.level.name{s} '=' circuit.level.value{s}]);    
end


disp(circuit.level.linestr)





