function validatedStacks = verifyStacksStructure(stacks)
%VERIFYSTACKSSTRUCTURE Verifies the STACKS structure and fills missing fields with default values.
%   validatedStacks = verifyStacksStructure(stacks) takes a 'stacks'
%   structure, checks for the existence of expected fields, and
%   populates any missing fields with predefined default values.
%   This ensures the structure is complete before generating XML.

% Initialize validatedStacks with the input structure
% validatedStacks = stacks;

% --- Default values for top-level stacks fields ---

if isfield(stacks, 'xmlpath')
    validatedStacks.xmlpath = stacks.xmlpath;
end

if isfield(stacks, 'fname')
    validatedStacks.fname = stacks.fname;
end

% Ensure stacks.q exists and is a struct array
if ~isfield(stacks, 'q') || ~isstruct(stacks.q)
    stacks.q = struct([]); % Initialize as empty struct array if missing
end

% --- Iterate through each question ---
for qIdx = 1:length(stacks.q)
    question = stacks.q(qIdx);

    % --- Default values for question-level fields ---
    question = setMandatoryField(question, 'name', ['stack_q' num2str(qIdx)]);
    question = setMandatoryField(question, 'text', '');
    question = setDefaultField(question, 'generalfeedback', '');
    question = setDefaultField(question, 'penalty', '0.1');
    question = setDefaultField(question, 'hidden', '0');
    question = setDefaultField(question, 'idnumber', '');
    question = setDefaultField(question, 'defaultgrade', '1');
    question = setDefaultField(question, 'stackversion', '');
    question = setMandatoryField(question, 'questionvariables', '');
    question = setDefaultField(question, 'specificfeedback', '');

    question = setMandatoryField(question, 'questionnote', '');
    question = setDefaultField(question, 'questiondescription', '');
    question = setDefaultField(question, 'questionsimplify', '0');
    question = setDefaultField(question, 'assumepositive', '0');
    question = setDefaultField(question, 'assumereal', '0');

    question = setDefaultField(question, 'prtcorrect', '<span style="font-size: 1.5em; color:green;"><i class="fa fa-check"></i></span> Correct answer, well done.');
    question = setDefaultField(question, 'prtpartiallycorrect', '<span style="font-size: 1.5em; color:orange;"><i class="fa fa-adjust"></i></span> Your answer is partially correct.');
    question = setDefaultField(question, 'prtincorrect', '<span style="font-size: 1.5em; color:red;"><i class="fa fa-times"></i></span> Incorrect answer.');

    question = setDefaultField(question, 'decimals', '.');
    question = setDefaultField(question, 'scientificnotation', '*10');
    question = setDefaultField(question, 'multiplicationsign', 'dot');
    question = setDefaultField(question, 'sqrtsign', '1');
    question = setDefaultField(question, 'complexno', 'i');
    question = setDefaultField(question, 'inversetrig', 'cos-1');
    question = setDefaultField(question, 'logicsymbol', 'lang');
    question = setDefaultField(question, 'matrixparens', '[');
    question = setDefaultField(question, 'variantsselectionseed', '');

    % --- Default values for input structure ---
    if ~isfield(question, 'input') || ~isstruct(question.input)
        question.input = struct(); % Initialize if missing
    end
    question.input = setDefaultField(question.input, 'name', 'ans');
    question.input = setDefaultField(question.input, 'type', 'algebraic');
    question.input = setDefaultField(question.input, 'tans', 'ta');
    question.input = setDefaultField(question.input, 'boxsize', '15');
    question.input = setDefaultField(question.input, 'strictsyntax', '1');
    question.input = setDefaultField(question.input, 'insertstars', '0');
    question.input = setDefaultField(question.input, 'syntaxhint', '');
    question.input = setDefaultField(question.input, 'syntaxattribute', '0');
    question.input = setDefaultField(question.input, 'forbidwords', '');
    question.input = setDefaultField(question.input, 'allowwords', '');
    question.input = setDefaultField(question.input, 'forbidfloat', '1');
    question.input = setDefaultField(question.input, 'requirelowestterms', '0');
    question.input = setDefaultField(question.input, 'checkanswertype', '1');
    question.input = setDefaultField(question.input, 'mustverify','1');
    question.input = setDefaultField(question.input, 'showvalidation', '1');
    question.input = setDefaultField(question.input, 'options', '');

    % --- Default values for prt structure ---
    if ~isfield(question, 'prt') || ~isstruct(question.prt)
        question.prt = struct(); % Initialize if missing
    end
    question.prt = setDefaultField(question.prt, 'name', 'prt1');
    question.prt = setDefaultField(question.prt, 'value', '1.0000000');
    question.prt = setDefaultField(question.prt, 'autosimplify', '0');
    question.prt = setDefaultField(question.prt, 'feedbackstyle', '1');
    question.prt = setDefaultField(question.prt, 'feedbackvariables', '');

    % --- Default values for prt.node array ---
    if ~isfield(question.prt, 'node') || ~isstruct(question.prt.node)
        question.prt.node = struct([]); % Initialize as empty struct array if missing
    end

    for nodeIdx = 1:length(question.prt.node)
        node = question.prt.node(nodeIdx);
        node = setDefaultField(node, 'name', num2str(nodeIdx-1));
        node = setDefaultField(node, 'description', '');
        node = setDefaultField(node, 'answertest', 'AlgEquiv');
        node = setDefaultField(node, 'sans', 'ans');
        node = setDefaultField(node, 'tans', 'ta');
        node = setDefaultField(node, 'testoptions', '');
        node = setDefaultField(node, 'quiet', '0');
        node = setDefaultField(node, 'truescoremode', '=');
        node = setDefaultField(node, 'truescore','1.0');
        node = setDefaultField(node, 'truepenalty', '');
        node = setDefaultField(node, 'truenextnode', '-1');
        node = setDefaultField(node, 'trueanswernote', '1-0-T');
        node = setDefaultField(node, 'truefeedback', '');
        node = setDefaultField(node, 'falsescoremode', '=');
        node = setDefaultField(node, 'falsescore', '0.0');
        node = setDefaultField(node, 'falsepenalty', '0.0');
        node = setDefaultField(node, 'falsenextnode', '1');
        node = setDefaultField(node, 'falseanswernote', '1-0-F');
        node = setDefaultField(node, 'falsefeedback', '');
        question.prt.node(nodeIdx) = node; % Update the node in the structure
    end

    % --- Default values for deployedseed array ---
    if ~isfield(question, 'deployedseed') || ~isstruct(question.deployedseed)
        question.deployedseed = struct([]); % Initialize as empty struct array if missing
    end
    for seedIdx = 1:length(question.deployedseed)
        seed = question.deployedseed(seedIdx);
        seed = setDefaultField(seed, 'value', num2str(randi(2^31 - 1)));
        question.deployedseed(seedIdx) = seed;
    end

    % --- Default values for qtest array ---
    if ~isfield(question, 'qtest') || ~isstruct(question.qtest)
        question.qtest = struct([]); % Initialize as empty struct array if missing
    end
    for testIdx = 1:length(question.qtest)
        test = question.qtest(testIdx);
        test = setDefaultField(test, 'testcase', num2str(testIdx));
        test = setDefaultField(test, 'description', '');

        % Default values for testinput structure within qtest
        if ~isfield(test, 'testinput') || ~isstruct(test.testinput)
            test.testinput = struct();
        end
        test.testinput = setDefaultField(test.testinput, 'name', 'ans');
        test.testinput = setDefaultField(test.testinput, 'value', 'ta');

        % Default values for expected structure within qtest
        if ~isfield(test, 'expected') || ~isstruct(test.expected)
            test.expected = struct();
        end
        test.expected = setDefaultField(test.expected, 'name', 'prt1');
        test.expected = setDefaultField(test.expected, 'expectedscore', '1.0');
        test.expected = setDefaultField(test.expected, 'expectedpenalty', '0.1');
        test.expected = setDefaultField(test.expected, 'expectedanswernote', '1-0-T');

        question.qtest(testIdx) = test; % Update the test in the structure
    end

    validatedStacks.q(qIdx) = question; % Update the question in the main structure
end

end

% Helper function to set a field with a default value if it doesn't exist
function s = setDefaultField(s, fieldName, defaultValue)
    if ~isfield(s, fieldName) || isempty(s.(fieldName))
        s.(fieldName) = defaultValue;
    end
end

% Helper function to handle mandatory fields and issue warnings
function s = setMandatoryField(s, fieldName, defaultValue)
    if ~isfield(s, fieldName) || isempty(s.(fieldName))
        warning('STACKS:MissingMandatoryField', ['Mandatory field ' fieldName ' is missing or empty for question.']);
        s.(fieldName) = defaultValue; % Still set to empty to avoid errors later, but warn
    end
end

