function  strout = logdata2param(logdatastruct)

% logdatastruct = circuit.logdata{1}{1}
% disp(logdatastruct)
strout= '';


fields = fieldnames(logdatastruct);

for f=3:length(fields)
    vars =[fields{f} char(logdatastruct.(fields{1})) char(logdatastruct.(fields{2}))];
    % disp(vars)
    strout= [ strout  ' ' vars '=' num2str(logdatastruct.(fields{f}))];
end
