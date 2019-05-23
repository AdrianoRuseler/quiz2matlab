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

% str=param2str(Valor,parname,parunit)
function [circuit]=model2str(circuit)

valor=circuit.model.parvalue;
parname=circuit.model.parname;
parunit=circuit.model.parunit;

modelstr=['.model ' circuit.model.name ' ' circuit.model.tipo '('];
    
% [str, numstr, expstr, mantissa, exponent] = real2eng(valor(1),parunit{1});
parstr=[ parname{1} '=' real2eng(valor(1),parunit{1},0) ','];
modelstr=[modelstr parname{1} '=' num2str(valor(1),'%10.8e')];
% nostepparstr = '';
for a=2:length(valor)
    if a==length(valor)
        parstr= strcat(parstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a},0) ] );
%         nostepparstr= strcat(nostepparstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ] );
        modelstr=strcat(modelstr,[ ' ' parname{a} '=' num2str(valor(a),'%10.8e') ')']);
    elseif a==length(valor)-1
        parstr= strcat(parstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a},0) ' e'] );
%         nostepparstr= strcat(nostepparstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ' e'] );
        modelstr=strcat(modelstr,[' ' parname{a} '=' num2str(valor(a),'%10.8e') ]);
    else
        parstr= strcat(parstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a},0) ','] );
%         nostepparstr= strcat(nostepparstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ','] );
        modelstr=strcat(modelstr,[ ' ' parname{a} '=' num2str(valor(a),'%10.8e') ]);
    end
end

circuit.model.parstr=parstr;
circuit.model.modelstr=modelstr;





