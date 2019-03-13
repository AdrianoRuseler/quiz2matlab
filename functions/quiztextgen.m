
% Generates quiz text field

function circuit = quiztextgen(circuit)

circuit.quiz.text = [ '<p>'  circuit.quiz.enunciado  '<br></p>'  circuit.quiz.fightml ];

for q=1:length(circuit.quiz.question)
    circuit.quiz.text=[circuit.quiz.text '<p>' circuit.quiz.question{q}.str ' '  circuit.quiz.question{q}.choicestr '<br></p>'];   
end

