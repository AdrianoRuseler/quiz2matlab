% Define the path to your Python script
pythonScript = 'generate_tree_md.py';

% Define the root directory you want to map (e.g., the current directory, or a specific project folder)
targetDirectory = pwd; % Replace with your actual path

% Construct the command to run the Python script with the target directory as an argument
% On Windows:
command = sprintf('python "%s" "%s"', pythonScript, targetDirectory);
% On macOS/Linux:
% command = sprintf('python3 "%s" "%s"', pythonScript, targetDirectory);

% Execute the command
[status, cmdout] = system(command);

% Check if the command was successful
if status == 0
    disp('Python script executed successfully.');
    disp(cmdout); % This will display the output (the markdown block) from the Python script
    % You can also read the generated 'project-structure.md' file
    % fid = fopen('project-structure.md', 'r', 'n', 'UTF-8');
    % if fid ~= -1
    %     fileContent = fread(fid, '*char')';
    %     fclose(fid);
    %     disp('Content of project-structure.md:');
    %     disp(fileContent);
    % else
    %     disp('Could not open project-structure.md');
    % end
else
    fprintf('Error executing Python script. Status: %d\n', status);
    disp(cmdout); % Display error output
end