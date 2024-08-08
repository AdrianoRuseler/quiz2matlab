% pngchangewhite(imgin,imgout,'boost') % 
function pngchangewhite(imgin,imgout,theme)

switch theme
    case 'classic'
        R=231;
        G=243;
        B=245;
    case 'boost'
        R=231;
        G=243;
        B=245;
    case 'union'
        R=231;
        G=243;
        B=245;
    otherwise % boost
        R=231;
        G=243;
        B=245;
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
