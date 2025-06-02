function codestr= code2quiztext(cfile,style)

switch nargin
    case 2
        disp('Case 2')
        codestr=fileread(cfile);
        cstyle=lower(style);
        codestr=formatcode(codestr,style);
    case 1
        disp('Case 1')
        codestr=fileread(cfile);
    otherwise
        codestr='';
        return
end

% escapeHTML Escapes HTML special characters in a string.
codestr = escapeHTML(codestr);

% escapeHTML

% codesample_languages: [
%     { text: 'HTML/XML', value: 'markup' },
%     { text: 'JavaScript', value: 'javascript' },
%     { text: 'CSS', value: 'css' },
%     { text: 'PHP', value: 'php' },
%     { text: 'Ruby', value: 'ruby' },
%     { text: 'Python', value: 'python' },
%     { text: 'Java', value: 'java' },
%     { text: 'C', value: 'c' },
%     { text: 'C#', value: 'csharp' },
%     { text: 'C++', value: 'cpp' }
%   ],

[~, ~, lang_ext] = fileparts(cfile);

switch lower(lang_ext)
    case {'.html', '.htm', '.xml', '.xhtml'}
        category = 'markup';
    case {'.js'}
        category = 'javascript';
    case {'.css'}
        category = 'css';
    case {'.php', '.php4', '.php5', '.phtml'}
        category = 'php';
    case {'.rb'}
        category = 'ruby';
    case {'.py'}
        category = 'python';
    case {'.java'}
        category = 'java';
    case {'.c', '.h'}
        category = 'c';
    case {'.cs'}
        category = 'csharp';
    case {'.cpp', '.cc', '.cxx', '.hpp', '.hxx'}
        category = 'cpp';
    otherwise
        category = 'markup'; % Or you could return an error or a default category
end

% disp(category)

codestr = ['<pre class="language-' category '"><code>' codestr '</code></pre>'];