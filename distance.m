% Euclidian distance between two points of form [x y]
function dist = distance(a, b)

dist = sum((a - b) .^ 2);