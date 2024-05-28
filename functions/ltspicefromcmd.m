% =========================================================================
% ***
% *** The MIT License (MIT)
% ***
% *** Copyright (c) 2023 AdrianoRuseler
% ***
% *** Permission is hereby granted, free of charge, to any person obtaining a copy
% *** of this software and associated documentation files (the "Software"), to deal
% *** in the Software without restriction, including without limitation the rights
% *** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% *** copies of the Software, and to permit persons to whom the Software is
% *** furnished to do so, subject to the following conditions:
% ***
% *** The above copyright notice and this permission notice shall be included in all
% *** copies or substantial portions of the Software.
% ***
% *** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% *** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% *** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% *** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% *** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% *** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% *** SOFTWARE.
% ***
% =========================================================================
% Run LTspice simulation from cmd
function  circuit = ltspicefromcmd(circuit)
% circuit=tmpcircuits{1};

if isfield(circuit,'parname') && isfield(circuit,'parvalue')
    paramstr='.param'; % Generates the param string
    paramfuncstr=''; % Generates the func param string
    logsparam='';
    
    for ind=1:length(circuit.parname)
%         disp(value2srt(circuit.parvalue(ind)))
        paramstr=[paramstr ' ' circuit.parname{ind} '=' value2srt(circuit.parvalue(ind))]; % num2str(circuit.parvalue(ind),'%1.3e')
    end
    
    if isfield(circuit,'funcvalue')          
        for ind=1:length(circuit.funcvalue)
            paramfuncstr=[paramfuncstr ' func' num2str(ind) '=' value2srt(circuit.funcvalue(ind))];  % num2str(circuit.funcvalue(ind),'%1.3e')
        end       
    end
    
    if isfield(circuit,'log2param') % tmpcircuits{n}.log2param
        logsparam=circuit.log2param;
    end

    circuit.paramstr = paramstr;
    circuit.LTspice.net.lines{circuit.LTspice.net.paramline}=[paramstr paramfuncstr logsparam]; % Updates param line from net file
    newStr = split(circuit.LTspice.asc.lines{circuit.LTspice.asc.paramline},'!');
    circuit.LTspice.asc.lines{circuit.LTspice.asc.paramline}=[newStr{1} '!' paramstr paramfuncstr logsparam];
end

if isfield(circuit,'model')
    for m=1:length(circuit.model)
        circuit.LTspice.net.lines{circuit.LTspice.net.modelline(m)}=circuit.model(m).modelstr; % Updates param line from net file
        newStr2 = split(circuit.LTspice.asc.lines{circuit.LTspice.asc.modelline(m)},'!');
        circuit.LTspice.asc.lines{circuit.LTspice.asc.modelline(m)}=[newStr2{1} '!' circuit.model(m).modelstr];
    end
end

if isfield(circuit,'level')
    disp(circuit.level.linestr)
    circuit.LTspice.net.lines{circuit.LTspice.net.levelline}=circuit.level.linestr; % Updates level line from net file
end

% step?
if isfield(circuit.LTspice.net,'stepline') && isfield(circuit,'stepstr')
    circuit.LTspice.net.lines{circuit.LTspice.net.stepline}=circuit.stepstr;
elseif isfield(circuit.LTspice.net,'stepline') && isfield(circuit,'steppedstr')
    circuit.LTspice.net.lines{circuit.LTspice.net.stepline}=circuit.steppedstr;
end

if(circuit.cmdupdate)
    if isfield(circuit,'cmdtype')
        switch circuit.cmdtype
            case '.op'
                cmdstr = '.op';
            case '.ac'
                cmdstr = '.ac';
            case '.tran' % .tran Tprint Tstop Tstart
                %                 cmdstr = ['.tran 0 ' num2str(circuit.cycles/circuit.parvalue(circuit.freqind)) ' ' num2str(circuit.printcycle/circuit.parvalue(circuit.freqind))];
                cmdstr = ['.tran 0 ' num2str(circuit.cycles/circuit.parvalue(circuit.freqind),'%10.8e') ' ' num2str(circuit.printcycle/circuit.parvalue(circuit.freqind),'%10.8e')];
                disp(cmdstr)
            otherwise
                cmdstr = '.op';
        end
    else
        cmdstr = '.op';
        circuit.cmdtype = '.op';
    end
    circuit.LTspice.net.lines{circuit.LTspice.net.cmdline}=cmdstr;
    newStr3 = split(circuit.LTspice.asc.lines{circuit.LTspice.asc.cmdline},'!');
    circuit.LTspice.asc.lines{circuit.LTspice.asc.cmdline}=[newStr3{1} '!' cmdstr];
