
%% Adicione a pasta com as fun��es na busca do MATLAB
pathtool % Adidione a pasta com as fun��es
% addpath('C:\Users\adria\Dropbox\GitHub\quiz2matlab\functions') % Folder with functions



%%  Test simulation with ngspice

[status,cmdout] = system('ngspice_con -v'); % N�o abre Janela


[status,cmdout] = system('PsimCmd');

addpath('E:\Dropbox\GitHub\quiz2matlab\functions') %
addpath('E:\Dropbox\GitHub\quiz2matlab\questions') % 
savepath % Save search path
