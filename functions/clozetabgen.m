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

function [tabletext]=clozetabgen(tablebody, tableheader)

% Geração do Header
theadertext= '<tr>';
for h=1:length(tableheader)
    theadertext=strcat(theadertext,['<th scope="col">' tableheader{h} '</th>']);
end
theadertext=strcat(theadertext,'</tr>');

[x,y]=size(tablebody); % Geração do corpo da tabela
tbodytext='';
for ln=1:x % <tr> linhas
    tbodytext=strcat(tbodytext,'<tr>'); % Inicio de uma linha
    for c=1:y % Colunas
        tbodytext=strcat(tbodytext,['<td>' tablebody{ln,c} '</td>']);
    end
end

tabletext=[ '<table class="text-center" border="1">'...
    '<thead>'...
    theadertext ...
    '</thead>'...
    '<tbody>'...
    tbodytext ...
    '</tbody>'...
    '</table>'];
