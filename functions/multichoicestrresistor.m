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

function  [tabletext, medtext,escalatext] = multichoicestrresistor(f,emt,R)

colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};

strf1='{1:MULTICHOICE_S:';
strf2='{1:MULTICHOICE_S:';
strf3='{1:MULTICHOICE_S:';
strf4='{1:MULTICHOICE_S:';

for a=1:length(colorname)
    if a==f(1)
        strf1 = strcat(strf1,['~%100%' colorname{a} ]);
    else
        strf1 = strcat(strf1,['~' colorname{a} ]);
    end
    if a==f(2)
        strf2 = strcat(strf2,['~%100%' colorname{a} ]);
    else
        strf2 = strcat(strf2,['~' colorname{a} ]);
    end
    if a==f(3)
        strf3 = strcat(strf3,['~%100%' colorname{a} ]);
    else
        strf3 = strcat(strf3,['~' colorname{a} ]);
    end
    if a==f(4)
        strf4 = strcat(strf4,['~%100%' colorname{a} ]);
    else
        strf4 = strcat(strf4,['~' colorname{a} ]);
    end
end
strf1 = strcat(strf1,'}');
strf2 = strcat(strf2,'}');
strf3 = strcat(strf3,'}');
strf4 = strcat(strf4,'}');

tabletext=[ '<table>'...
    '<thead>'...
    '<tr><th scope="col">Faixa 1</th><th scope="col">Faixa 2</th><th scope="col">Faixa 3</th><th scope="col">Faixa 4</th></tr>'...
    '</thead>'...
    '<tbody>'...
    '<tr>'...
    '<td>' strf1 '</td>'...
    '<td>' strf2 '</td>'...
    '<td>' strf3 '</td>'...
    '<td>' strf4 '</td>'...
    '</tr>'...
    '</tbody>'...
    '</table>']; %...
    %'<p><br /><br /></p>'];
    
    % Qual a melhor escala para medir o resistor        
    escalasR={'200 &Omega;','2 k&Omega;','20 k&Omega;','200 k&Omega;','2 M&Omega;','20 M&Omega;','200 M&Omega;'};
    escala=[200 2e3 20e3 200e3 2e6 20e6 200e6];
    torelancia=[0.05 0.1 0.25 0.5 1 2 5 10 20]/100; % emt(3)
    
 medtext= ['{1:NUMERICAL:~%100%' num2str(R) ':' ceil(num2str(R*torelancia(emt(3)))) '}'];
%  escalatext=

indp=find((escala-R)>0);


strf5='{1:MULTICHOICE_S:';
for a=1:length(escalasR)
    if a==indp(1)
        strf5 = strcat(strf5,['~%100%' escalasR{a} ]);
    else
        strf5 = strcat(strf5,['~' escalasR{a} ]);
    end   
end
escalatext = strcat(strf5,'}');





