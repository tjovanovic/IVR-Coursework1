dir_num = 1;
dir_name = ['data' int2str(dir_num) '/'];

image_names = dir([dir_name '*.jpg']);
num_images = length(images);

background = imread(['background' int2str(dir_num) '.jpg']);

num_robots = 3;

% Keep the positions of all the centers in each frame
center_Xs = zeros(num_robots, num_images);
center_Ys = zeros(num_robots, num_images);

for i=2:2
    % Get the current frame and normalize the RGB values
    frame = normalize( imread( [dir_name images(i).name] ) );
    
    % Convert to frame to binary thresholded image
    binary_image = get_binary(frame, background);
    
    % Get the regions(contours) of the white blobs
    region_props = regionprops(binary_image, 'all');
    
    % Keep if the closest center to a certain robot has been found
    found_center = zeros(1, num_robots);
    for j=1:length(region_props)
        
        % J-th center from the list of white blobs
        center_j = region_props(j).Centroid
        
        % Closest robot to center_j
        index_closest = find_closest_robot(center_j, center_Xs, center_Ys, i-1)
        
        % Set the new position of the robot to center_j
        center_Xs(index_closest, i) = center_j(1)
        center_Ys(index_closest, i) = center_j(2)
        found_center(index_closest) = 1
    end
    
    for j=1:num_robots
        
    end
end