function stacks=stackverify(stacks) % Verifies stack structure

% Number os questions
if isfield(stacks,'q')
    nq=length(stacks.q);
else
    disp('No questions in cloze struct!')
    return
end

% Verify for usetidy
if isfield(stacks,'usetidy')
    % https://github.com/htacg/tidy-html5
    [status,tidyver] = system('tidy --version');
    if status
        disp(tidyver)
        disp('https://github.com/htacg/tidy-html5')
        stacks.usetidy=0;
    else
        stacks.usetidy=1;
    end
else
    stacks.usetidy=0;
end

% Init all nom existing or empty fields
for q=1:nq
    % if ~isfield(stacks.q(q),'comment') || isempty(stacks.q(q).comment)
    %     stacks.q(q).comment='';
    % end
    if ~isfield(stacks.q(q),'generalfeedback') || isempty(stacks.q(q).generalfeedback)
        stacks.q(q).generalfeedback='';
    end
    if ~isfield(stacks.q(q),'penalty') || isempty(stacks.q(q).penalty)
        stacks.q(q).penalty='0.3333333';
    end
    if ~isfield(stacks.q(q),'hidden') || isempty(stacks.q(q).hidden)
        stacks.q(q).hidden='0';
    end
    if ~isfield(stacks.q(q),'defaultgrade') || isempty(stacks.q(q).defaultgrade)
        stacks.q(q).defaultgrade='';
    end
    if ~isfield(stacks.q(q),'idnumber') || isempty(stacks.q(q).idnumber)
        stacks.q(q).idnumber='';
    end
    if stacks.usetidy
        stacks.q(q).text = formathtml(stacks.q(q).text);
    end

    if ~isfield(stacks.q(q),'questionsimplify') || isempty(stacks.q(q).questionsimplify)
        stacks.q(q).questionsimplify='0';
    end
    if ~isfield(stacks.q(q),'assumepositive') || isempty(stacks.q(q).assumepositive)
        stacks.q(q).assumepositive='0';
    end
    if ~isfield(stacks.q(q),'assumereal') || isempty(stacks.q(q).assumereal)
        stacks.q(q).assumereal='0';
    end

    if ~isfield(stacks.q(q),'decimals') || isempty(stacks.q(q).decimals)
        stacks.q(q).decimals='.';
    end
    if ~isfield(stacks.q(q),'scientificnotation') || isempty(stacks.q(q).scientificnotation)
        stacks.q(q).scientificnotation='*10';
    end
    if ~isfield(stacks.q(q),'multiplicationsign') || isempty(stacks.q(q).multiplicationsign)
        stacks.q(q).multiplicationsign='dot';
    end
    if ~isfield(stacks.q(q),'sqrtsign') || isempty(stacks.q(q).sqrtsign)
        stacks.q(q).sqrtsign='1';
    end
    if ~isfield(stacks.q(q),'complexno') || isempty(stacks.q(q).complexno)
        stacks.q(q).complexno='i';
    end
    if ~isfield(stacks.q(q),'inversetrig') || isempty(stacks.q(q).inversetrig)
        stacks.q(q).inversetrig='cos-1';
    end
    if ~isfield(stacks.q(q),'logicsymbol') || isempty(stacks.q(q).logicsymbol)
        stacks.q(q).logicsymbol='lang';
    end
    if ~isfield(stacks.q(q),'matrixparens') || isempty(stacks.q(q).matrixparens)
        stacks.q(q).matrixparens='[';
    end
    if ~isfield(stacks.q(q),'variantsselectionseed') || isempty(stacks.q(q).variantsselectionseed)
        stacks.q(q).variantsselectionseed='';
    end

    if ~isfield(stacks.q(q),'input') || isempty(stacks.q(q).input)
        stacks.q(q).input='';
    end

end