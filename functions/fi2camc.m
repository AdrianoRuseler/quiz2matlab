function camc=fi2camc(a,lmcs,carry) % create cell array multiple choice from fi object

% lmcs line multiple choices
% carry - eliminate MSB bit from output

% a = fi(1.2, 1, 8, 5); % Build fi object
% camc=fi2camc(a,[0 0 0 0])
% init output;
% html=''; % Tabela estática com todos os campos preenchidos
% html2=''; % Tabela com multipla escolha no campo data e demais campos preenchidos
% data bit peso valor
if nargin == 1
    lmcs=[0 0 0 0]; % if is 1 (per line), return mc options
    carry=0;
end

if nargin == 2
    carry=0;
end

if ~isfi(a)  % Determine whether variable is fi object
    disp('Requires fi object!')
    return
end

% tf = isfixed(a) % Determine whether input is fixed-point data type
% y = isfloat(a)

T = numerictype(a); % get numeric type
% T.DataTypeMode;

% vals=20;
sign=issigned(a);
wlen=T.WordLength;

if carry
    wlen=wlen-1;
end

flen=T.FractionLength;

m=wlen-flen-sign; % m is the number of bits used for the integer part of the value
% n=flen;% n is the number of fraction bits

bd=cell(1,wlen); % Cell with bit data
bp=cell(1,wlen); % Cell with bit position
bw=cell(1,wlen); % Cell with bit weight
bv=cell(1,wlen); % Cell with bit value

if issigned(a) % Com sinal?
    if logical(bitget(a,wlen))
        bw{wlen}=['\(-2^{' num2str(m) '}\)'];
        bv{wlen}=['\(-' num2str(2^m) '\)'];
    else
        bw{wlen}='\(+\)';
        bv{wlen}='+';
    end

    bd{wlen}=bitget(a,wlen).bin;
    bp{wlen}=num2str(wlen);

    for x=2:wlen
        bw{wlen-x+1}=['\(2^{' num2str(wlen-flen-x) '}\)'];
        % bv{wlen-x+1}=['\(' num2str(2^(wlen-flen-x)) '\)'];
        bv{wlen-x+1}=num2str(2^(wlen-flen-x));
        bd{wlen-x+1}=bitget(a,wlen-x+1).bin;
        bp{wlen-x+1}=num2str(wlen-x+1);
    end
else
    for x=1:wlen
        bw{wlen-x+1}=['\(2^{' num2str(wlen-flen-x) '}\)'];
        % bv{wlen-x+1}=['\(' num2str(2^(wlen-flen-x)) '\)'];
        bv{wlen-x+1}=num2str(2^(wlen-flen-x));
        bd{wlen-x+1}=bitget(a,wlen-x+1).bin;
        bp{wlen-x+1}=num2str(wlen-x+1);
    end
end

% bd=cell(1,wlen); % Cell with bit data
% bp=cell(1,wlen); % Cell with bit position
% bw=cell(1,wlen); % Cell with bit weight
% bv=cell(1,wlen); % Cell with bit value

% Cell with bit data
if lmcs(1) % Multiple Choice?
    bdca=ca2mc(bd);
else
    bdca=bd;
end

% Cell with bit position
if lmcs(2) % Multiple Choice?
    bpca=ca2mc(bp);
else
    bpca=bp;
end

% Cell with bit weight
if lmcs(3)
    bwca=ca2mc(bw);
else
    bwca=bw;
end

% Cell with bit value
if lmcs(4)
    bvca=ca2mc(bv);
else
    bvca=bv;
end

nlmc=length(lmcs);
camc=cell(nlmc,wlen+1);

% Data Bit Peso Valor
camc{1,1}='Data';
camc{2,1}='Bit';
camc{3,1}='Peso';
camc{4,1}='Valor';

for x=2:wlen+1
    camc{1,x}=bdca{wlen-x+2};
    camc{2,x}=bpca{wlen-x+2};
    camc{3,x}=bwca{wlen-x+2};
    camc{4,x}=bvca{wlen-x+2};
end

% for x=2:wlen+1
%     camc{1,x}=bdca{x-1};
%     camc{2,x}=bpca{x-1};
%     camc{3,x}=bwca{x-1};
%     camc{4,x}=bvca{x-1};
% end

% wlen-x+1