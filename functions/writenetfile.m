function [netfile,logfile,rawfile] = writenetfile(netlines)

tmpname=[strrep(char(java.util.UUID.randomUUID),'-','')];
netfile=[tempdir  tmpname '.net'];
% disp(netfile)
[fileID] = fopen(netfile,'w'); % Abre arquivo para escrita
for l=1:length(netlines) % Write netfile content
    fprintf(fileID, '%s%c%c', netlines{l} ,13,10);
end
fclose(fileID); % Close

logfile=[tempdir  tmpname '.log'];
rawfile=[tempdir  tmpname '.raw'];