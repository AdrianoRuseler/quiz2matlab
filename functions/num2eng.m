function str = num2eng(number,useSIPrefix,useMu,spaceAfterNumber,sigFigs,fullName)
%************************************************************************************************************************************************************
%                                                                                                                                                           *
%   string = num2eng(number,[useSIPrefix],[useMu],[spaceAfterNumber],[sigFigs],[fullName]), where input variables in square brackets are optional - i.e.    *
%   The function accepts anywhere from 1 to 6 inputs, inclusive. Converts an input numerical value into an engineering-formatted string, in either          *
%   scientific format with multiples-of-three exponent, or using SI prefixes e.g. k, M, n, p etc.                                                           *
%                                                                                                                                                           *
%   Version: 1.0.6                                                                                                                                          *
%                                                                                                                                                           *
%   Input variables:                                                                                                                                        *
%       number:             The numeric value(s) to be converted to a string. If this is the only input, the string returned will be in scientific format   *
%                           with multiples-of-three exponent. e.g. num2eng(0.001) will return the string '1e-3' (not including quotes). If number is empty  *
%                           (i.e. []) or not numeric, the returned string will be '', or ' ' if spaceAfterNumber=true. If "number" is a vector or matrix,   *
%                           num2eng will return a cell matrix with the same "shape" as the number matrix, with one string per cell. Complex numbers are     *
%                           supported, but if the imaginary part is non-zero, SI prefixes will not be used.                                                 *
%                                                                                                                                                           *
%       useSIPrefix:        Logical. (Or can use 0/1 instead of true/false). When set to true, SI prefixes will be used for any abs(number) in the range    *
%                           1 y to 999.999... Y, instead of scientific notation.                                                                            *
%                           Examples:                                                                                                                       *
%                           num2eng(0.001,true) will return the string '1 m'                                                                                *
%                           num2eng(2.56e29,true) will return the string '256e+27'                                                                          *
%                           num2eng(1.5,true) will return the string '1.5'                                                                                  *
%                           num2eng(-1.2e5,1) will return the string '-120 k'                                                                               *
%                                                                                                                                                           *
%       useMu:              Logical. (Or can use 0/1 instead of true/false). If useSIPrefix=true, and abs(number) is >=1e-6 and <1e-9, the lower-case       *
%                           Greek mu (unicode U+00B5) will be used. Otherwise, 'u' will be used here instead.                                               *
%                           Examples:                                                                                                                       *
%                           num2eng(10e-6,true) will return the string '10 u'                                                                               *
%                           num2eng(10e-6,true,true) will return the string '10 µ'                                                                          *
%                                                                                                                                                           *
%       spaceAfterNumber:   Logical. (Or can use 0/1 instead of true/false). When set to true, a space will be inserted after the numeric part of the       *
%                           output string, after the 'e' if the output string is in scientific format, and in all cases where useSIPrefix=true, even for    *
%                           numbers between -999.99... and +999.99... . Examples ('x' means 'don't care'/'not relevant' in the below examples):             *
%                           num2eng(0.001,true,x,x) will return the string '1 m'                                                                            *
%                           num2eng(0.001,false,x,true) will return the string '1e-3 '                                                                      *
%                           num2eng(2.56e29,true,x,true) will return the string '256e+27 '                                                                  *
%                           num2eng(1.5,true,x,true) will return the string '1.5 '                                                                          *
%                                                                                                                                                           *
%       sigFigs:            Integer. Specifies how many significant figures should be in the output string. Defaults to 5 if not specified.                 *
%                                                                                                                                                           *
%       fullName:           Logical. (Or can use 0/1 instead of true/false). If fullName=true, the full name of the SI prefix will be used, rather than     *
%                           just a letter. Overrides the "useMu" option if that has been set. Examples:                                                     *
%                           num2eng(0.001,true,false,false,5,true) will return the string '1 milli'                                                         *
%                           num2eng(2.56e29,true,false,false,5,true) will return the string '256e+27'                                                       *
%                           num2eng(1.5,true,false,false,5,true) will return the string '1.5'                                                               *
%                           num2eng(4.5645667e-6,1,1,1,6,1) will return the string '4.56457 micro'                                                          *
%                                                                                                                                                           *
%   Output variables:                                                                                                                                       *
%       str:                The output string in engineering format, or cell-vector/matrix of strings if inut variable "number" is a vector/matrix.         *
%                                                                                                                                                           *
%   Written by Harry Dymond, University of Bristol Electrical Energy Management Group; harry.dymond@bris.ac.uk. Based on a post by Jan Simon in the thread: *
%   https://uk.mathworks.com/matlabcentral/answers/892-engineering-notation-printed-into-files, with further inspiration from Stephen Cobeldick's num2sip   *
%   (https://uk.mathworks.com/matlabcentral/fileexchange/33174-number-to-scientific-prefix). Code may be freely shared and modified as long as this         *
%   comment box is included in its entirety and any code changes and respective authors are summarised here                                                 *
%                                                                                                                                                           *
%************************************************************************************************************************************************************
    %% check inputs
    if nargin<1 || nargin>6    
        if nargin<1, errorString=sprintf('ERROR: At least one input argument is required\n');
        else         errorString=sprintf('ERROR: The maximum number of input arguments accepted is 6\n'); end
        errorString=sprintf('%s\t   Function syntax: outputString = num2eng(number,[useSIPrefix],[useMu],[spaceAfterNumber],[sigFigs],[fullName]);\n',...
                                                                                                                                            errorString);
        errorString=sprintf('%s\t   where input variables in square brackets are optional\n',errorString);
        error(errorString); %#ok<SPERR>
    end
    
    optionNames = {'useSIPrefix','useMu','spaceAfterNumber','sigFigs','fullName'};

    if nargin > 1, i = 1; useSIPrefix       = check_logical(useSIPrefix);           else useSIPrefix        = false; end
    if nargin > 2, i = 2; useMu             = check_logical(useMu);                 else useMu              = false; end
    if nargin > 3, i = 3; spaceAfterNumber  = check_logical(spaceAfterNumber);      else spaceAfterNumber   = false; end
    if nargin > 4, i = 4; sigFigs           = check_real_numeric_scalar(sigFigs);   else sigFigs            = 5;     end
    if nargin > 5, i = 5; fullName          = check_logical(fullName);              else fullName           = false; end
    
    %% initialise SI prefix, if requested
    if useSIPrefix
        expValue = [  24,   21,   18,   15,   12,    9,    6,    3,  0,   -3,   -6,   -9,  -12,  -15,  -18,  -21,  -24];
        if fullName
            expName = {' yotta', ' zetta', ' exa', ' peta', ' tera', ' giga', ' mega', ' kilo', '', ...
                       ' milli', ' micro', ' nano', ' pico', ' femto', ' atto', ' zepto', ' yocto'};
        else
            expName = {' Y', ' Z', ' E', ' P', ' T', ' G', ' M', ' k', '', ' m', ' u', ' n', ' p', ' f', ' a', ' z', ' y'};
            if useMu, expName{11} = [' ' char(181)]; end % char(181) is the lower case Greek "mu" character
        end
        if spaceAfterNumber, expName{9} = ' '; end
    end
    
    %% Do the conversion
    if isempty(number) || ~isnumeric(number) || iscell(number)
        str = num2eng_part2(number);   
    elseif isscalar(number)
        str = num2eng_part1(number);
    elseif iscolumn(number) || isrow(number)
        % faster than using arrayfun
        str{numel(number)}=[];
        for i=1:numel(number)
            str{i} = num2eng_part1(number(i));
        end
        if iscolumn(number), str=str'; end
    else
        % fastest implementation for array input would be to loop explicitly, but arrayfun is much easier and matrix inputs are the least likely
        str = arrayfun(@num2eng_part1,number,'UniformOutput',false);
    end
    
    
    %% Subroutines    
    function str = num2eng_part1(number)
        if ~isreal(number)
        %% handle imaginary numbers
            if imag(number)==0
                str = num2eng_part2(real(number));
            else
                SIPrefixOption = useSIPrefix;
                useSIPrefix = false;
                spaceOption = spaceAfterNumber;
                spaceAfterNumber = false;
                str = num2eng_part2(real(number));
                if imag(number)>0, str = [str '+']; end
                if spaceOption
                    str = [str num2eng_part2(imag(number)) 'i '];
                else
                    str = [str num2eng_part2(imag(number)) 'i'];
                end
                spaceAfterNumber = spaceOption;
                useSIPrefix = SIPrefixOption;
                return
            end
        else  
        %% handle all other cases
            str = num2eng_part2(number);
        end
    end
    

    function str = num2eng_part2(number)
        %% handle special cases
        if     isempty(number) || ~isnumeric(number) || iscell(number), str = ''; add_space; return
        elseif isnan(number), str = 'NaN'; add_space; return
        elseif isinf(number), if number>0, str = '+inf'; else str = '-inf'; end, add_space; return
        elseif number==0    , str = '0'; add_space; return
        end
        %% handle all other cases
        exponent = 3 * floor(log10(abs(number)) / 3);
        mantissa = number / (10 ^ exponent);
        
        mantissa = round(mantissa,sigFigs,'significant');
        if mantissa>=1000
            exponent = exponent+3;
            mantissa = mantissa/1000;
        end
        
        if useSIPrefix, expIndex = (exponent == expValue); end
        
        if useSIPrefix && any(expIndex)
            str = sprintf('%.*g%s',max(sigFigs,1+floor(log10(abs(mantissa)))), mantissa, expName{expIndex});
        else
            if exponent~=0
                str = sprintf('%.*ge%+d',max(sigFigs,1+floor(log10(abs(mantissa)))), mantissa, exponent);
            else
                str = sprintf('%.*g', sigFigs, mantissa);
            end
            add_space;
        end
        %% add space to end of string if required
        function add_space()
            if spaceAfterNumber, str = [str ' ']; end
        end
    end


    function str = num2ord(num)
        switch num
            case 1,  str = 'First';
            case 2,  str = 'Second';
            case 3,  str = 'Third';
            case 4,  str = 'Fourth';
            case 5,  str = 'Fifth';
            case 6,  str = 'Sixth';
            case 7,  str = 'Seventh';
            case 8,  str = 'Eighth';
            case 9,  str = 'Ninth';
            case 10, str = 'Tenth';
        end
    end


    function var = check_logical(var)
        if ~islogical(var)
            try var = logical(var);
            catch
                try
                    error('ERROR: %s option (%s) should be a logical value\n',num2ord(i),optionNames{i});
                catch ME
                    throwAsCaller(ME);
                end
            end
        end
        try
            assert(isscalar(var),'ERROR: %s option (%s) cannot be a vector or matrix\n',num2ord(i),optionNames{i});
        catch ME
            throwAsCaller(ME);
        end
    end


    function var = check_real_numeric_scalar(var)
        try
            assert(isnumeric(var)&&isscalar(var)&&isreal(var),'ERROR: %s option (%s) should be a scalar integer\n',num2ord(i),optionNames{i});
        catch ME
            throwAsCaller(ME);
        end        
        var = round(var);
    end
end
