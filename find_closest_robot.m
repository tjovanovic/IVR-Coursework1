% Finds the closest robot to the point given their last known position
function index = find_closest_robot(point, center_Xs, center_Ys, count_centers)

min_dist = 1000000
index = -1

for i = 1:length(center_Xs)
    center_i = [center_Xs(i,count_centers) center_Ys(i, count_centers)]
    dist = distance(point, center_i);
    if dist < min_dist
        min_dist = dist
        index = i
    end
end