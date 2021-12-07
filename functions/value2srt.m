function [valuesrt]=value2srt(number)

exponent = 3*floor(log10(abs(number))/3); % find exponent
mantissa = number/(10^exponent); % find mantissa

if isinf(exponent) % If is inf!
    valuesrt= '0';
else
    UnitPrefix = {'y','z', 'a', 'f', 'p', 'n', 'u', 'm', '', 'k', 'MEG', 'G', 'T', 'P', 'E', 'Z','Y'};
    valuesrt=[num2str(mantissa) UnitPrefix{exponent/3 +9}];
end
% disp(valuesrt)