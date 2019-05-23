
function  filepath = getsimdir(filename,software)

% software ='PSIM' 'LTspice' 'Ngspice'
str=which(filename); % find filename dir

if isempty(str)
    %     [str,maxsize,endian] = computer
    [~, pcname] = system('hostname');
    if contains(pcname,'WIN10-GAMER','IgnoreCase',true) % Home PC
        filepath=['F:\Dropbox\GitHub\quiz2matlab\sims\' software '\'];
    elseif contains(pcname,'DESKTOP-RUSELER','IgnoreCase',true)  % UTFPR
        filepath=['A:\Dropbox\GitHub\quiz2matlab\sims\' software '\'];
    elseif contains(pcname,'RUSELER-NOTE','IgnoreCase',true)  % Note
        filepath=['C:\Users\adria\Dropbox\GitHub\quiz2matlab\sims\' software '\'];
    else
        filepath = pwd; %
    end
    % circuit.dir='A:\Dropbox\GitHub\quiz2matlab\sims\PSIM\';
else
    filepath = fileparts(str);
    filepath = [filepath '\'];
end




