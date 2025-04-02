% pngchangewhite(imgin,imgout,'boost') % 
function pngchangewhite(imgin,imgout,theme)

% imgout=png2mdl(imgin,theme)
% A2=png2mdl(imgin,theme); % Change png file backgorund
switch theme
    case 'clean'
        R=217;
        G=237;
        B=247;
    case 'classic'
        R=231;
        G=243;
        B=243;
    case 'boost39'
        R=204;
        G=230;
        B=234;
    case 'boost44'
        R=231;
        G=243;
        B=245;
    case 'boost'
        R=204;
        G=230;
        B=234;
    otherwise %
        R=204;
        G=230;
        B=234;
end

A = imread(imgin);
% figure
% imshow(A)
% Extract RGB vectors
Rin = A(:,:,1); 
Gin = A(:,:,2); 
Bin = A(:,:,3); 

% Replace white color
Rin(Rin==255)=R;
Gin(Gin==255)=G;
Bin(Bin==255)=B;

% Create new image
A2(:,:,1) =Rin;
A2(:,:,2) =Gin;
A2(:,:,3) =Bin;
% imshow(I)

imwrite(A2,imgout)
