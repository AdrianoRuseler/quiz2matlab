function [html,html2]=fi2table(a) % create html code to store file

% init output;
html=''; % Tabela estática com todos os campos preenchidos
html2=''; % Tabela com multipla escolha no campo data e demais campos preenchidos

if ~isfi(a)  % Determine whether variable is fi object
    disp('Requires fi object!')
    return
end

% tf = isfixed(a) % Determine whether input is fixed-point data type
% y = isfloat(a)

T = numerictype(a); % get numeric type
% T.DataTypeMode;

% vals=20;
sign=issigned(a);
wlen=T.WordLength;
flen=T.FractionLength;

m=wlen-flen-sign; % m is the number of bits used for the integer part of the value
n=flen;% n is the number of fraction bits

if issigned(a) % Com sinal?
    if logical(bitget(a,wlen))
        bw{wlen}=['\(-2^{' num2str(m) '}\)'];
        bv{wlen}=['\(-' num2str(2^m) '\)'];
    else
        bw{wlen}='\(+\)';
        bv{wlen}='\(+\)';
    end

    for x=2:wlen
        bw{wlen-x+1}=['\(2^{' num2str(wlen-flen-x) '}\)'];
        bv{wlen-x+1}=['\(' num2str(2^(wlen-flen-x)) '\)'];
    end
else
    for x=1:wlen
        bw{wlen-x+1}=['\(2^{' num2str(wlen-flen-x) '}\)'];
        bv{wlen-x+1}=['\(' num2str(2^(wlen-flen-x)) '\)'];
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
tbodystr3='<tr><td>Valor</td>';

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
    tbodystr3=[tbodystr3 '<td>' bv{b} '</td>'];
end
theadstr=[theadstr '</tr></thead>'];
theadstr2=[theadstr2 '</tr></thead>'];
tbodystr=[tbodystr  '</tr>'];
tbodystr2=[tbodystr2  '</tr>'];
tbodystr3=[tbodystr3  '</tr>'];

% %  bitget(a,wlen-(j-1)).bin
% tbodystr='<tbody><tr>';
% for i=1:wlen
%     tbodystr=[tbodystr '<td>' bitget(a,wlen-(i-1)).bin '</td>'];
% end
% tbodystr=[tbodystr  '</tr></tbody>'];

% Tabela estática com todos os campos preenchidos
html=['<div class="table-responsive-sm"><table class="table table-bordered table-hover" style="width:100px">' theadstr tbodystr tbodystr2 tbodystr3 '</tbody></table></div>'];

% Tabela com multipla escolha no campo data e demais campos preenchidos
html2=['<div class="table-responsive-sm"><table class="table table-bordered table-hover" style="width:100px">' theadstr2 tbodystr tbodystr2 tbodystr3 '</tbody></table></div>'];

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
