function runMFiles(startDir, nsimsValue, excludePatterns)
    % If no directory specified, use current directory
    if nargin < 1
        startDir = pwd;
        % startDir = [pwd '\TE00\PSIM'];
    end
    
    % If no nsims value specified, use empty (no modification)
    if nargin < 2
        nsimsValue = [];
    end
    
    % Default exclude patterns if none provided
    if nargin < 3
        excludePatterns = {'func','mode'}; % Default pattern to exclude
    end
    
    % Ensure excludePatterns is a cell array
    if ischar(excludePatterns)
        excludePatterns = {excludePatterns};
    end
    
    % Capture output from findMFiles
    oldOutput = evalc('findMFiles(startDir, excludePatterns)');
    lines = splitlines(oldOutput);
    
    % Parse the output to get file list
    fileList = {};
    currentFolder = '';
    
    for i = 1:length(lines)
        line = strtrim(lines{i});
        if startsWith(line, '%%')
            currentFolder = strtrim(line(3:end));
        elseif endsWith(line, ';') || contains(line, '% circuit.nsims')
            % Extract filename
            parts = split(line, '%');
            fileName = strtrim(parts{1}(1:end-1)); % Remove semicolon
            fullPath = fullfile(startDir, currentFolder, fileName);
            if strcmp(currentFolder, 'Root Directory')
                fullPath = fullfile(startDir, fileName);
            end
            fileList{end+1} = fullPath;
        end
    end
    
    % Check if any files were found
    if isempty(fileList)
        fprintf('No .m files found matching criteria in %s\n', startDir);
        return;
    end
    
    % Process files
    totalFilesRun = 0;
    
    if ~isempty(nsimsValue)
        fprintf('Will modify circuit.nsims to %d in selected files\n', nsimsValue);
    end
    fprintf('Running files (excluding patterns: %s):\n', strjoin(excludePatterns, ', '));
    fprintf('----------------------------------------\n');
    
    for i = 1:length(fileList)
        fullFilePath = fileList{i};
        
        try
            % Modify circuit.nsims if requested
            if ~isempty(nsimsValue)
                modifyCircuitNsims(fullFilePath, nsimsValue);
            end
            
            % Run the file
            fprintf('Running %s...', fullFilePath);
            run(replace(fullFilePath,';','')); % Remove semicolon
            fprintf(' Done\n');
            totalFilesRun = totalFilesRun + 1;
            
        catch ME
            fprintf(' Error: %s\n', ME.message);
        end
    end
    
    fprintf('----------------------------------------\n');
    fprintf('Total files executed: %d\n', totalFilesRun);
end

function modifyCircuitNsims(filePath, nsimsValue)
    % Read original file content
    content = fileread(filePath);
    
    % Look for existing circuit.nsims assignment
    pattern = 'circuit\.nsims\s*=\s*\d+';
    if contains(content, 'circuit.nsims')
        % Replace existing value
        newContent = regexprep(content, pattern, sprintf('circuit.nsims = %d', nsimsValue));
    else
        % Add new assignment at the start of the file
        newContent = sprintf('circuit.nsims = %d;\n%s', nsimsValue, content);
    end
    
    % Write modified content back to file
    fid = fopen(filePath, 'w');
    if fid == -1
        error('Could not open file %s for writing', filePath);
    end
    fprintf(fid, '%s', newContent);
    fclose(fid);
end