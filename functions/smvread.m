% function to read PSIM SMV file data

% function data = smvread(filename)

clear all
clc
filename = 'F:\Dropbox\GitHub\quiz2matlab\sims\PSIM\test.smv';



%% Opens file
fileID = fopen(filename,'rb'); % Opens file
frewind(fileID);

[x, count] = fread(fileID,121, 'uint8'); % 120 first header
hexbinstr = dec2hex(x);
binstr = dec2bin(x);


fseek(fileID, 92, 'bof'); % settings
[y, count] = fread(fileID,6, 'uint8'); 
hexbinstr = dec2hex(y);
binstr = dec2bin(y);

fclose(fileID);




[buf, count] = fread(fileID, 1, 'uint16');

fseek(fileID, 25, 'bof'); % Fixo
[buf, count] = fread(fileID, 31, 'uint8=>char', 0, 'ieee-le'); % Simview file from Powersim Inc.







fseek(fileID, 1040, 'bof'); % settings
[x, count] = fread(fileID,6, 'uint8'); 

% Dados até 2609
fseek(fileID, 2112, 'bof'); % 
[y, count] = fread(fileID,13, 'uint8'); 


dec2hex(y)

% 4288
fseek(fileID, 4288, 'bof'); % 
[buf, count] = fread(fileID, 1, 'uint16');


fseek(fileID, 4292, 'bof'); % 0A 00 00 00
[buf, count] = fread(fileID, 4, 'uint16=>char', 0, 'ieee-le'); % Time str


fseek(fileID, 4310, 'bof'); % 
[buf, count] = fread(fileID, 2, 'uint16=>char', 0, 'ieee-le'); % V1



fseek(fileID, 4476, 'bof'); % Time data position
[time, count] = fread(fileID, 1000, 'double'); % Time data -> floating point, 64 bits.



fseek(fileID, 12604, 'bof'); % V1 data position
[buf, count] = fread(fileID,1000, 'double');
[V1, count] = fread(fileID, 'double')


% [buf, count] = fread(fileID, 2, 'uint16=>char', 0, 'ieee-le'); % V1


position = ftell(fileID)
frewind(fileID);

