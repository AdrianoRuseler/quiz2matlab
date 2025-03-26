function runFilteredFiles(filteredFiles, patternFilter)
    % Check if filteredFiles is provided and not empty
    if isempty(filteredFiles)
        error('The filteredFiles list is empty. Please provide a valid list.');
    end

    % Check if patternFilter is provided
    if isempty(patternFilter)
        patternFilter = {}; % Default to an empty cell array
    end

    % Iterate through the filteredFiles and run the files
    for i = 1:length(filteredFiles)
        filePath = filteredFiles{i};

        % Check if the full path matches ALL patterns in patternFilter
        shouldRun = true; % Start with assumption to run
        for pattern = patternFilter
            if ~contains(filePath, pattern{1})
                shouldRun = false; % If any pattern is not found, don't run the file
                break; % Exit the loop early
            end
        end

        % Execute the file if it matches all patterns in the full path
        if shouldRun
            try
                fprintf('Running file: %s\n', filePath);
                run(filePath);
            catch ME
                % Handle errors during file execution
                warning('Error running file %s: %s', filePath, ME.message);
            end
        else
            % fprintf('Skipping file: %s (does not match all patterns in full path)\n', filePath);
        end
    end
end
