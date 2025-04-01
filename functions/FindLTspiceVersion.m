function [ltspiceVersion,ltspiceExecutable]=FindLTspiceVersion()

% [ltspiceVersion,ltspiceExecutable]=FindLTspiceVersion();
ltspiceVersion='';

% MATLAB Script to Find LTspice Executable in System PATH and Get Version

% Get the system's PATH environment variable
systemPath = getenv('PATH');

% Split the PATH variable into individual directories
pathDirs = split(systemPath, pathsep);

% Initialize a variable to store the LTspice executable path
ltspiceExecutable = '';

% Loop through directories in the PATH
for i = 1:length(pathDirs)
    % Check the directory for files matching "LTspice*.exe"
    files = dir(fullfile(pathDirs{i}, 'LTspice*.exe'));
    
    if ~isempty(files)
        % If a match is found, store the full path of the first result
        ltspiceExecutable = fullfile(pathDirs{i}, files(1).name);
        break;
    end
end

% Check if the LTspice executable was found
if ~isempty(ltspiceExecutable)
    disp(['LTspice executable found at: ', ltspiceExecutable]);

    % Use PowerShell to get file version
    powerShellCommand = ['powershell -Command "(Get-Item ''', ltspiceExecutable, ''').VersionInfo.FileVersion"'];
    [status, result] = system(powerShellCommand);

    if status == 0
        ltspiceVersion=strtrim(result);
        disp(['LTspice Version: ' ltspiceVersion]);
        % disp(strtrim(result)); % Display the version information
    else
        disp('Failed to retrieve LTspice version. Please ensure PowerShell is available and LTspice is installed correctly.');
    end
else
    disp('LTspice executable not found in the system PATH or directories. Please check the installation.');
end
