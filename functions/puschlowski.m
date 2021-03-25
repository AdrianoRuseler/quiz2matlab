function beta = puschlowski(a,phi,alpha) % in rad

% beta = puschlowski(a,phi,alpha)
% a = E/Vpk
% phi = Ângulo de carga em rad
% alpha = Ângulo nonofásico de disparo do tiristor em rad
alphamin=asin(a);
alphamax=pi-asin(a);

myfun = @(beta,a,phi,alpha) ((cos(phi)*sin(beta-phi)-a) + (a-cos(phi)*sin(alpha-phi))*exp((alpha-beta)/tan(phi)));  % parameterized function
beta0 = pi*(1-a/2)*[1 2];             % initial interval
fun = @(beta) myfun(beta,a,phi,alpha);    % function of x alone
%options = optimset('Display','iter'); % show iterations
% [beta,fval,exitflag,output]  = fzero(fun,beta0,options);
%beta  = fzero(fun,beta0);

%beta = beta*180/pi;

try
    beta  = fzero(fun,beta0);
    beta = beta*180/pi;
catch ME
%     disp(ME)
    beta = 0;
end


% disp(['a=' num2str(a) '; phi=' num2str(phi) '; alpha=' num2str(alpha) ';'])



