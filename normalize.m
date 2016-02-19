% Normalization of the RGB values of the picture
% using R = (R / sqrt ( R^2 + G^2 + B^2 )) * 255
% same with other colors

function ret = normalize(frame)

double_frame = im2double(frame);

% Extract the individual channels
r = double_frame(:,:,1);
g = double_frame(:,:,2);
b = double_frame(:,:,3);

% root of R^2 + G^2 + B^2
total = max(1, sqrt (r.^2 + g.^2 + b.^2));

% Compute the new RGB values of the image
r_new = r * 255 ./ total;
g_new = g * 255 ./ total;
b_new = b * 255 ./ total;

% Prep the new image for inserting values
image = zeros(480,640,3, 'double');
image(:,:,1) = r_new;
image(:,:,2) = g_new;
image(:,:,3) = b_new;

image = (image - min(image(:))) / (max(image(:)) - min(image(:))); % Needs to be quickly tested again

% Conversion from double to uint8 for showing
ret = im2uint8(image); 
