function isok = quizcircheck(circuit,quiz) % Verify data entry

isok=1;

disp('Check Variables Length!')
if (length(circuit.parnamesim)==length(circuit.parname))&&(length(circuit.parname)==length(circuit.parunit))&&(length(circuit.parunit)==length(circuit.parind))
    disp('Length is rigth!')
%     isok=isok & 1;
else
    disp('Length is Wrong!')
    isok=isok & 0;
end

disp('Check if circuit.modind is cell!')
if iscell(circuit.modind)
    disp('Yes, is cell!')
%     isok=isok & 1;
else
    disp('No, not a cell!')
    isok=isok & 0;
end


pngfile=[circuit.dir circuit.name '.png']; % Fig png file
disp(['Check if ' pngfile ' exists!'])

if exist(pngfile,'file')
    disp('File exists!')
%     isok=isok & 1;
else
    disp('File NOT FOUND!!!!!')
    isok=isok & 0;
end