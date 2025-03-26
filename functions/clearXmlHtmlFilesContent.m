function clearXmlHtmlFilesContent(folderPath)
    % Check if the folder exists
    if ~isfolder(folderPath)
        error('The specified folder does not exist: %s', folderPath);
    end

    % Get a list of all .xml and .html files in the folder
    fileExtensions = {'*.xml', '*.html'};
    fileList = [];
    for ext = fileExtensions
        fileList = [fileList; dir(fullfile(folderPath, ext{1}))]; %#ok<AGROW>
    end

    % Check if there are any matching files in the folder
    if isempty(fileList)
        fprintf('No .xml or .html files found in the folder: %s\n', folderPath);
        return;
    end

    % Clear the content of each file
    for i = 1:length(fileList)
        filePath = fullfile(fileList(i).folder, fileList(i).name);
        try
            % Open the file for writing and immediately close it to clear the content
            fid = fopen(filePath, 'w');
            if fid == -1
                error('Failed to open file for writing: %s', filePath);
            end
            fclose(fid);

            fprintf('Cleared content of file: %s\n', filePath);
        catch ME
            % Handle any errors that occur while clearing the file content
            warning('Error clearing content of file %s: %s', filePath, ME.message);
        end
    end

    fprintf('All .xml and .html files in the folder have been cleared.\n');
end
