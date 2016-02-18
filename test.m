img = imread('data3/00000150.jpg');
imshow(img)

background = imread('background3.jpg');
%imshow(background)
new_img = abs(imsubtract(background, img));

gray_img = rgb2gray(new_img);
gray_img = im2double(gray_img);

level = graythresh(gray_img);
circle_level = 0.035
triangle_level = 0.35
final = im2bw(gray_img, circle_level);

%imhist(gray_img);

%imshow(final)

%imshow(new_img)

%imshow(gray_img)
