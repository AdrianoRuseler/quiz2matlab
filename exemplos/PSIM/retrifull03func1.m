function  out = retrifull03func1(parvalues) % Function 1 for ret8

% parname={'Vi','fi','alpha','L0','R0','a'}; % Variables names

% Vi=parvalues(1);
fi=parvalues(2);
alpha=parvalues(3)+60; % alpha monofásico

L0=parvalues(4);
R0=parvalues(5);
a=parvalues(6);

X0=2*pi*fi*L0;

phi=atan(X0/R0);

alphanim = asin(a);
% beta = puschlowski(a,phi,alpha)

alpha=alpha*pi/180;

if alpha < alphanim
    alpha=alphanim;
end
% alphanim*180/pi
out=puschlowski(a,phi,alpha);