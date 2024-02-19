% =========================================================================
% *** cloze2md
% clozes.xmlpath=pwd;
% clozes.fname='qfilename';
%
% % Create question 1
% clozes.q(1).name='Q01 name';
% clozes.q(1).comment='comment for Q01';
% clozes.q(1).text='Q01: {1:MULTICHOICE:California#Wrong~%100%Arizona#OK}';
% clozes.q(1).generalfeedback='Q01 feedback';
% clozes.q(1).penalty='0.25';
% clozes.q(1).hidden='0';
% clozes.q(1).idnumber='id0';
%
% cloze2md(clozes)
%
% =========================================================================

%%% TODO
function mdfile=cloze2md(clozes) % Generate md file

% # A first-level heading
% ## A second-level heading
% ### A third-level heading


if isfield(clozes,'mdpath')
    if ~exist(clozes.mdpath,'dir')
        mkdir(clozes.mdpath) % Sem verificação de erro
    end
else
    clozes.mdpath=pwd;
end

% Number os questions
if isfield(clozes,'q')
    nq=length(clozes.q);
else
    disp('No questions in cloze struct!')
    return
end


% md file name
dt = char(datetime('now','Format','yyyMMddHHmmss'));
mdfilename= [clozes.fname 'D' dt 'NQ' num2str(nq,'%03i') '.md'];
mdfile=[clozes.mdpath '\' mdfilename];

fileID = fopen(mdfile,'w','n','UTF-8');
if fileID==-1
    disp('File error!!')
    return
end

fprintf(fileID,'%s\n',['## ' mdfilename]); % A 2-level heading

for q=1:nq
    fprintf(fileID,'%s\n',['### ' clozes.q(q).name]); % A 3-level heading

    if isfield(clozes.q(q),'penalty')
        penalty=clozes.q(q).penalty;
    else
        penalty='0.3333333';
    end

    if isfield(clozes.q(q),'hidden')
        hidden=clozes.q(q).hidden;
    else
        hidden='0';
    end

    if isfield(clozes.q(q),'idnumber')
        theader='type | penalty | hidden | idnumber';
        tline='--- | --- | --- | ---:';
        tdata=['cloze  | ' penalty ' | ' hidden ' | ' clozes.q(q).idnumber ];
    else
        theader='type | penalty | hidden ';
        tline='--- | --- | ---:';
        tdata=['cloze | ' penalty ' | ' hidden  ];
    end


    fprintf(fileID,'%s\n', theader); % Table header
    fprintf(fileID,'%s\n',tline); % Table line
    fprintf(fileID,'%s\n',tdata); % Table data


    fprintf(fileID,'%s\n','#### questiontext'); % A 4-level heading
    fprintf(fileID,'%s\n','```html'); % html field
    fprintf(fileID,'%s\n',clozes.q(q).text); % html field
    fprintf(fileID,'%s\n','```'); % html field

    if isfield(clozes.q(q),'generalfeedback')
        fprintf(fileID,'%s\n','#### generalfeedback'); % html field
        fprintf(fileID,'%s\n','```html'); % html field
        fprintf(fileID,'%s\n',clozes.q(q).generalfeedback); % html field
        fprintf(fileID,'%s\n','```'); % html field
    end

    fprintf(fileID,'%s\n',' '); % html field

end

fclose(fileID);


% type(XMLfile);
% xml2html(XMLfile)

winopen(clozes.mdpath)


