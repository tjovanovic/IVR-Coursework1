% Dataset .. Possible values (1, 2, 3)
dir_num = 3

% Directory path of the images
dir_name = ['data' int2str(dir_num) '/']

% Get the list of all the image file names from the chosen directory
image_names = dir([dir_name '*.jpg']);
num_images = length(image_names);

% Total number of frames we want for the median filtering
num_filter_frames = 20;


chosen_images = zeros(480,640,3,num_filter_frames, 'uint8');

for i=1:num_filter_frames
    
    % Get the index of the next_frame, starting with 100
    image_index = 100 + (num_images-100) * i / ( num_filter_frames + 1 );
    image_index = round( image_index );
    
    % Normalize the image after reading
    image = imread( [dir_name image_names(image_index).name] );
    chosen_images(:,:,:,i) = image;
    imshow(chosen_images(:,:,:,i));
end


% Get the background as the median over all the chosen images
background = median(chosen_images, 4);

% Write background as "background$i.jpg"
imwrite(background, ['background' int2str(dir_num) '.jpg']);
    