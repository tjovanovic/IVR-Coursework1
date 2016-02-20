dir_num = 3;
dir_name = ['data' int2str(dir_num) '/'];

image_files = dir([dir_name '*.jpg']);
num_images = length(image_files);

% Which frame we want to start tracking the robots from
starting_frame = 120;

% Fetch the background for a particular dataset
background = imread(['background' int2str(dir_num) '.jpg']);

%%%%%%%%%%%%%%%%% Set the initial parameters %%%%%%%%%%%%%%%%
frame = imread( [dir_name image_files(starting_frame).name] );

% Convert to frame to binary thresholded image
binary_image = get_binary(frame, background);

% Get the inital white blobs
region_props = regionprops(binary_image, 'all');

% Get the number of robots
num_robots = length(region_props) % ASSUMING ALL ROBOTS ARE PRESENT IN THE INITIAL FRAME

% Keep the positions of all the centers in each frame (can be optimized using only 1 matrix -- TODO )
center_Xs = zeros(num_robots, num_images);
center_Ys = zeros(num_robots, num_images);

% Set the initial centers
for j=1:num_robots
    center_j = region_props(j).Centroid;
    center_Xs(j, starting_frame) = center_j(1);
    center_Ys(j, starting_frame) = center_j(2);
end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=(starting_frame+1):num_images
    % Get the current frame and normalize the RGB values
    frame = imread( [dir_name image_files(i).name] );
    
    % Show it so we can draw boxes + path ono it
    imshow(frame)
    
    % Convert the frame to binary thresholded image
    binary_image = get_binary(frame, background);
    
    % Get the regions(contours) of the white blobs
    region_props = regionprops(binary_image, 'all');
    
    % Sort the regions in a descending fashion based on region AREA
    [blah, order] = sort([region_props(:).Area],'descend');
    region_props = region_props(order);
    
    % Get the number of regions
    num_regions = length(region_props);
    
    % Holds the indicator of the center being present for a particular robot
    found_center = zeros(1, num_robots);
    
    % Holds the bounding boxes for each robot
    bounding_boxes_tmp = zeros(num_regions, 4);
    
    % Get the bouding boxes and centers of the regions from the NEW frame
    for j=1:min(num_regions, num_robots)
        
        % J-th center from the list of white blobs
        center_j = region_props(j).Centroid;
        
        bounding_box = region_props(j).BoundingBox;
        bounding_boxes_tmp(j,:) = bounding_box;
        
        % Closest robot to center_j
        index_closest = find_closest_robot(center_j, center_Xs, center_Ys, i-1);

        % Set the new position of the robot to center_j
        center_Xs(index_closest, i) = center_j(1);
        center_Ys(index_closest, i) = center_j(2);
        found_center(index_closest) = 1;
    end
    
    % If the center hasn't been set, copy the previous value
    for j=1:num_robots
        if found_center(j) == 0
            center_Xs(j, i) = center_Xs(j, i - 1);
            center_Ys(j, i) = center_Ys(j, i - 1);
        end 
    end
    
    % Draw the bounding boxes
    for j=1:num_regions
        bounding_box = bounding_boxes_tmp(j,:);
        rectangle('Position', bounding_box,'EdgeColor','r','LineWidth',1 );
    end
    hold on;
    
    % Draw the paths of the robots
    for k=1:num_robots
        plot(center_Xs(k,starting_frame:i),center_Ys(k,starting_frame:i),'r','LineWidth',5);
    end
    hold on;
    
    % Pause the time between iterations to keep boxes from flickering
    pause(0.000000000001);
end