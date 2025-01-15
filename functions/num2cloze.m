function numczstr=num2cloze(number,tol,unitstr,qweight,minabsval)

% number=0.12345;
% numczstr=num2cloze(number);
% numczstr=num2cloze(number,20,'V');
% numczstr=num2cloze(number,10,'V','2');
% numczstr=num2cloze(number,0,'V');

if nargin < 5
    minabsval = 1e-24; % 
end

if nargin < 4
    qweight = '1'; % 
end

if nargin < 3
    unitstr = ''; % 
end

if nargin < 2
    tol = 0; % in percent
end
% [str, numstr, expstr, mantissa, exponent] = real2eng(number,unitstr,minabsval)
[~, ~, expstr, mantissa, ~] = real2eng(number,unitstr,minabsval);

if tol % Add question tolerance
    % tempstr=[sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*tol/100))];  %  sprintf('%3.3f',mantissa)
    numczstr=['{' qweight ':NUMERICAL:=' sprintf('%3.3f',mantissa) ':' sprintf('%3.3f',(mantissa*tol/100)) '}' expstr];
else
    % tempstr=sprintf('%3.3f',mantissa);
    numczstr=['{' qweight ':NUMERICAL:=' sprintf('%3.3f',mantissa) '}' expstr];
end



