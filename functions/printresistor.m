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

function  [Yc, A] = printresistor(f)

cor{1}=[0 0 0]; % Preto
cor{2}=[125 67 2]; % Marrom
cor{3}=[255 0 0]; % Vermelho
cor{4}=[255 165 0]; % Laranja
cor{5}=[255 255 0]; % Amarelo
cor{6}=[60 176 87]; % Verde
cor{7}=[0 0 255]; % Azul
cor{8}=[204 51 204]; % Violeta
cor{9}=[192 192 192]; % Cinza
cor{10}=[255 255 255]; % Branco
cor{11}=[227 173 30]; % Dourado
cor{12}=[204 204 204]; % Prata
cor{13}=[250 190 142]; % Ausente

 A = imread('resistor-baseUTFPR.png');
if length(f)==4  
   
    % imshow(A)
    % f=[2 6 5 11];
    
    A(6:113,240:270,1) = cor{f(1)}(1); % Red - Faixa 1 de 4
    A(6:113,240:270,2) = cor{f(1)}(2); % Green - Faixa 1 de 4
    A(6:113,240:270,3) = cor{f(1)}(3); % Blue - Faixa 1 de 4
    
    A(6:113,300:330,1) = cor{f(2)}(1); % Red - Faixa 2 de 4
    A(6:113,300:330,2) = cor{f(2)}(2);
    A(6:113,300:330,3) = cor{f(2)}(3);
    
    A(6:113,360:390,1) = cor{f(3)}(1); % Red - Faixa 3 de 4
    A(6:113,360:390,2) = cor{f(3)}(2);
    A(6:113,360:390,3) = cor{f(3)}(3);
    
    A(2:117,445:475,1) = cor{f(4)}(1); % Red - Faixa 4 de 4
    A(2:117,445:475,2) = cor{f(4)}(2);
    A(2:117,445:475,3) = cor{f(4)}(3);
    
    % imshow(A)
    code=[dec2hex(f(1)) dec2hex(f(2)) dec2hex(f(3)) dec2hex(f(4))];
    imwrite(A,['Resistor' code '.png'])
    
elseif length(f)==5
%     f=[2 6 5 11 12];
    
    A(6:113,240:270,1) = cor{f(1)}(1); % Red - Faixa 1 de 5
    A(6:113,240:270,2) = cor{f(1)}(2);
    A(6:113,240:270,3) = cor{f(1)}(3);  
    
    A(6:113,290:320,1) = cor{f(2)}(1); % Red - Faixa 2 de 5
    A(6:113,290:320,2) = cor{f(2)}(2);
    A(6:113,290:320,3) = cor{f(2)}(3);   
    
    A(6:113,340:370,1) = cor{f(3)}(1); % Red - Faixa 3 de 5
    A(6:113,340:370,2) = cor{f(3)}(2);
    A(6:113,340:370,3) = cor{f(3)}(3);       
    
    A(6:113,390:420,1) = cor{f(4)}(1); % Red - Faixa 4 de 5
    A(6:113,390:420,2) = cor{f(4)}(2);
    A(6:113,390:420,3) = cor{f(4)}(3);
    
    A(2:117,445:475,1) = cor{f(5)}(1); % Red - Faixa 5 de 5
    A(2:117,445:475,2) = cor{f(5)}(2);
    A(2:117,445:475,3) = cor{f(5)}(3);
    
    code=[dec2hex(f(1)) dec2hex(f(2)) dec2hex(f(3)) dec2hex(f(4)) dec2hex(f(5))];
    imwrite(A,['Resistor' code '.png'])
    
elseif length(f)==6
%     f=[2 6 5 11 12 12];
   A(2:117,180:210,1) = cor{f(1)}(1); % Red - Faixa 1 de 4
   A(2:117,180:210,2) = cor{f(1)}(2); % Green - Faixa 1 de 4
   A(2:117,180:210,3) = cor{f(1)}(3); % Blue - Faixa 1 de 4    
    
    A(6:113,240:270,1) = cor{f(2)}(1); % Red - Faixa 1 de 5
    A(6:113,240:270,2) = cor{f(2)}(2); 
    A(6:113,240:270,3) = cor{f(2)}(3);  
    
    A(6:113,290:320,1) = cor{f(3)}(1); % Red - Faixa 2 de 5
    A(6:113,290:320,2) = cor{f(3)}(2);
    A(6:113,290:320,3) = cor{f(3)}(3);   
    
    A(6:113,340:370,1) = cor{f(4)}(1); % Red - Faixa 3 de 5
    A(6:113,340:370,2) = cor{f(4)}(2);
    A(6:113,340:370,3) = cor{f(4)}(3);       
    
    A(6:113,390:420,1) = cor{f(5)}(1); % Red - Faixa 4 de 5
    A(6:113,390:420,2) = cor{f(5)}(2);
    A(6:113,390:420,3) = cor{f(5)}(3);
    
    A(2:117,445:475,1) = cor{f(6)}(1); % Red - Faixa 5 de 5
    A(2:117,445:475,2) = cor{f(6)}(2);
    A(2:117,445:475,3) = cor{f(6)}(3);
    
    code=[dec2hex(f(1)) dec2hex(f(2)) dec2hex(f(3)) dec2hex(f(4)) dec2hex(f(5)) dec2hex(f(6))];
    imwrite(A,['Resistor' code '.png'])
    
end


fileID = fopen(['Resistor' code '.png']); % Testar se esta ok
A2 = fread(fileID);
fclose(fileID); % Testar
delete(['Resistor' code '.png'])

Yc = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(A2)))'; % Encode
