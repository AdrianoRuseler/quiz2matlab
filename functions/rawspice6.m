function [header,variables,data] = rawspice6(filename)
%rawspice6: usage-- [header,variables,data]=rawspice6('freq.raw')
%an m-file function that reads spice3g "raw" files line-by-line
%and outputs string and numeric information compatible with MATLAB.
%Input: The text string containing the full path for the raw file
%Outputs: [header,variables,data]. header is a cell array containing
%the contents of the first six lines of every raw file--the title of
%each item (e.g. Title:) is stripped off (leaving, e.g. Bridge-T Circuit).
%variables is a  cell array of strings containing the spice variable
% number (e.g. 0), variable names (e.g. v(1) or sweep) and the units
%(e.g. frequency, voltage). data is a numeric array with the data in
% columns corresponding to each of the variables (1 to #variables).
%Works with Matlab 5 & 6. Note: in MATLAB, the variable numbers
%must be incremented by one to properly locate the column for that
%variable

%Start timer
% tic
% fprintf(1,'Reading raw file\n')
% Create cell array containing each line in the file
fid = fopen(filename, 'rt');
n=1;

while ~feof(fid)
    line = fgets(fid);
    s{n}=line(1:end-1);
    n = n+1;
end
% fprintf(1,'File read, beginning conversion\n')
%Pre-allocate space for header info
header = cell(6,1);



%Strip out header information--first 6 lines
for k=1:6
    locs=findstr(s{k},':');       %Find the colon after the title
    [~, n2]=size(s{k});
    header{k}=s{k}(locs(1)+2:n2); %Save everything after the colon
end

%Identify variables and variable types
nvars=str2num(header{5});   %Number of variables is in header line 5
variables = cell(nvars,1);  %Create space for variables info
for k=8:8+nvars-1           %Variables info starts in line 8
    [~, n2]=size(s{k});
    variables{k-7}=s{k}(2:n2);
end     %k loop

npts=str2num(header{6});    %Number of values per variable
line=nvars+9;	            %Line where data starts

if strncmp(header{4},'complex',4)	 %Identify data type
    
    %If the data is complex, handle it here
    for k=1:npts
        for k2=1:nvars
            tabs=findstr(s{line},char(9)); %Locate tabs
            [~, n2]=size(s{line});
            comma=findstr(s{line},',');	%Locate the comma
            data(k,k2)=sscanf(s{line}(tabs(1)+1:comma(1)-1),'%e') + 1i*(sscanf(s{line}(comma(1)+1:n2),'%e'));  %Store data in complex form
            line=line+1;
        end             %k2 loop
        line=line+1;	%Skip blank line between data sets
    end             %k loop
    
    % If the data is real, handle it here
    
else
    for k=1:npts
        for k2=1:nvars
            tabs=findstr(s{line},char(9)); %Locate tabs
            [~, n2]=size(s{line});
            data(k,k2)=sscanf(s{line}(tabs(1)+1:n2),'%e');
            line=line+1;
        end             %k2 loop
        line=line+1;    %Skip blank line between data sets
    end             %k loop
end	%end if
fclose(fid);
% fprintf(1,'Done with conversion\n')
%Compute elapsed time
% toc

