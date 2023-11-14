% 
% ttstr='m(4,6,9,10,11,13)+d(2,12,15)';
% [kMat, tMat] = ttk2table(ttstr);

function [kMat, tMat] = ttk2table(ttstr)

matchCell = regexp(ttstr, '(\d+)(,\s*\d+)*', 'match');
dontCares=[];
[truthTable] = unique(str2num(matchCell{1}));
if (length(matchCell) == 2)
    [dontCares] = unique(str2num(matchCell{2}));
end

nmax=max([truthTable dontCares]);
nbits=ceil(log2(nmax));
% T=dec2bin([0:2^nbits-1],nbits)
tbase=num2cell(dec2bin(0:2^nbits-1,nbits));
tMat = cell(2^nbits+1, nbits+1);
tMat{1,2}='A';
tMat{1,3}='B';

switch nbits
    case 2
        tMat{1,4}='Y';
        [kMat, truthTable] = karnaughMap(ttstr, [1, 1]);
    case 3
        tMat{1,4}='C';
        tMat{1,5}='Y';
        [kMat, truthTable] = karnaughMap(ttstr, [2, 1]);
    case 4
        tMat{1,4}='C';
        tMat{1,5}='D';
        tMat{1,6}='Y';
        [kMat, truthTable] = karnaughMap(ttstr, [2, 2]);
    otherwise
        kMat=[];
        truthTable=[];
        return
end

for i=1:length(truthTable)
    nb(i)=bin2dec(cell2mat({truthTable{i,1:end-1}}));
    nv{i}=truthTable{i,end};
end

if (ttstr(1) == 'M') % "m" (for minterm) or "M" (for maxterm) 
    ndef='1';
else
    ndef='0';
end

for j=1:2^nbits
    ind = find(nb==j-1);
    if isempty(ind)
        tbase{j,nbits+1}=ndef;
    else
        tbase{j,nbits+1}=nv{ind};
    end
end

for j=1:2^nbits
    tMat{j+1,1}=num2str(j-1);
    for i=1:nbits+1
        tMat{j+1,i+1}=tbase{j,i};
    end
end

 

        

