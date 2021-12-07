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
function [parcode]=param2code(circuit)

valor=circuit.parvalue;
parname=circuit.parnamesim;

% [str, numstr, expstr, mantissa, exponent] = real2eng(valor(4),parunit{4})


parcode=['<code>' parname{1} '=' value2srt(valor(1)) '<br>'];

for a=2:length(valor)
    if a==length(valor)
        parcode= strcat(parcode, [parname{a} '=' value2srt(valor(a)) '</code>'] );
    else
        parcode= strcat(parcode, [parname{a} '=' value2srt(valor(a)) '<br>'] ); % num2str(valor(a),'%4.3e')
    end
end



