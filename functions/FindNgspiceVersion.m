function [ngspiceVersion,ngspiceExecutable,ngspice_conExecutable]=FindNgspiceVersion()

% [ngspiceVersion,ngspiceExecutable,ngspice_conExecutable]=FindNgspiceVersion();
ngspiceVersion='';

% MATLAB Script to Find ngspice Executable in System PATH and Get Version

% Get the system's PATH environment variable
systemPath = getenv('PATH');

% Split the PATH variable into individual directories
pathDirs = split(systemPath, pathsep);

% Initialize a variable to store the ngspice executable path
ngspiceExecutable = '';

% Loop through directories in the PATH
for i = 1:length(pathDirs)
    % Check the directory for files matching "ngspice*.exe"
    files = dir(fullfile(pathDirs{i}, 'ngspice*.exe'));

    if ~isempty(files)
        % If a match is found, store the full path of the first result
        ngspiceExecutable = fullfile(pathDirs{i}, files(1).name);
        ngspice_conExecutable = fullfile(pathDirs{i}, files(2).name);
        break;
    end
end

% Check if the ngspice executable was found
if ~isempty(ngspiceExecutable)
    disp(['ngspice executable found at: ', ngspiceExecutable]);

    % Use PowerShell to get file version
    [status, result] = system([ngspice_conExecutable ' --version']);

    if status == 0
        % Extract version information using a regular expression
        versionPattern = 'ngspice-(\d+\.\d+)';
        versionMatch = regexp(result, versionPattern, 'tokens');

        if ~isempty(versionMatch)
            ngspiceVersion = versionMatch{1}{1};
            disp(['Detected Ngspice Version: ', ngspiceVersion]);
        else
            disp('Ngspice version not found in the output.');
        end
    else
        disp('Failed to retrieve ngspice version. Please ensure ngspice is installed correctly.');
    end
else
    disp('ngspice executable not found in the system PATH or directories. Please check the installation.');
end
