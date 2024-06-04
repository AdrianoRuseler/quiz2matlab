function onlyfunc=isonlyfunc(quiz)
% verify if questions conteins only func as vartype

% Get questions
questions = quiz.question;
nq=length(questions);

vtype=cell(1,nq);

for q=1:nq
    vtype{q}=questions{q}.vartype{1};
end

if sum(contains(vtype,'func')) == nq
    onlyfunc=true;
else
    onlyfunc=false;
end