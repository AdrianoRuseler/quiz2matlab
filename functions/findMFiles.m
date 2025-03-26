function findMFiles(startDir, excludePatterns)
    % If no directory specified, use current directory
    if nargin < 1
        startDir = pwd;
    end
    
    % Default exclude patterns if none provided
    if nargin < 2
        excludePatterns = {'func','mode'}; % Default pattern to exclude
    end
    
    % Ensure excludePatterns is a cell array
    if ischar(excludePatterns)
        excludePatterns = {excludePatterns};
    end
    
    % Create a structure to store files by folder and their circuit.nsims values
    fileMap = containers.Map();
    nsimsMap = containers.Map();
    
    % Collect all files
    collectFiles(startDir, fileMap, nsimsMap, startDir, excludePatterns);
    
    % Generate report
    fprintf('MATLAB Files Report (starting from %s):\n', startDir);
    fprintf('Excluding patterns: %s\n', strjoin(excludePatterns, ', '));
    fprintf('----------------------------------------\n');
    
    % Get all folder paths and sort them
    folderPaths = keys(fileMap);
    [~, sortIdx] = sort(lower(folderPaths));
    sortedPaths = folderPaths(sortIdx);
    
    totalFiles = 0;
    
    % Print report for each folder
    for i = 1:length(sortedPaths)
        folderPath = sortedPaths{i};
        files = fileMap(folderPath);
        
        % Skip if no files remain after filtering
        if isempty(files)
            continue;
        end
        
        % Get relative path from start directory
        if strcmp(folderPath, startDir)
            folderName = 'Root Directory';
        else
            folderName = strrep(folderPath, [startDir filesep], '');
        end
        
        fprintf('%%%% %s\n', folderName);
        
        % Print each filename with circuit.nsims comment if found
        for j = 1:length(files)
            fileName = files{j};
            fullPath = fullfile(folderPath, fileName);
            nsimsKey = fullPath; % Use full path as key
            comment = '';
            if isKey(nsimsMap, nsimsKey) && ~isempty(nsimsMap(nsimsKey))
                comment = sprintf(' %% circuit.nsims = %s', nsimsMap(nsimsKey));
            end
            fprintf('%s;%s\n', fileName, comment);
            totalFiles = totalFiles + 1;
        end
        fprintf('\n'); % Extra line between sections
    end
    
    fprintf('Total number of .m files found: %d\n', totalFiles);
end

function collectFiles(currentDir, fileMap, nsimsMap, startDir, excludePatterns)
    % Get list of all .m files in current directory
    mFiles = dir(fullfile(currentDir, '*.m'));
    
    % Filter out files matching exclude patterns and check for circuit.nsims
    if ~isempty(mFiles)
        fileNames = {mFiles.name};
        keepMask = true(size(fileNames));
        for i = 1:length(excludePatterns)
            pattern = excludePatterns{i};
            keepMask = keepMask & ~contains(fileNames, pattern, 'IgnoreCase', true);
        end
        filteredFiles = fileNames(keepMask);
        
        % Process each file for circuit.nsims
        for j = 1:length(filteredFiles)
            fileName = filteredFiles{j};
            fullPath = fullfile(currentDir, fileName);
            nsimsValue = getCircuitNsims(fullPath);
            if ~isempty(nsimsValue)
                nsimsMap(fullPath) = nsimsValue;
            end
        end
        
        % Store filtered filenames for this directory
        if ~isempty(filteredFiles)
            fileMap(currentDir) = filteredFiles;
        end
    end
    
    % Get list of all subdirectories
    dirList = dir(currentDir);
    dirList = dirList([dirList.isdir]);  % Keep only directories
    dirList = dirList(~ismember({dirList.name}, {'.', '..'}));  % Remove . and ..
    
    % Recursively search each subdirectory
    for i = 1:length(dirList)
        subDir = fullfile(currentDir, dirList(i).name);
        collectFiles(subDir, fileMap, nsimsMap, startDir, excludePatterns);
    end
end

function nsimsValue = getCircuitNsims(filePath)
    % Read file content and search for circuit.nsims assignment
    try
        content = fileread(filePath);
        % Look for pattern like 'circuit.nsims = number'
        pattern = 'circuit\.nsims\s*=\s*(\d+)';
        matches = regexp(content, pattern, 'tokens');
        
        if ~isempty(matches)
            % Take the first match
            nsimsValue = matches{1}{1};
        else
            nsimsValue = '';
        end
    catch
        nsimsValue = ''; % Return empty if file can't be read
    end
end