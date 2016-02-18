dir_num = 3
dir_name = ['data' int2str(dir_num) '/']

image_names = dir([dir_name '*.jpg']);
num_images = length(images);

num_filter_frames = 20;


chosen_images = zeros(480,640,3,num_filter_frames, 'uint8');

for i=1:num_filter_frames
    image_index = 100 + (num_images-100) * i / ( num_filter_frames + 1 );
    image_index = round( image_index );
    image = imread( [dir_name images(image_index).name] );
    chosen_images(:,:,:,i) = image;
    imshow(chosen_images(:,:,:,i));
end

background = median(chosen_images, 4);

imwrite(background, ['background' int2str(dir_num) '.jpg']);
    