function [qfstr,qfnum]=fi2qnum(a) % create Q format numeric cloze question from fi object
% qfnum=fi2qnum(a);

T = numerictype(a); % get numeric type
sign=issigned(a);
wlen=T.WordLength;
flen=T.FractionLength;

m=wlen-flen-sign; % m is the number of bits used for the integer part of the value
n=flen;% n is the number of fraction bits

qfstr=['Q' num2str(m) '.' num2str(n) ]; % Q format
qfnum=['Q{1:NUMERICAL:=' num2str(m) '}.{1:NUMERICAL:=' num2str(n) '}']; % Q format
