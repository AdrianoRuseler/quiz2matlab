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


for q=1:length(circuit.quiz.question)
    circuit.quiz.text=[circuit.quiz.text '<p>' circuit.quiz.question{q}.str ' '  circuit.quiz.question{q}.choicestr '<br></p>'];
end

