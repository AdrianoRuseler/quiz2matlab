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

function [clozeVcell]=clozeVmedido(varmed,medtol)

% Qual a melhor escala para medir o resistor
escalaVstr={'200 mV','2 V','20 V','200 V','1 kV'};
escalaVnum=[0.2 2 20 200 1000];
resolucaoVnum=[10e-6 100e-6 1e-3 10e-3 100e-3];

indp=find((escalaVnum-abs(varmed))>0); % Escolhe a melhor escala.
strVe='{1:MULTICHOICE:';
for a=1:length(escalaVstr)
    if a==indp(1)
        strVe = strcat(strVe,['~%100%' escalaVstr{a} ]);
    else
        strVe = strcat(strVe,['~' escalaVstr{a} ]);
    end
end
escalatext = strcat(strVe,'}');

Vres=max([abs(varmed*medtol) resolucaoVnum(indp(1)) 10e-6]);
clozeVcell=['{1:NUMERICAL:~%100%' num2str(varmed,'%03.3f') ':' num2str(Vres,'%03.3f') '}' escalatext ];


                    
             
                    