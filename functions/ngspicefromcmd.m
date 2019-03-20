% Run Ngspice simulation from cmd
function  circuit = ngspicefromcmd(circuit)


paramstr='.param'; % Generates the param string
for ind=1:length(circuit.parname)
    paramstr=[paramstr ' ' circuit.parname{ind} '=' num2str(circuit.parvalue(ind),'%10.8e')];
end
circuit.Ngspice.cir.lines{circuit.Ngspice.cir.paramline}=paramstr; % Updates param line from net file

if(circuit.Ngspice.tmpdir)  % Use system temp dir?
   circuit.Ngspice.simsdir = tempdir;    
end

if(circuit.Ngspice.tmpfile) % Create tmp file for simulation?
    tmpname=[circuit.Ngspice.cir.name strrep(char(java.util.UUID.randomUUID),'-','')];
    circuit.Ngspice.cir.file = [circuit.Ngspice.simsdir tmpname '.cir'];
end

[fileID,errmsg] = fopen(circuit.Ngspice.cir.file,'w'); % Abre arquivo para escrita
t=0;
while fileID < 0 % Loop até conseguir abrir arquivo para escrita.
    t=t+1;
    disp('Erro ao abrir o arquivo para escrita!')
    disp(errmsg);
    if(circuit.Ngspice.tmpfile) % Create tmp file for simulation?
        tmpname=[circuit.Ngspice.cir.name strrep(char(java.util.UUID.randomUUID),'-','')];
        circuit.Ngspice.cir.file = [circuit.Ngspice.simsdir tmpname '.cir'];
    end
    [fileID,errmsg] = fopen(circuit.Ngspice.cir.file,'w');
end

% circuit.LTspice.log.file = [circuit.Ngspice.simsdir tmpname '.log'];
circuit.Ngspice.raw.file = [circuit.Ngspice.simsdir tmpname '.raw'];


circuit.Ngspice.cir.lines{circuit.Ngspice.cir.writeline}=['write ' circuit.Ngspice.raw.file circuit.Ngspice.cir.writevars]; % Updates write line from net file


for l=1:length(circuit.Ngspice.cir.lines) % Write netfile content
    fprintf(fileID, '%s%c%c', circuit.Ngspice.cir.lines{l} ,13,10);   
end

fclose(fileID); % Close OK!

if ~exist(circuit.Ngspice.cir.file,'file') % Caso arquivo não exista
    disp(['File not found: ' circuit.Ngspice.cir.file])
    return;
end

[status,cmdout] = system(['ngspice_con ' circuit.Ngspice.cir.file ]); %

circuit.Ngspice.cir.status=status;
circuit.Ngspice.cir.cmdout=cmdout;

disp(circuit.Ngspice.cir.cmdout)
% [header,variables,data] = rawspice6(circuit.Ngspice.raw.file);