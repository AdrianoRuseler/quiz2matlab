
% Run LTspice simulation from cmd
function  circuit = ltspicefromcmd(circuit)

paramstr='.param'; % Generates the param string
for ind=1:length(circuit.parname)
    paramstr=[paramstr ' ' circuit.parname{ind} '=' num2str(circuit.parvalue(ind),'%10.8e')];
end
circuit.LTspice.net.lines{circuit.LTspice.net.paramline}=paramstr; % Updates param line from net file

if(circuit.LTspice.tmpdir)  % Use system temp dir?
   circuit.LTspice.simsdir = tempdir;    
end

if(circuit.LTspice.tmpfile) % Create tmp file for simulation?
    tmpname=[circuit.LTspice.net.name strrep(char(java.util.UUID.randomUUID),'-','')];
    circuit.LTspice.net.file = [circuit.LTspice.simsdir tmpname '.net'];
end

[fileID,errmsg] = fopen(circuit.LTspice.net.file,'w'); % Abre arquivo para escrita
t=0;
while fileID < 0 % Loop at� conseguir abrir arquivo para escrita.
    t=t+1;
    disp('Erro ao abrir o arquivo para escrita!')
    disp(errmsg);
    if(circuit.LTspice.tmpfile) % Create tmp file for simulation?
        tmpname=[circuit.LTspice.net.name strrep(char(java.util.UUID.randomUUID),'-','')];
        circuit.LTspice.net.file = [circuit.LTspice.simsdir tmpname '.net'];
    end
    [fileID,errmsg] = fopen(circuit.LTspice.net.file,'w');
end

for l=1:length(circuit.LTspice.net.lines) % Write netfile content
    fprintf(fileID, '%s%c%c', circuit.LTspice.net.lines{l} ,13,10);   
end

fclose(fileID); % Close

status = system(['XVIIx64.exe -Run -b -ascii ' circuit.LTspice.net.file]); % Executa simula��o


circuit.LTspice.log.file = [circuit.LTspice.simsdir tmpname '.log'];
circuit.LTspice.raw.file = [circuit.LTspice.simsdir tmpname '.raw'];


circuit.LTspice.raw.data = rawltspice(circuit.LTspice.raw.file); % Read data


% circuit.LTspice.raw.data.signals.op


