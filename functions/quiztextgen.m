% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2021 AdrianoRuseler
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
% Generates quiz text field

function circuit = quiztextgen(circuit)


if isfield(circuit.quiz,'rowfigdirective') && circuit.quiz.rowfigdirective
    circuit.quiz.text = ['<p>'  circuit.quiz.enunciado  '<br></p> <div class="row">  <div class="col-md-8">' circuit.quiz.fightml '</div>  <div class="col-md-4"><p>' directive2code(circuit) '</p></div> </div> '];
elseif isfield(circuit.quiz,'rowfigparam') && circuit.quiz.rowfigparam
    circuit.quiz.text = ['<p>'  circuit.quiz.enunciado  '<br></p> <div class="row">  <div class="col-md-8">' circuit.quiz.fightml '</div>  <div class="col-md-4"><p>'  param2code(circuit) '</p></div> </div> '];
else
    circuit.quiz.text = [ '<p>'  circuit.quiz.enunciado  '<br></p>'  circuit.quiz.fightml ];
end


if isfield(circuit.quiz,'extratext') % Add extra text
    if isfield(circuit.quiz,'printparfile') && circuit.quiz.printparfile
        fe =  length(circuit.quiz.extratext);

        %https://getbootstrap.com/docs/4.0/content/code/
        % <code> Sample text here... ; <br> And another line of sample text here... ; </code>

        circuit.quiz.extratext{fe+1}=param2code(circuit);
        %     disp('Imprima o arquivo de parâmetros no enuciado da questão!!!')
    end

    for e=1:length(circuit.quiz.extratext)
        circuit.quiz.text=[circuit.quiz.text '<p>' circuit.quiz.extratext{e} '<br></p>'];
    end
end

% quiz.eqlist={'eq01','eq02','eq03','eq04','eq05'}; circuit.quiz.eqlist
% quiz.eqnum={'eq01','eq02','eq03','eq04','eq05'}; circuit.quiz.eqnum

% if isfield(circuit.quiz,'eqlist') && isfield(circuit.quiz,'eqnum') % Add equations table
%     thead='<br><div class="col-md-4"> <table class="table table-hover table-bordered"> <thead class="thead-light"><tr><th>Equação</th> <th>Expressão</th></tr></thead>';
%     circuit.quiz.text=[circuit.quiz.text thead]; % Add header   char(96+q) ') '
%     for e=1:length(circuit.quiz.eqlist)
%         tablerow=['<tbody><tr><td>' circuit.quiz.eqnum{e} '</td><td>' circuit.quiz.eqlist{e} '</td></tr>'];
%         circuit.quiz.text=[circuit.quiz.text tablerow]; % Add row
%     end
%     circuit.quiz.text=[circuit.quiz.text '</tbody> </table> <p style="text-align: left;">Tabela 1: Equações e suas expressões.</p> <br></div>']; % close table
% end


if isfield(circuit.quiz,'eqlist') && isfield(circuit.quiz,'eqnum') % Add equations table
    thead='<br><div class="col-md-4 text-centered"> <table class="table table-hover table-bordered"> <thead class="thead-light"><tr>';
    for e=1:length(circuit.quiz.eqnum)
        thead=[thead '<th>' circuit.quiz.eqnum{e} '</th>'];
    end
    circuit.quiz.text=[circuit.quiz.text thead '</tr></thead>']; % Add header   char(96+q) ') '
    tablerow='<tbody><tr>';
    for e=1:length(circuit.quiz.eqlist)
        tablerow=[tablerow '<td>' circuit.quiz.eqlist{e} '</td>'];        
    end
    circuit.quiz.text=[circuit.quiz.text tablerow '</tr>']; % Add row
    circuit.quiz.text=[circuit.quiz.text '</tbody> </table> <p style="text-align: left;">Tabela 1: Equações e suas expressões.</p> <br></div>']; % close table
end


% quiz.modelfile=1; % Add link to model file

if circuit.quiz.modelfile % Add model file with link to it
    %     disp('Add model file')
    circuit.quiz.text=[circuit.quiz.text '<p>Arquivo: <a href="@@PLUGINFILE@@/' circuit.modelfilename '">' circuit.modelfilename '</a><br></p>'];
    circuit.quiz.nomearquivo=circuit.modelfilename;
end

if circuit.quiz.scriptfile % Add PSIM script file with link to it
    circuit.quiz.text=[circuit.quiz.text '<p>PSIM Script: <a href="@@PLUGINFILE@@/' circuit.PSIMCMD.script.name '">' circuit.PSIMCMD.script.name '</a><br></p>'];
    circuit.quiz.nomearquivo=circuit.PSIMCMD.script.name;
end

% Add plot here
if isfield(circuit.quiz,'plot') % Add extra text
    for p=1:length(circuit.quiz.plot)
        circuit.quiz.text=[circuit.quiz.text circuit.quiz.plot{p}.html];
    end
end

if ~isfield(circuit.quiz,'exptable') % Add exptable
    circuit.quiz.exptable=0;
end


if circuit.quiz.exptable
    thead='<div class="col-md-6"> <table class="table table-hover table-bordered"> <thead class="table-secondary"><tr><th>Item</th> <th>Expressão</th><th>Cálculo</th><th>Valor</th></tr></thead>';
    circuit.quiz.text=[circuit.quiz.text thead]; % Add header   char(96+q) ') '
    u=1;
    for q=1:length(circuit.quiz.question)
        if isfield(circuit.quiz.question{q},'expmath')
            tablerow=['<tbody><tr><td>' char(96+u) ') </td><td>' circuit.quiz.question{q}.expmath '</td><td>' circuit.quiz.question{q}.expchoicestr  '</td><td>' circuit.quiz.question{q}.choicestr '</td></tr>'];

        else
            tablerow=['<tbody><tr><td>' char(96+u) ') </td><td colspan="2">' circuit.quiz.question{q}.str  '</td><td>' circuit.quiz.question{q}.choicestr '</td></tr>'];
        end
        circuit.quiz.text=[circuit.quiz.text tablerow]; % Add row
        u=u+1;
    end

    %     <p style="text-align: left;">Tabela 1: Equações e suas expressões.<br></p>

    circuit.quiz.text=[circuit.quiz.text '</tbody> </table> </div>']; % close table

    %     for q=1:length(circuit.quiz.question)
    %         if ~isfield(circuit.quiz.question{q},'expmath')
    %             circuit.quiz.text=[circuit.quiz.text '<p>' circuit.quiz.question{q}.str ' '  circuit.quiz.question{q}.choicestr '<br></p>'];
    %         end
    %     end


else
    for q=1:length(circuit.quiz.question)
        circuit.quiz.text=[circuit.quiz.text '<p>' circuit.quiz.question{q}.str ' '  circuit.quiz.question{q}.choicestr '<br></p>'];
    end
end





