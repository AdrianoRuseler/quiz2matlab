function pngimgstr = get_base64_png_from_picsum(width, height, imageID)
%GET_BASE64_PNG_FROM_PICSUM Downloads a PNG image from picsum.photos,
%encodes it in Base64, and returns the HTML <img> tag. Allows specifying
%a specific image by ID.
%   PNGIMGSTR = GET_BASE64_PNG_FROM_PICSUM(WIDTH, HEIGHT, IMAGEID) downloads
%   a PNG image of the specified WIDTH and HEIGHT from
%   https://picsum.photos. If IMAGEID is provided, it attempts to download
%   that specific image. Otherwise, a random image is downloaded. Returns
%   an HTML <img> tag with the image embedded as a Base64 data URL.
%
%   PNGIMGSTR = GET_BASE64_PNG_FROM_PICSUM(WIDTH, HEIGHT) downloads a
%   random image of the specified WIDTH and HEIGHT.
%
%   PNGIMGSTR = GET_BASE64_PNG_FROM_PICSUM() downloads a random 200x200 image.
%
%   Example (random image):
%       html_img_tag_random = get_base64_png_from_picsum(300, 200);
%       disp(html_img_tag_random);
%
%   Example (specific image with ID 10):
%       html_img_tag_specific = get_base64_png_from_picsum(200, 150, 10);
%       disp(html_img_tag_specific);

    if nargin < 2
        width = 200;
        height = 200;
        imageID = [];
    elseif nargin < 3
        imageID = [];
    end

    if isempty(imageID)
        imageURL = sprintf('https://picsum.photos/%d/%d', width, height);
    else
        imageURL = sprintf('https://picsum.photos/id/%d/%d/%d', imageID, width, height);
    end

    filename = 'picsum_temp.png'; % Temporary filename

    try
        imgpath = websave(filename, imageURL);
    catch ME
        warning('Error downloading image: %s', ME.message);
        pngimgstr = '';
        return;
    end

    fileID = fopen(imgpath, 'r');
    if fileID == -1
        warning('Could not open downloaded image file: %s', imgpath);
        pngimgstr = '';
        delete(imgpath); % Clean up the temporary file
        return;
    else
        imageData = fread(fileID, '*uint8'); % Read all bytes
        fclose(fileID);
    end

    try
        encodedData = char(org.apache.commons.codec.binary.Base64.encodeBase64(imageData))';
        altText = 'Random Image from Picsum';
        if ~isempty(imageID)
            altText = sprintf('Specific Image %d from Picsum', imageID);
        end
        pngimgstr = sprintf('<img src="data:image/png;base64,%s" alt="%s">', encodedData, altText);
    catch ME
        warning('Error encoding image to Base64: %s', ME.message);
        pngimgstr = '';
    end

    delete(imgpath); % Clean up the temporary file

end