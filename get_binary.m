function ret = get_binary(image, background)

% Subtract background from the original image
no_background = abs(imsubtract(background, image));

% Gaussian filter to reduce the noise
gaussian_filter = fspecial('gaussian',[10 10], 2);
filtered_image = imfilter(no_background, gaussian_filter, 'same');

% Convert the image from RGB to Gray
grayscale_image = rgb2gray(filtered_image);
grayscale_image = im2double(grayscale_image);

% Extract the binary image using Otsu thresholding
threshold = graythresh(grayscale_image)
binary_image = im2bw(grayscale_image, threshold);

% Return labeled image with the connected regions
ret = bwlabel(binary_image,8);