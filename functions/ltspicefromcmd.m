
% Run LTspice simulation from cmd
function  circuit = ltspicefromcmd(circuit)

paramstr='.param'; % Generates the param string
for ind=1:length(circuit.parname)
    paramstr=[paramstr ' ' circuit.parname{ind} '=' num2str(circuit.parvalue(ind),'%10.8e')];
end
circuit.LTspice.net.lines{circuit.LTspice.net.paramline}=paramstr; % Updates param line from net file

if isfield(circuit,'model')
    circuit.LTspice.net.lines{circuit.LTspice.net.modelline}=circuit.model.modelstr; % Updates param line from net file
end

% step?
if isfield(circuit.LTspice.net,'stepline')
%     disp('Step line exists!!')
    circuit.LTspice.net.lines{circuit.LTspice.net.stepline}=circuit.stepstr;
% else
%     disp('NO Step line this time!!')
end

if(circuit.cmdupdate)
    if isfield(circuit,'cmdtype')
        switch circuit.cmdtype
            case '.op'
                cmdstr = '.op';
            case '.tran' % .tran Tprint Tstop Tstart
                cmdstr = ['.tran 0 ' num2str(circuit.parvalue(circuit.cmdvarind),'%10.8e') ' 0'];
            otherwise
                cmdstr = '.op';
        end
    else
        cmdstr = '.op';
        circuit.cmdtype = '.op';
    end
    
    circuit.LTspice.net.lines{circuit.LTspice.net.cmdline}=cmdstr;
    
end


if(circuit.LTspice.tmpdir)  % Use system temp dir?
   circuit.LTspice.simsdir = tempdir;    
end

if(circuit.LTspice.tmpfile) % Create tmp file for simulation?
    tmpname=[circuit.LTspice.net.name strrep(char(java.util.UUID.randomUUID),'-','')];
    circuit.LTspice.net.file = [circuit.LTspice.simsdir tmpname '.net'];
else
    tmpname = circuit.LTspice.net.name;
end

[fileID,errmsg] = fopen(circuit.LTspice.net.file,'w'); % Abre arquivo para escrita
t=0;
while fileID < 0 % Loop até conseguir abrir arquivo para escrita.
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

% [status,cmdout]= 
system(['XVIIx64.exe -Run -b -ascii ' circuit.LTspice.net.file]); % Executa simulação

circuit.LTspice.raw.file = [circuit.LTspice.simsdir tmpname '.raw'];
circuit.LTspice.log.file = [circuit.LTspice.simsdir tmpname '.log'];

data.filename=circuit.LTspice.raw.file;
% data.log.file=circuit.LTspice.log.file;

circuit.LTspice.data = rawltspice(data); % Read data

circuit = ltlogread(circuit); % Reads log file

% circuit.LTspice.raw.data.signals.op

 
 
 


