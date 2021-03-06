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

% str=param2str(Valor,parname,parunit)
function [parstr,nostepparstr]=param2str(circuit)

valor=circuit.parvalue;
parname=circuit.parname;
parunit=circuit.parunit;

% [str, numstr, expstr, mantissa, exponent] = real2eng(valor(1),parunit{1});
if length(valor)==2
    parstr=[ parname{1} '=' real2eng(valor(1),parunit{1}) ' e'];
else
    parstr=[ parname{1} '=' real2eng(valor(1),parunit{1}) ','];
end

nostepparstr = '';
for a=2:length(valor)
    if a==length(valor)
        parstr= strcat(parstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ] );
        nostepparstr= strcat(nostepparstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ] );
    elseif a==length(valor)-1
        parstr= strcat(parstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ' e'] );
        nostepparstr= strcat(nostepparstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ' e'] );
    else
        parstr= strcat(parstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ','] );
        nostepparstr= strcat(nostepparstr, [' ' parname{a} '=' real2eng(valor(a),parunit{a}) ','] );
    end
end



% disp(parstr)
