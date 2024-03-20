% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2024 AdrianoRuseler
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

% html=png2html(imgin,'boost') % 
% html=png2html(imgin) % 
function html=png2html(imgin,theme)

if nargin < 2
    theme='boost';
end

switch theme
    case 'classic'
        R=231;
        G=243;
        B=245;
    case 'boost'
        R=231;
        G=243;
        B=245;
    case 'union'
        R=231;
        G=243;
        B=245;
    otherwise % boost
        R=231;
        G=243;
        B=245;
end

A = imread(imgin);
% figure
% imshow(A)
% Extract RGB vectors
Rin = A(:,:,1); 
Gin = A(:,:,2); 
Bin = A(:,:,3); 

% Replace white color
Rin(Rin==255)=R;
Gin(Gin==255)=G;
Bin(Bin==255)=B;

% Create new image
A2(:,:,1) =Rin;
A2(:,:,2) =Gin;
A2(:,:,3) =Bin;
% imshow(I)

tmppng = [tempname,'.png'];
imwrite(A2,tmppng) 


fileID = fopen(tmppng);
if fileID == -1
    disp(['Failed to open file: ' tmppng])
    html='';
    return
else
    B = fread(fileID);
    fclose(fileID);
end
Yc = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(B)))'; % Encode

html=['<img src="data:image/png;base64,' Yc '" alt="">'];

% Delete tmp file

delete(tmppng)



