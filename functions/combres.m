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
%  Combinações de resistores
% resistor = combres(2,[10 100],'E12')

function R = combres(Rn,Mult,EXX)

% Rn - Numero de Resistores
% Mult - Array com multiplicadores
% EXX - String com série E12, E24...
% colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};



% multiplier=[0.01 0.1 1 10 100 1e3 10e3 100e3 1e6 10e6 100e6 1e9];
% torelancia=[0.05 0.1 0.25 0.5 1 2 5 10 20];
% f3={12,11,1,2,3,4,5,6,7,8,9,10}; % Cor do Multiplicador
% f4={9,8,7,6,2,3,11,12,13}; %Cor da Tolerância

% Saída: R{n} = [R1 R2 R3 ... Rn]

switch EXX
    case 'E06'
        E=[10 15 22 33 47 68]; % 
    case 'E12'
        E=[10 12 15 18 22 27 33 39 47 56 68 82]; % 
    case 'E24'
        E=[10 11 12 13 15 16 18 20 22 24 27 30 33 36 39 43 47 51 56 62 68 75 82 91]; % E24 series (tolerance 5% and 1%)
    case 'E48'
        E=[100 105 110 115 121 127 133 140 147 154 162 169 178 187 196 205 215 226 237 249 261 274 287 301 316 332 348 365 383 402 422 442 464 487 511 536 562 590 619 649 681 715 750 787 825 866 909 953];      
    otherwise
        E=[10 12 15 18 22 27 33 39 47 56 68 82]; % 10%
end

n=1;
for mx=1:length(Mult) % Resistor multiplier
    for ex=1:length(E)
        Rs(n)=Mult(mx)*E(ex);
        n=n+1;
    end
end


switch Rn % Numero de resistores
    case 1
        R=Rs;
    case 2
        R= combvec(Rs,Rs);
    case 3
        R= combvec(Rs,Rs,Rs);
    case 4
        R= combvec(Rs,Rs,Rs,Rs);
    case 5
        R= combvec(Rs,Rs,Rs,Rs,Rs);
    case 6
        R= combvec(Rs,Rs,Rs,Rs,Rs,Rs);        
    otherwise
        disp('Too much combinations! Limited to 6!')
        R= combvec(Rs,Rs,Rs,Rs,Rs,Rs);
end





