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
    case 'E96'
        E=[100 102 105 107 110 113 115 118 121 124 127 130 133 137 140 143 147 150 154 158 162 165 169 174 178 182 187 191 196 200 205 210 215 221 226 232 237 243 249 255 261 267 274 280 287 294 301 309 ...
            316 324 332 340 348 357 365 374 383 392 402 412 422 432 442 453 464 475 487 499 511 523 536 549 562 576 590 604 619 634 649 665 681 698 715 732 750 768 787 806 825 845 866 887 909 931 953 976];
    case 'E192'
        E=[100 101 102 104 105 106 107 109 110 111 113 114 115 117 118 120 121 123 124 126 127 129 130 132 133 135 137 138 140 142 143 145 147 149 150 152 154 156 158 160 162 164 165 167 169 172 174 176 ...
            178 180 182 184 187 189 191 193 196 198 200 203 205 208 210 213 215 218 221 223 226 229 232 234 237 240 243 246 249 252 255 258 261 264 267 271 274 277	280 284 287 291 294 298 301 305 309 312 ...
            316 320 324 328 332 336 340 344 348 352 357 361 365 370 374 379 383 388 392 397 402 407 412 417 422 427 432 437 442 448 453 459 464 470 475 481 487 493 499 505 511 517 523 530 536 542 549 556 ...
            562 569 576 583 590 597 604 612 619 626 634 642 649 657	665 673 681 690 698 706 715 723 732 741 750 759 768 777 787 796 806 816 825 835 845 856 866 876 887 898 909 920 931 942 953 965 976 988];
    otherwise %E12
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





