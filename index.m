
%% Adicione a pasta com as funções na busca do MATLAB
pathtool % Adidione a pasta com as funções
% addpath('C:\Users\adria\Dropbox\GitHub\quiz2matlab\functions') % Folder with functions



%%  Test simulation with ngspice

[status,cmdout] = system('ngspice_con -v'); % Não abre Janela


[status,cmdout] = system('PsimCmd');

addpath('E:\Dropbox\GitHub\quiz2matlab\functions') %
addpath('E:\Dropbox\GitHub\quiz2matlab\questions') % 
savepath % Save search path
