function [psimVersion,psimExecutable,psimCmdExecutable,psimCmdResult]=FindPSIMVersion()

% [psimVersion,psimExecutable,psimCmdExecutable,psimCmdResult]=FindPSIMVersion()
% MATLAB Script to Find PSIM Version Using PowerShell
psimVersion='';
psimCmdResult='';

% Get the system's PATH environment variable
systemPath = getenv('PATH');

% Split the PATH variable into individual directories
pathDirs = split(systemPath, pathsep);

% Initialize a variable to store the PSIM executable path
psimExecutable = '';

% Loop through directories in the PATH
for i = 1:length(pathDirs)
    % Check the directory for files matching "PSIM*.exe"
    files = dir(fullfile(pathDirs{i}, 'PSIM*.exe'));

    if ~isempty(files)
        filescmd = dir(fullfile(pathDirs{i}, 'PsimCmd*.exe'));
        % If a match is found, store the full path of the first result
        psimExecutable = fullfile(pathDirs{i}, files(1).name);
        psimCmdExecutable = fullfile(pathDirs{i}, filescmd(1).name);
        break;
    end
end

% Check if the PSIM executable was found
if ~isempty(psimExecutable)
    disp(['PSIM executable found at: ', psimExecutable]);

    % Use PowerShell to get file version
    powerShellCommand = ['powershell -Command "(Get-Item ''', psimExecutable, ''').VersionInfo.FileVersion"'];
    [status, result] = system(powerShellCommand);
    [statuscmd, resultcmd] = system(psimCmdExecutable);

    if status == 0
        psimVersion=strtrim(result);
        disp(['PSIM Version: ' psimVersion]); % Display the version information

    else
        disp('Failed to retrieve PSIM version. Please ensure PowerShell is available and PSIM is installed correctly.');
    end

    if statuscmd == 4 % 4: Input file is missing
        psimCmdResult=strtrim(resultcmd);
        disp(['PsimCmd Result: ' psimCmdResult]); % Display the version information
    else
        disp('Failed to run PsimCmd. Please ensure PowerShell is available and PSIM is installed correctly.');
    end

else
    disp('PSIM executable not found in the system PATH or directories. Please check the installation.');
end
