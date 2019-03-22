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
function pngfigstr=png2base64(pngfile)

fileID = fopen(pngfile);
if fileID == -1
    disp(['Failed to open file: ' pngfile])
    pngfigstr='';
    return
else
    A = fread(fileID);
    fclose(fileID);
end
Yc = char(org.apache.commons.codec.binary.Base64.encodeBase64(uint8(A)))'; % Encode
pngfigstr=['<img src="data:image/png;base64,' Yc '" alt="">'];
