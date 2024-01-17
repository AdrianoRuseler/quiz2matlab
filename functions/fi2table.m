function [html,html2]=fi2table(a) % create html code to store file

% init output;
html='';

if ~isfi(a)  % Determine whether variable is fi object
    disp('Requires fi object!')
    return
end

% tf = isfixed(a) % Determine whether input is fixed-point data type
% y = isfloat(a)

% get numeric type
T = numerictype(a);
% T.DataTypeMode;

% vals=20;
sign=issigned(a);
wlen=T.WordLength;
flen=T.FractionLength;

if issigned(a)
    if logical(bitget(a,wlen))
        bw{wlen}='\(-\)';
    else
        bw{wlen}='\(+\)';
    end

    for x=2:wlen
        bw{wlen-x+1}=['\(2^{' num2str(wlen-flen-x) '}\)'];
    end
else
    for x=1:wlen
        bw{wlen-x+1}=['\(2^{' num2str(wlen-flen-x) '}\)'];
    end
end

% bw= % bit weight

% a.bin
% b = bitget(a,wlen:-1:1)

% a.bin
% a.dec
% a.hex
% a.oct
% a.double
% storedInteger(a)

%
%
% [l,c]=size(kMap);
%
% % <table class="table">
%
theadstr='<thead><tr><th>Data</th>';
theadstr2='<thead><tr><th>Data</th>';
tbodystr='<tbody><tr><td>Bit</td>';
tbodystr2='<tr><td>Peso</td>';
for j=1:wlen
    b=wlen-(j-1); % gets bit
    theadstr=[theadstr '<th>' bitget(a,b).bin  '</th>'];
    switch bitget(a,b).bin
        case '0'
            theadstr2=[theadstr2 '<td>{1:MULTICHOICE:%100%0~1}</td>'];
        case '1'
            theadstr2=[theadstr2 '<td>{1:MULTICHOICE:0~%100%1}</td>'];
        otherwise
            theadstr2=[theadstr2 '<td>{1:MULTICHOICE:0~1~%100%X}</td>'];
    end

    tbodystr=[tbodystr '<td>' num2str(b) '</td>'];
    tbodystr2=[tbodystr2 '<td>' bw{b} '</td>'];
end
theadstr=[theadstr '</tr></thead>'];
theadstr2=[theadstr2 '</tr></thead>'];
tbodystr=[tbodystr  '</tr></tbody>'];

% %  bitget(a,wlen-(j-1)).bin
% tbodystr='<tbody><tr>';
% for i=1:wlen
%     tbodystr=[tbodystr '<td>' bitget(a,wlen-(i-1)).bin '</td>'];
% end
% tbodystr=[tbodystr  '</tr></tbody>'];

%
html=['<div class="table-responsive-sm"><table class="table table-bordered table-hover" style="width:100px">' theadstr tbodystr tbodystr2 '</table></div>'];
%
html2=['<div class="table-responsive-sm"><table class="table table-bordered table-hover" style="width:100px">' theadstr2 tbodystr tbodystr2 '</table></div>'];

% html=[theadstr tbodystr];




%     for j=1:c
%         if j==1
%             tbodystr=[tbodystr '<td><strong>' kMap{i,j} '</strong></td>'];
%         else
%             switch kMap{i,j}
%                 case '0'
%                     tbodystr=[tbodystr '<td>{1:MULTICHOICE:%100%0~1~X}</td>'];
%                 case '1'
%                     tbodystr=[tbodystr '<td>{1:MULTICHOICE:0~%100%1~X}</td>'];
%                 otherwise
%                     tbodystr=[tbodystr '<td>{1:MULTICHOICE:0~1~%100%X}</td>'];
%             end
%         end
%     end
