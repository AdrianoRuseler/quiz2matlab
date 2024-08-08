function  [band,quiz,valuestr,colornamestr] = rbandcolorid(Value,tol,EXX)

% rbandcolorid Brief description of the function's purpose.
%
%   Syntax:
%    [band,quiz,valuestr,colornamestr] = rbandcolorid(Value,tol,EXX)
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
%   quiz - Cloze quiz MULTICHOICE fields.
%   valuestr - Resistor value and tolerance string.
%   colornamestr - String with Resistor colors names.
%
%   Example:
%   [band,quiz,valuestr,colornamestr] = rbandcolorid(15e3,5,'E24')
%   [band,quiz,valuestr,colornamestr] = rbandcolorid(1e3,1,'E48')
%
%   See also: List related functions or files, if applicable.
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
    quiz=[];
    valuestr='';
    colornamestr='';
    disp(['Resistor ' num2str(Value) ' not found!!'])
    return
end

%  E(eind)*multiplier(mind)

tind=find((torelancia*100)==(tol*100));
if isempty(tind) % Resistor not found
    band=[];
    quiz=[];
    valuestr='';
    colornamestr='';
    disp('Toleramce not found!!')
    return
end


str='{1:MULTICHOICE:';
for a=1:length(multiplier)
    if a==mind
        str = strcat(str,['~%100%' real2eng(multiplier(a),'&Omega;') ]);
    else
        str = strcat(str,['~' real2eng(multiplier(a),'&Omega;')]);
    end
end
quiz.mulMULTICHOICE = strcat(str,'}');



str='{1:MULTICHOICE:';
for a=1:length(torelancia)
    if a==tind % resposta correta
        str = strcat(str,['~%100%' num2str(torelancia(a)) '%']);
    else
        str = strcat(str,['~' num2str(torelancia(a)) '%']);
    end
end
quiz.tolMULTICHOICE = strcat(str,'}');         
 
% Generate this: {1:MULTICHOICE_S:10~11~12~13~%100%15~16~18~20~22~24~27~30~33~36~39~43~47~51~56~62~68~75~82~91}
quiz.f123MULTICHOICE=strrep(['{1:MULTICHOICE:' strrep(num2str(E),'  ','~') '}'],num2str(E(eind)),['%100%' num2str(E(eind))]); % Cool

f123 = dec2base(E(eind),10) - '0';
f123 = f123+1; % Gera a sequência numérica

% multiplier=[0.01 0.1 1 10 100 1e3 10e3 100e3 1e6 10e6 100e6 1e9];
f4={12,11,1,2,3,4,5,6,7,8,9,10}; % Multiplicador
f5={9,8,7,6,2,3,11,13,13}; % Tolerance color

band=[f123 f4{mind} f5{tind}];

colornamestr = colorid2str(band);

% Creates color multichoice string
for b=1:length(band) % multichoicestrresistor
    bandidstr{b}='{1:MULTICHOICE:';    
    
    for a=1:length(colorname)
        if a==band(b)
            bandidstr{b} = strcat(bandidstr{b},['~%100%' colorname{a} ]);
        else
            bandidstr{b} = strcat(bandidstr{b},['~' colorname{a} ]);
        end       
    end    
   bandidstr{b} = strcat(bandidstr{b},'}');    
end


if length(band)==4
    quiz.tableMULTICHOICE=[ '<table>'...
        '<thead>'...
        '<tr><th scope="col">Faixa 1</th><th scope="col">Faixa 2</th><th scope="col">Faixa 3</th><th scope="col">Faixa 4</th></tr>'...
        '</thead>'...
        '<tbody>'...
        '<tr>'...
        '<td>' bandidstr{1} '</td>'...
        '<td>' bandidstr{2} '</td>'...
        '<td>' bandidstr{3} '</td>'...
        '<td>' bandidstr{4} '</td>'...
        '</tr>'...
        '</tbody>'...
        '</table>'];
elseif length(band)==5
    quiz.tableMULTICHOICE=[ '<table>'...
        '<thead>'...
        '<tr><th scope="col">Faixa 1</th><th scope="col">Faixa 2</th><th scope="col">Faixa 3</th><th scope="col">Faixa 4</th><th scope="col">Faixa 5</th></tr>'...
        '</thead>'...
        '<tbody>'...
        '<tr>'...
        '<td>' bandidstr{1} '</td>'...
        '<td>' bandidstr{2} '</td>'...
        '<td>' bandidstr{3} '</td>'...
        '<td>' bandidstr{4} '</td>'...
        '<td>' bandidstr{5} '</td>'...
        '</tr>'...
        '</tbody>'...
        '</table>'];
end

[str, ~ , expstr, mantissa, ~] = real2eng(Value,'&Omega;'); 

valuestr= [ str ' ±' num2str(torelancia(tind)) '%']; 
% Qual a melhor escala para medir o resistor
escalasR={'200 &Omega;','2 k&Omega;','20 k&Omega;','200 k&Omega;','2 M&Omega;','20 M&Omega;','200 M&Omega;'};
escala=[200 2e3 20e3 200e3 2e6 20e6 200e6];
torelancia=[0.05 0.1 0.25 0.5 1 2 5 10 20]/100; % emt(3)

quiz.valorNUMERICAL = ['{1:NUMERICAL:~%100%' num2str(mantissa) ':' ceil(num2str(mantissa*torelancia(tind))) '}'];

quiz.unitstr = expstr;
 
indp=find((escala-Value)>0);

if isempty(indp)
    indp=7;
end


strf5='{1:MULTICHOICE:';
for a=1:length(escalasR)
    if a==indp(1)
        strf5 = strcat(strf5,['~%100%' escalasR{a} ]);
    else
        strf5 = strcat(strf5,['~' escalasR{a} ]);
    end
end
quiz.escalaMULTICHOICE = strcat(strf5,'}');