else
    disp('circuit.cmdupdate=0; % Dont change cmdtype')
    disp(circuit.LTspice.net.lines{circuit.LTspice.net.cmdline})
    
    %     circuit.cmdtype=circuit.LTspice.net.lines{circuit.LTspice.net.cmdline};
    
    cmdtypetmp = split(circuit.LTspice.net.lines{circuit.LTspice.net.cmdline}," ");
    circuit.cmdtype=cmdtypetmp{1}; % Gets first part of command string, .op or .tran
end


if(circuit.LTspice.tmpdir)  % Use system temp dir?
    circuit.LTspice.simsdir = tempdir;
end

if(circuit.LTspice.tmpfile) % Create tmp file for simulation?
    tmpname=[circuit.LTspice.net.name strrep(char(java.util.UUID.randomUUID),'-','')];
    circuit.LTspice.net.file = [circuit.LTspice.simsdir tmpname '.net'];
    circuit.LTspice.asc.file = [circuit.LTspice.simsdir tmpname '.asc'];
else
    tmpname = circuit.LTspice.net.name;
end

if circuit.LTspice.net.run
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

    circuit.LTspice.net.base64=file2base64(circuit.LTspice.net.file);
else
    
    [fileID,errmsg] = fopen(circuit.LTspice.asc.file,'w'); % Abre arquivo para escrita
    t=0;
    while fileID < 0 % Loop até conseguir abrir arquivo para escrita.
        t=t+1;
        disp('Erro ao abrir o arquivo para escrita!')
        disp(errmsg);
        if(circuit.LTspice.tmpfile) % Create tmp file for simulation?
            tmpname=[circuit.LTspice.asc.name strrep(char(java.util.UUID.randomUUID),'-','')];
            circuit.LTspice.asc.file = [circuit.LTspice.simsdir tmpname '.asc'];
        end
        [fileID,errmsg] = fopen(circuit.LTspice.asc.file,'w');
    end
    
    for l=1:length(circuit.LTspice.asc.lines) % Write netfile content
        fprintf(fileID, '%s%c%c', circuit.LTspice.asc.lines{l} ,13,10);
    end
    
    fclose(fileID); % Close
    circuit.LTspice.asc.base64=file2base64(circuit.LTspice.asc.file);
end

% [status,cmdout]=

disp(circuit.LTspice.net.file)
disp(circuit.LTspice.net.lines{circuit.LTspice.net.paramline})

if isfield(circuit,'model')
    for m=1:length(circuit.model)
        disp(circuit.LTspice.net.lines{circuit.LTspice.net.modelline(m)})
    end
end
% system(['XVIIx64.exe -Run -b -ascii ' circuit.LTspice.net.file]); % Executa simulação



if circuit.LTspice.net.run
    circuit.cmdstr = ['LTspice -Run -b -ascii ' circuit.LTspice.net.file];
else
    circuit.cmdstr = ['LTspice -Run -b -ascii ' circuit.LTspice.asc.file];
end


disp(circuit.cmdstr)

if isfield(circuit,'timeout')
    try
        cmd(circuit.cmdstr,circuit.timeout);
    catch ME
        disp(ME)
        return
    end
else
    system(circuit.cmdstr); % Executa simulação
end

circuit.LTspice.raw.file = [circuit.LTspice.simsdir tmpname '.raw'];
circuit.LTspice.log.file = [circuit.LTspice.simsdir tmpname '.log'];

data.filename=circuit.LTspice.raw.file;
data.paramstr=paramstr;
% data.log.file=circuit.LTspice.log.file;

% datax = LTspice2Matlab(data.filename)
circuit.LTspice.data = rawltspice(data); % Read data
circuit = ltlogread(circuit); % Reads log file

% circuit.LTspice.raw.data.signals.op
% circuit.LTspice.tmpfiledel=0;

if circuit.LTspice.tmpfiledel
    delete(circuit.LTspice.raw.file)
    delete(circuit.LTspice.net.file)
    delete(circuit.LTspice.log.file)
end

