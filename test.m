% Random file for testing matlab stuff

img = normalize(imread('data1/00000100.jpg'));
imshow(img)

background = imread('background1.jpg');
%imshow(background)
new_img = abs(imsubtract(background, img));
G = fspecial('gaussian',[10 10], 2);
Ig = imfilter(new_img,G,'same');

gray_img = rgb2gray(Ig);
gray_img = im2double(gray_img);

circle_level = graythresh(gray_img)
triangle_level = 0.35
final = im2bw(gray_img, circle_level);
labeledImage = bwlabel(final,8);

labeledImage = bwmorph(labeledImage, 'dilate', 2);
labeledImage = bwmorph(labeledImage, 'erode', 5);
%imhist(gray_img);

s = regionprops(labeledImage, 'Centroid');

figure, imshow(final)
figure, imshow(labeledImage)

%imshow(new_img)
%imshow(background)
%hist(gray_img)
