
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
    circuit.quiz.text=[circuit.quiz.text '<p>Arquivo: <a href="@@PLUGINFILE@@/' circuit.model(1).modelfile '">' circuit.model(1).modelfile '</a><br></p>'];
    circuit.quiz.nomearquivo=circuit.model(1).modelfile;
end

for q=1:length(circuit.quiz.question)
    circuit.quiz.text=[circuit.quiz.text '<p>' circuit.quiz.question{q}.str ' '  circuit.quiz.question{q}.choicestr '<br></p>'];
end

