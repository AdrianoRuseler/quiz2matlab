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
% pngchangewhite(imgin,imgout,'clean') % UTFPR - clean
% pngchangewhite(imgin,imgout,'boost') % AWS - boost
function pngchangewhite(imgin,imgout,theme)

switch theme
    case 'clean'
        R=217;
        G=237;
        B=247;
    case 'classic'
        R=231;
        G=243;
        B=243;
    case 'boost'
        R=231;
        G=243;
        B=245;
    case 'clean39'
        R=204;
        G=230;
        B=234;
    case 'boost39'
        R=204;
        G=230;
        B=234;
    case 'classic310'
        R=231;
        G=243;
        B=243;
    case 'boost310'
        R=231;
        G=243;
        B=245;
    case 'boost38'
        R=222;
        G=242;
        B=248;
    otherwise % boost39
        R=204;
        G=230;
        B=234;
end


A = imread(imgin);
% figure
% imshow(A)
% Extract RGB vectors
Rin = A(:,:,1); 
Gin = A(:,:,2); 
Bin = A(:,:,3); 


RB=find(Rin==255);
Rin(RB)=R;

GB=find(Gin==255);
Gin(GB)=G;

BB=find(Bin==255);
Bin(BB)=B;

A2(:,:,1) =Rin;
A2(:,:,2) =Gin;
A2(:,:,3) =Bin;
% imshow(I)

imwrite(A2,imgout)
