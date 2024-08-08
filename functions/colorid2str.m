function  colornamestr = colorid2str(band)

% colorid2str Returns a string of Resistor colors
%
%   Syntax:
%    [band] = getcolorid(Value,tol,EXX)
%
%   Description:
%   Detailed description of the function, including its main purpose and
%   any important details about its operation.
%
%   Inputs:
%   band - Resistor color value index from colorname vector
%   colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};

%   Value - Resistor value
%   tol - Resistor tolerance in %
%   EXX - Resistor E group, E06, E12 E24 E48...
%
%   Outputs:
%   colornamestr - Resistor color value index from colorname vector
%
%   Example:
%   colornamestr = colorid2str([1 2 3 4 5])
%   

colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};

if length(band)==4    
    colornamestr=[ colorname{band(1)} ', ' colorname{band(2)} ', ' colorname{band(3)} ' e ' colorname{band(4)} ];    
elseif length(band)==5
    colornamestr=[ colorname{band(1)} ', ' colorname{band(2)} ', ' colorname{band(3)} ', ' colorname{band(4)} ' e ' colorname{band(5)} ];    
elseif length(band)==6 % Somente com coeficiente de temperatura
    colornamestr=[ colorname{band(1)} ', ' colorname{band(2)} ', ' colorname{band(3)} ', ' colorname{band(4)} ', ' colorname{band(5)} ' e ' colorname{band(6)} ];
end



