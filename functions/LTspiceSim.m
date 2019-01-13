function [data]=LTspiceSim(simfilebase,paramstr,transtr)

if ~exist(simfilebase,'file') % Caso arquivo não exista
      disp(['Arquivo não encontrado: ' simfilebase])
      data=[];
      return;
end

[simdir, name, ext] = fileparts(simfilebase);
switch ext
    case '.asc'
        disp(' -netlist Batch conversion of a schematic to a netlist.')
        %         tic
        [status,cmdout] = system(['XVIIx64.exe -Run -b -ascii -netlist ' simfilebase ]); % Cria o arquivo .net
        if ~status % Se simulação foi bem sucedida
            ext='.net';
            simfilebase=fullfile(simdir, [name ext]); % Atualiza simbase file
        else
            data=[];
            return;
        end
    case '.net'
        %         disp(simfilebase)
%         if ~exist(simfilebase,'file') % Verifica se existe o arquivo
%             disp(['Arquivo não encontrado:' simfilebase ])
%             data=[];
%             %             datatran=[];
%             return
%         end
    otherwise
        warning('Expected .asc or .net file!')
        data=[];
        %         datatran=[];
        return
end

simtype='op'; % Assume ser op

fileID = fopen(simfilebase);
if fileID == -1
    data=[];
%     datatran=[];
    return;
end


l=1;
tline=cell(1,20); 
while ~feof(fileID)
    tline{l} = fgetl(fileID); 
    if contains(tline{l},'.param') && exist('paramstr','var') % Find .param line
        tline{l}=['.param ' paramstr]; % Update .param line
    elseif contains(tline{l},'.tran') && exist('transtr','var')
        tline{l}=['.tran ' transtr]; % Update .tran line
        simtype='tran';  % Transient Analysis (.tran)  
    end
    
    l=l+1;
end
fclose(fileID);

% .tran 1u 3m 0 1u

% [simdir, name, ext] = fileparts(simfilebase);
tempnane=[name strrep(char(java.util.UUID.randomUUID),'-','')];

simfile = fullfile(simdir, [tempnane '.net']); % Generate temp sim filename

[fileID,errmsg] = fopen(simfile,'w'); % Abre arquivo para escrita
t=0; 
while fileID < 0 % Loop até conseguir abrir arquivo para escrita.
   t=t+1;
   disp('Erro ao abrir o arquivo para escrita!')
   disp(errmsg);
   simfile = fullfile(simdir, [name strrep(char(java.util.UUID.randomUUID),'-','') ext]); % Generate temp sim filename
   [fileID,errmsg] = fopen(simfile,'w');
end


% Write simfile content
for l=1:length(tline)
    fprintf(fileID, '%s%c%c', tline{l} ,13,10);   
end

fclose(fileID); % Close

% Transient Analysis (.tran) and AC Analysis (.ac)
[status,cmdout] = system(['XVIIx64.exe -Run -b -ascii ' simfile]); % Executa simulação

if ~status % Se simulação foi bem sucedida
    delete(simfile) % Deleta arquivo de simulação
    simlogfile=fullfile(simdir, [tempnane '.log']); % Atualiza simbase file
    delete(simlogfile) % Deleta arquivo de log
else % Erro na simulação
    disp(cmdout)
     data=[];
    return;    
end


    
if strcmp(simtype,'tran') % Transient Analysis (.tran)
    simrawfile=fullfile(simdir, [tempnane '.raw']); % Atualiza simbase file
    simoprawfile=fullfile(simdir, [tempnane '.op.raw']); % Atualiza simbase file
    dataop = rawltspice(simoprawfile); % Read data
    data = rawltspice(simrawfile); % Read data
       
    
     for s=1:length(data.signals) % Copia op para data
         data.signals(s).op=dataop.signals(s).op;
     end
     
%     delete(simrawfile) % Deleta arquivo de dados
%     delete(simoprawfile) % Deleta arquivo de dados
else % Operatin point Simulation
    simoprawfile=fullfile(simdir, [tempnane '.raw']); % Atualiza simbase file
    data = rawltspice(simoprawfile); % Read data
%     datatran = []; % Read data    
%     data=dataop;
%     delete(simoprawfile) % Deleta arquivo de dados
end
    
    
data.simparmstr=paramstr; % Parâmetros de simulação