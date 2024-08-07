function R = combres(Rn,Mult,EXX)

% combres returns standard resistors from E series and multiplier
%
%   Syntax:
%   R = combres(Rn,Mult,EXX)
%
%   Description:
%   Returns standard resistors (R) from E series (EXX) and multiplier (Mult) with array combvec by (Rn) times.
%
%   Inputs:
%   Rn - array combvec by (Rn) times.
%   Mult - multiplier (Mult).
%   EXX - E series (EXX). E06, E12, E24, E48, E96 and E192.
%
%   Outputs:
%   R - Resistors values.
%
%   Example:
%   % resistor = combres(1,[10 100],'E12')


% colorname={'Preto','Marrom','Vermelho','Laranja','Amarelo','Verde','Azul','Violeta','Cinza','Branco','Dourado','Prata','Ausente'};

% Verifica argumentos fornecidos
switch nargin
    case  0
        R=[];
        return
    case  1
       Mult=1;
       EXX='E12';
    case  2
       EXX='E12';       
end

% multiplier=[0.01 0.1 1 10 100 1e3 10e3 100e3 1e6 10e6 100e6 1e9];
% torelancia=[0.05 0.1 0.25 0.5 1 2 5 10 20];
% f3={12,11,1,2,3,4,5,6,7,8,9,10}; % Cor do Multiplicador
% f4={9,8,7,6,2,3,11,12,13}; %Cor da Tolerancia

E = geteseries(EXX); % Get E series values.

if Mult==0 % if mult is 0, use all multipliers
    Mult=[0.01 0.1 1 10 100 1e3 10e3 100e3 1e6 10e6 100e6 1e9];
end

x=length(Mult);
y=length(E);

Rs=zeros(1,x*y);
n=1;
for mx=1:x % Resistor multiplier
    for ex=1:y
        Rs(n)=Mult(mx)*E(ex);
        n=n+1;
    end
end

switch Rn % Numero de resistores
    case 1
        R=Rs;
    case 2
        R= combvec(Rs,Rs);
    case 3
        R= combvec(Rs,Rs,Rs);
    case 4
        R= combvec(Rs,Rs,Rs,Rs);
    case 5
        R= combvec(Rs,Rs,Rs,Rs,Rs);
    case 6
        R= combvec(Rs,Rs,Rs,Rs,Rs,Rs);        
    otherwise
        disp('Too much combinations! Limited to 6!')
        R= combvec(Rs,Rs,Rs,Rs,Rs,Rs);
end





