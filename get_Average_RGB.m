function averageColor = get_Average_RGB(image,pixelList)
lengthPixelList = length(pixelList);
h = fspecial('gaussian',10,10);
blurredImage = imfilter(image,h);
sumRed = 0;
sumGreen = 0;
sumBlue = 0;
image_double = im2double(blurredImage);
for i=1:lengthPixelList
    red = image_double(pixelList(i,2),pixelList(i,1),1) * 255;
    green = image_double(pixelList(i,2),pixelList(i,1),2) * 255;
    blue = image_double(pixelList(i,2),pixelList(i,1),3) * 255;
    sumRed = sumRed + red;
    sumGreen = sumGreen + green;
    sumBlue = sumBlue + blue;
end
averageColor = [uint8(sumRed/lengthPixelList),uint8(sumGreen/lengthPixelList),uint8(sumBlue/lengthPixelList)];
    
