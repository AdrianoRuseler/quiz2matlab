function  band = getcolorid(Value,tol,EXX)

% getcolorid Resistor color value index from colorname vector
%
%   Syntax:
%    [band] = getcolorid(Value,tol,EXX)
%
%   Description:
%   Detailed description of the function, including its main purpose and
%   any important details about its operation.
%
%   Inputs:
%   Value - Resistor value
%   tol - Resistor tolerance in %
%   EXX - Resistor E group, E06, E12 E24 E48...
%
%   Outputs:
%   band - Resistor color value index from colorname vector
%   colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};
%
%   Example:
%   band = getcolorid(15e3,5,'E24')
%   band = getcolorid(1e3,1,'E48')
%


E = geteseries(EXX); % Get E series values.

multiplier=[0.01 0.1 1 10 100 1e3 10e3 100e3 1e6 10e6 100e6 1e9];
torelancia=[0.05 0.1 0.25 0.5 1 2 5 10 20]; % Tolerance in percentage

Rs=multiplier.*E'; % Generate all series resistors combination


if Value>=10 % Just integer numbers in find function
    [eind,mind] = find(Rs==Value);
else
    [eind,mind] = find(Rs==round(Value*100));
    mind=mind-2;
end

if isempty(eind) % Resistor not found
    band=[];
    disp(['Resistor ' num2str(Value) ' not found!!'])
    return
end

%  E(eind)*multiplier(mind)

tind=find((torelancia*100)==(tol*100));
if isempty(tind) % Resistor not found
    band=[];
    disp('Toleramce not found!!')
    return
end

f123 = dec2base(E(eind),10) - '0';
f123 = f123+1; % Gera a sequência numérica

% multiplier=[0.01 0.1 1 10 100 1e3 10e3 100e3 1e6 10e6 100e6 1e9];
f4={12,11,1,2,3,4,5,6,7,8,9,10}; % Multiplicador
f5={9,8,7,6,2,3,11,13,13}; % Tolerance color

band=[f123 f4{mind} f5{tind}];
