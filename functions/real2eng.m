
% Convert real number to str with SI prefix plus unit

function [str, numstr, expstr, mantissa, exponent] = real2eng(number,unitstr)

if ~isreal(number) % Is this number real?
    str='Not a real munber!';
    numstr='';
    expstr='';
    mantissa=NaN;
    exponent=NaN;
    return % only real numbers
end


exponent = 3*floor(log10(abs(number))/3); % find exponent
mantissa = number/(10^exponent); % find mantissa

expHTML = {' y',' z', ' a', ' f', ' p', ' n', ' &micro;', ' m', ' ', ' k', ' M', ' G', ' T', ' P', ' E', ' Z',' Y'};
% expName = {' y',' z', ' a', ' f', ' p', ' n', ' u', ' m', '', ' k', ' M', ' G', ' T', ' P', ' E', ' Z',' Y'};

if isinf(exponent) % If is inf!
    expstr=[' ' unitstr];
    numstr = '0';
    mantissa = 0;
else
    expstr= [expHTML{exponent/3 +9} unitstr];
    numstr = strrep(num2str(mantissa),'.',',');
end


% expValue = [-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24];
% numstr = strrep(num2str(mantissa,'%3.3f'),'.',',');

str = [numstr expstr];


