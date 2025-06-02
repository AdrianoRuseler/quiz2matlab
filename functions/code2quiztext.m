function codestr= code2quiztext(cfile,style)

switch nargin
    case 2
        codestr=fileread(cfile);
        cstyle=lower(style);
        codestr=formatcode(code,style);
    case 1
        codestr=fileread(cfile);
    otherwise
        codestr='';
        return
end

% HTML escape: sign < as &lt;, the greater-than sign > as &gt;
% codestr=replace(codestr,'<','&lt;');
% codestr=replace(codestr,'>','&gt;');

codestr = escapeHTML(codestr)

escapeHTML
