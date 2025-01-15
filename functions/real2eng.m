
% Convert real number to str with SI prefix plus unit

function [str, numstr, expstr, mantissa, exponent] = real2eng(number,unitstr,minabsval)

if ~isreal(number) % Is this number real?
    str='Not a real munber!';
    numstr='';
    expstr='';
    mantissa=NaN;
    exponent=NaN;
    return % only real numbers
end

if isnan(number)
    str='It is a NaN!';
    numstr='';
    expstr='';
    mantissa=NaN;
    exponent=NaN;
    return % only real numbers
end

if nargin < 3
    minabsval = 1e-12; % Se não informado o campo 3
end

if abs(number) < minabsval
    number = 0;
end


exponent = 3*floor(log10(abs(number))/3); % find exponent
mantissa = number/(10^exponent); % find mantissa
indx=exponent/3 +9;
% disp(number)
% disp(exponent)
% disp(mantissa)

expHTML = {' y',' z', ' a', ' f', ' p', ' n', ' &micro;', ' m', ' ', ' k', ' M', ' G', ' T', ' P', ' E', ' Z',' Y'};
% expName = {' y',' z', ' a', ' f', ' p', ' n', ' u', ' m', '', ' k', ' M', ' G', ' T', ' P', ' E', ' Z',' Y'};

if isinf(exponent) % If is inf!
    expstr=[' ' unitstr];
    numstr = '0';
    mantissa = 0;
elseif indx<18
    expstr= [expHTML{indx} unitstr];
    numstr = strrep(num2str(mantissa),'.',',');
else
    expstr= ['e' num2str(exponent) unitstr];
    numstr = strrep(num2str(mantissa),'.',',');
end


% expValue = [-24,-21,-18,-15,-12,-9,-6,-3,0,3,6,9,12,15,18,21,24];
% numstr = strrep(num2str(mantissa,'%3.3f'),'.',',');

% str = [numstr expstr];

str = strtrim([numstr expstr]);


