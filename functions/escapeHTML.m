function escapedStr = escapeHTML(inputStr)
% ESCAPEHTML Converts special characters in a string to HTML entities
% Input: inputStr - String to be escaped
% Output: escapedStr - String with HTML special characters escaped

% Test the function
% testStr = 'This & that <script>alert("Hello!")</script>';
% result = escapeHTML(testStr);
% disp(result);

% Input validation
if ~ischar(inputStr) && ~isstring(inputStr)
    error('Input must be a string or character array');
end

% Convert to string if input is char
if ischar(inputStr)
    inputStr = string(inputStr);
end

% Define special characters and their HTML entities
specialChars = {'&', '<', '>', '"', ''''};
htmlEntities = {'&amp;', '&lt;', '&gt;', '&quot;', '&apos;'};

% Initialize output
escapedStr = inputStr;

% Replace special characters with HTML entities
for i = 1:length(specialChars)
    escapedStr = replace(escapedStr, specialChars{i}, htmlEntities{i});
end
