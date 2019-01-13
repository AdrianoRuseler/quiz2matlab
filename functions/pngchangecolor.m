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
% pngchangewhite(imgin,imgout,217,237,247) % UTFPR
% pngchangewhite(imgin,imgout,222,242,248) % AWS

% oldcolor=[255,255,255];
% newcolor=[222,242,248];


function pngchangecolor(imgin,imgout,newcolor,oldcolor)

A = imread(imgin);
Rin = A(:,:,1); 
Gin = A(:,:,2); 
Bin = A(:,:,3); 

if margin < 4
    oldcolor=[255,255,255];
end

RB=find(Rin==oldcolor(1));
Rin(RB)=newcolor(1);

GB=find(Gin==oldcolor(1));
Gin(GB)=newcolor(2);

BB=find(Bin==oldcolor(1));
Bin(BB)=newcolor(3);

A2(:,:,1) =Rin;
A2(:,:,2) =Gin;
A2(:,:,3) =Bin;
% imshow(I)

imwrite(A2,imgout)
