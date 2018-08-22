
%% Adicione a pasta com as funções na busca do MATLAB
pathtool % Adidione a pasta com as funções
% addpath('A:\Dropbox\GitHub\quiz2matlab\functions') % Folder with functions



%%  Test simulation with ngspice

[status,cmdout] = system('ngspice_con -v'); % Não abre Janela