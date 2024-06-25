function [valuesrt]=value2srt(number)

exponent = 3*floor(log10(abs(number))/3); % find exponent
mantissa = number/(10^exponent); % find mantissa

if isinf(exponent) % If is inf!
    valuesrt= 'inf';
else
    UnitPrefix = {'y','z', 'a', 'f', 'p', 'n', 'u', 'm', '', 'k', 'MEG', 'G', 'T', 'P', 'E', 'Z','Y'};
    indx=exponent/3 +9;
    if indx<18
        valuesrt=[num2str(mantissa) UnitPrefix{indx}];
    else
        valuesrt=[num2str(mantissa) 'e' num2str(exponent)];
    end
end
% disp(valuesrt)