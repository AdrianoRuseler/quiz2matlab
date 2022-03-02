
function  filepath = getsimdir(filename)

% circuit.dir = [pwd '\'];  % Sets simulation dir

% software ='PSIM' 'LTspice' 'Ngspice'
str=which(filename); % find filename dir

if isempty(str)
    filepath = [pwd '\'];  % Sets simulation dir
else
    filepath = fileparts(str);
    filepath = [filepath '\'];
end


disp(filepath)

