% abaco


a=0.1:0.1:0.3;

cosphi=0.1:0.1:0.4;
phi=acos(cosphi);


alpha = linspace(0,pi/2,5);

M = zeros(length(a),length(phi),length(alpha));

for i=1:length(a)
%     a(i)
    for j=1:length(phi)
        ind=find(alpha>=asin(a(i)) & alpha<=(pi-asin(a(i))));
        for k=1:length(ind)
            M(i,j,k)= puschlowski(a(i),phi(j),alpha(ind(k)));
        end
    end
end


%% Print table
filename='teste01.tbl';
fid = fopen(filename,'w');
if fid==-1
    disp('Erro ao abrir o arquivo para escrita!')
    return
end

fprintf(fid, '%d,%d,%d%c%c',length(a),length(phi),length(alpha),13,10);

fprintf(fid, '%s%c%c',num2str(a),13,10);

fclose(fid);

%% 


writematrix([length(a) length(phi) length(alpha)],'M_tab1.txt','Delimiter',',')

writematrix(a,'M_tab1.txt','Delimiter',' ','WriteMode','append')
writematrix(cosphi,'M_tab1.txt','Delimiter',' ','WriteMode','append')
writematrix(alpha,'M_tab1.txt','Delimiter',' ','WriteMode','append')

for t=1:length(alpha)
    writematrix(M(:,:,t),'M_tab1.txt','Delimiter',' ','WriteMode','append')
end


