function escapedString = escapeHTML(inputString)
% escapeHTML Escapes HTML special characters in a string.
%
%   escapedString = escapeHTML(inputString) takes a string inputString
%   and returns a new string escapedString where HTML special characters
%   (&, <, >, ", ') are replaced with their corresponding HTML entities.
%
%   Example:
%       htmlCode = '<p class="greeting">Hello, "World" & everyone!</p>';
%       escapedCode = escapeHTML(htmlCode);
%       disp(escapedCode);
%       % Output: &lt;p class=&quot;greeting&quot;&gt;Hello, &quot;World&quot; &amp; everyone!&lt;/p&gt;
%
%   The order of replacements is important, especially for the ampersand.

    if ~ischar(inputString) && ~isstring(inputString)
        error('Input must be a character array or a string.');
    end

    % Convert string to char array if it's a string, as strrep works with char arrays
    if isstring(inputString)
        inputString = char(inputString);
    end

    % 1. Replace ampersands first to avoid double-escaping
    escapedString = strrep(inputString, '&', '&amp;');
    
    % 2. Replace less than
    escapedString = strrep(escapedString, '<', '&lt;');
    
    % 3. Replace greater than
    escapedString = strrep(escapedString, '>', '&gt;');
    
    % 4. Replace double quotes
    escapedString = strrep(escapedString, '"', '&quot;');
    
    % 5. Replace single quotes (apostrophe)
    % Note: &apos; is valid in HTML5/XML, but &#39; is more widely compatible
    % with older HTML versions. We'll use &#39;.
    escapedString = strrep(escapedString, '''', '&#39;');

    % If the original input was a string, convert it back to string
    if isstring(inputString) && ~isstring(escapedString) % Check if original was string and current is char
        escapedString = string(escapedString);
    elseif ~isstring(inputString) && isstring(escapedString) % Check if original was char and current is string (less likely with strrep)
        escapedString = char(escapedString);
    end

end
