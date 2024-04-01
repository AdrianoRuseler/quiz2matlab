function [mkca, ttca] = ttk2table(ttstr,nvars)
% OBSOLETE, USE:
% mkca=mm2mkca(mmstr,nvars,type) % Return Karnaugh Map from minterms or maxterms
% ttca=mm2ttca(mmstr,nvars,type) % Return truth table from minterms or maxterms
% ttstr='m(4,6,9,10,11,13)+d(2,12,15)';
% [kMat, tMat] = ttk2table(ttstr);

if nargin==1
    nvars=2;
end

% % mkca=mm2mkca(ttstr,nvars,'clozemc');
mkca=mm2mkca(ttstr,nvars,'html');

% % ttca=mm2ttca(ttstr,nvars,'clozemc')
ttca=mm2ttca(ttstr,nvars,'html');