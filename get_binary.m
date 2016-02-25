function ret = get_binary(image, background)

% Subtract background from the original image
no_background = abs(imsubtract(background, image));

% Get the binary image for each channel
thresholded_image = no_background > 50;

% Or the images per channel to get the final image
binary_image = thresholded_image(:,:,1) | thresholded_image(:,:,2) | thresholded_image(:,:,3);

% Close the gaps to get clear blobs
se = strel('disk', 6);
binary_image = imclose(binary_image, se);

% Mitigates the issue of super small regions by removing them with erode
binary_image = bwmorph(binary_image, 'erode', 2);
binary_image = bwmorph(binary_image, 'dilate', 3);

% Return labeled image with the connected regions
ret = bwlabel(binary_image,8);