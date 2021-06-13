function isok = quizcircheck(circuit,quiz) % Verify data entry

isok=1;
checklength=1;
checkmodind=1;

if ~isfield(circuit,'parnamesim')
    checklength=checklength & 0;
end

if ~isfield(circuit,'parname')
    checklength=checklength & 0;
end

if ~isfield(circuit,'parunit')
    checklength=checklength & 0;
end

if ~isfield(circuit,'parind')
    checklength=checklength & 0;
end


if checklength
    disp('Check Variables Length!')
    if (length(circuit.parnamesim)==length(circuit.parname))&&(length(circuit.parname)==length(circuit.parunit))&&(length(circuit.parunit)==length(circuit.parind))
        disp('Length is rigth!')
        %     isok=isok & 1;
    else
        disp('Length is Wrong!')
        isok=isok & 0;
    end
end


if ~isfield(circuit,'modind')
    checkmodind=checkmodind & 0;
end

if checkmodind
    disp('Check if circuit.modind is cell!')
    if iscell(circuit.modind)
        disp('Yes, is cell!')
        %     isok=isok & 1;
    else
        disp('No, not a cell!')
        isok=isok & 0;
    end
end

pngfile=[circuit.dir circuit.name '.png']; % Fig png file
disp(['Check if ' pngfile ' exists!'])

if exist(pngfile,'file')
    disp('Fig png file exists!')
%     isok=isok & 1;
else
    disp([circuit.name '.png file NOT FOUND!!!!!'])
    isok=isok & 0;
end