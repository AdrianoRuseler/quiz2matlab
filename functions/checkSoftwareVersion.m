function isSupported = checkSoftwareVersion(softwareName,maxVersion)
% checkSoftwareVersion - Checks if the installed software version is supported
% checkSoftwareVersion('PSIM',25)
% checkSoftwareVersion('LTspice',17)
%
% Syntax: isSupported = checkSoftwareVersion(exePattern,maxSupportedVersion)
%
% Input:
%   softwareName - Name of the software ('PSIM', 'LTspice', 'Ngspice')
%   maxSupportedVersion - Maximum version supported as a string (e.g., '25.0.0.3987')
%
% Output:
%   isSupported - Boolean value indicating if the installed version is supported

% maxVersion
isSupported = false;

switch lower(softwareName)
    case 'psim'
        % Example logic for PSIM
        disp('Retrieving PSIM version...');
        % [psimVersion,psimExecutable,psimCmdExecutable,psimCmdResult]=FindPSIMVersion()
        softwareVersion = FindPSIMVersion();

    case 'ltspice'
        % Example logic for LTspice
        disp('Retrieving LTspice version...');
        % [ltspiceVersion,ltspiceExecutable]=FindLTspiceVersion();
        softwareVersion = FindLTspiceVersion();

    case 'ngspice'
        % Example logic for Ngspice
        disp('Retrieving Ngspice version...');
        % [ngspiceVersion,ngspiceExecutable,ngspice_conExecutable]=FindNgspiceVersion()
        softwareVersion = FindNgspiceVersion();

    otherwise
        disp(['Unsupported software: ', softwareName]);
        softwareVersion = '';
end

% disp(['Installed Version: ', softwareVersion]);

% Extract the first number before the dot (major version)
installedMajorVersion = str2double(extractBefore(softwareVersion, '.'));

% Compare with maxVersion (assuming maxVersion is a single number)
if installedMajorVersion <= maxVersion
    disp(['Version ', num2str(installedMajorVersion), ' is supported (<= ', num2str(maxVersion), ').']);
    isSupported = true;
else
    warning(['Version ', num2str(installedMajorVersion), ' is NOT supported (> ', num2str(maxVersion), ').']);
end

