function beta = pushlowky(a,phi,alpha)
% a = E/Vpk
% phi = Ângulo de carga
% alpha = Ângulo nonofásico de disparo do tiristor

a = 0;                    %  E/Vpk
phi = acos(0.2);            %  Ângulo de carga acos(0.2)
alpha = 0;               %  Ângulo nonofásico de disparo do tiristor

myfun = @(beta,a,phi,alpha) (((cos(phi)*sin(beta-phi)-a) + (a-cos(phi)*sin(alpha-phi)) )*exp((alpha-beta)/tan(phi)));  % parameterized function

beta0 = pi*(1-a/2)*[1 2];             % initial interval
fun = @(beta) myfun(beta,a,phi,alpha);    % function of x alone

options = optimset('Display','iter'); % show iterations

beta = fzero(fun,beta0,options);

beta = beta*180/pi;


phi = acos(0.2); 
tan(phi)


% 
% myfun = @(beta,a) cos(a*beta) + sin(beta);  % parameterized function
% a = 2;                    % parameter
% beta0 = [0.1 2];             % initial interval
% fun = @(beta) myfun(beta,a);    % function of x alone
% 
% beta = fzero(fun,0.1);

% myfun = @(beta,a,phi,alpha) (((cos(phi)*sin(beta-phi)-a) + (a-cos(phi)*sin(alpha-phi)) )*exp((alpha-beta)/tan(phi)));  % parameterized function

