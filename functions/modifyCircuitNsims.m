function modifyCircuitNsims(filteredFiles, patternFilter, newValue)
    % Check if filteredFiles is provided and not empty
    if isempty(filteredFiles)
        error('The filteredFiles list is empty. Please provide a valid list.');
    end

    % Check if patternFilter is provided
    if isempty(patternFilter)
        patternFilter = {}; % Default to an empty cell array
    end

    % Iterate through the filteredFiles
    for i = 1:length(filteredFiles)
        filePath = filteredFiles{i};

        % Check if the full path matches ALL patterns in patternFilter
        shouldModify = true; % Start with assumption to modify
        for pattern = patternFilter
            if ~contains(filePath, pattern{1})
                shouldModify = false; % If any pattern is not found, don't modify the file
                break; % Exit the loop early
            end
        end

        % Modify the file if it matches all patterns
        if shouldModify
            try
                % Read file content
                fileContent = fileread(filePath);

                % Replace the circuit.nsims value
                fileContent = regexprep(fileContent, ...
                    'circuit\.nsims\s*=\s*\d+;', ...
                    sprintf('circuit.nsims = %d;', newValue));

                % Comment out "clear all" line
                fileContent = regexprep(fileContent, ...
                    '^clear all', ...
                    '% clear all', 'lineanchors');

                % Write modified content back to the file
                fid = fopen(filePath, 'w');
                if fid == -1
                    error(['Could not open file for writing: ', filePath]);
                end
                fwrite(fid, fileContent);
                fclose(fid);

                fprintf('Modified circuit.nsims and commented "clear all" in file: %s\n', filePath);
            catch ME
                % Handle errors during modification
                warning('Error modifying file %s: %s', filePath, ME.message);
            end
        else
            % fprintf('Skipping file: %s (does not match all patterns in full path)\n', filePath);
        end
    end
end
