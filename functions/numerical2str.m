

function [multicell]=numerical2str(value,minabsval,unit,opttol)

% multicell='{1:NUMERICAL:'; %  {1:NUMERICAL:~%100%704.000:70.400} mV
[~,~, expstr, mantissa] = real2eng(value,unit,minabsval);
multicell=['{1:NUMERICAL:~%100%' sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*opttol/100)) '}' expstr];  %  sprintf('%3.3f',mantissa)







            