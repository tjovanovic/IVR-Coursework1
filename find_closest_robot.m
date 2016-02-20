% Finds the closest robot to the point given their last known position
function index = find_closest_robot(point, center_Xs, center_Ys, filled_centers_num)

min_dist = 99999999999;
index = -1;

% Total number of robots on the field
total_robots = length( center_Xs(:,1) );

for i = 1:total_robots
    center_i = [center_Xs(i,filled_centers_num) center_Ys(i, filled_centers_num)];
    dist = distance(point, center_i);
    if dist < min_dist
        min_dist = dist;
        index = i;
    end
end