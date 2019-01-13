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

function [clozeXmulticell]=clozeXmultichoice(Ru,RuCerta,unidade,tipo)
% Ru - Vetor numérico com respostas
% RuCerta - Indice com a resposta correta
% unidade  - unidade da resposta, ex V, A Ohms...
% Tipo:
% 
% MULTICHOICE
% MULTICHOICE_H
% MULTICHOICE_V
% MULTICHOICE_S
% MULTICHOICE_HS
% MULTICHOICE_VS



switch tipo
    case 'MULTICHOICE'
        clozeXmulticell='{1:MULTICHOICE:';
    case 'MULTICHOICE_H'
        clozeXmulticell='{1:MULTICHOICE_H:';
    case 'MULTICHOICE_V'
        clozeXmulticell='{1:MULTICHOICE_V:';
    case 'MULTICHOICE_S'
        clozeXmulticell='{1:MULTICHOICE_S:';
    case 'MULTICHOICE_HS'
        clozeXmulticell='{1:MULTICHOICE_HS:';
    case 'MULTICHOICE_VS'
        clozeXmulticell='{1:MULTICHOICE_VS:';
    otherwise
        clozeXmulticell='{1:MULTICHOICE_S:';
%   MULTICHOICE
end

for a=1:length(Ru)
    if a==RuCerta
        %  clozeXmulticell = strcat(clozeXmulticell,['~%100%' strrep(num2str(Ru(a),'%03.2f'),'.',',') ' ' unidade]); % Melhorar isso
        clozeXmulticell = strcat(clozeXmulticell,['~%100%' strrep(num2eng(Ru(a),1),'.',',') unidade]);
    else
        %  clozeXmulticell = strcat(clozeXmulticell,['~' strrep(num2str(Ru(a),'%03.2f'),'.',',') ' ' unidade]);
        clozeXmulticell = strcat(clozeXmulticell,['~' strrep(num2eng(Ru(a),1),'.',',') unidade]);
    end
end
clozeXmulticell = strcat(clozeXmulticell,'}');


clozeXmulticell = strrep(clozeXmulticell,'u','&mu;'); % Substitui u por micro;



