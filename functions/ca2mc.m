function mcca=ca2mc(ca) % create multiple choice from cell array

% ca = arrayfun(@num2str,randi(256,1,5), 'UniformOutput', 0);
% ca = arrayfun(@num2str,rand(1,5), 'UniformOutput', 0);
uca=unique(ca);
qp=length(uca);
qpstr=num2str(qp);
nca=length(ca);

mcca=cell(1,nca);

% mcstr=[':MULTICHOICE:' uca{1}];
% for i=2:qp
%     % {1:MULTICHOICE:%100%0~1}
%     mcstr=[mcstr '~' uca{i}];
% end
% mcstr=[mcstr '}'];

for i=1:nca
    n=find(strcmpi(uca,ca{i}));
    mcstr=['{' qpstr ':MULTICHOICE:'];
    for x=1:qp
        if x==n
            mcstr=[mcstr '%100%' uca{x} '~'];
        else
            mcstr=[mcstr uca{x} '~'];
        end
    end
    mcca{i}=[mcstr(1:end-1) '}'];
    % mcca{i} = ['{' qpstr  insertBefore(mcstr,ca{i},'%100%')];
    % disp(mcca{i})
end




