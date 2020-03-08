clc
clear
num = 100; %number for grain seeds
S = randn(3, num); % Generate the coordinate matrix of the seeds which is 3 by num
S = (S - min(S)) ./ (max(S) - min(S)); % Normalize the coordinates of the seed to [0, 1]
B = Polyhedron([0 0 0; 1 0 0; 1 1 0; 0 1 0; 0 0 1; 1 0 1; 1 1 1; 0 1 1]); %Generate the bound for the seed, namely the shape of object, which is a cube in this case.
% Calculate the voronoi structure for the seeds
[V, P] = mpt_voronoi(S, 'bound', B);

figure("Name", "Oringinal cells")
% plot the original distribution of the cells
plot(V)

% Initialize (Prelocatting) a matrix to store the original centroids of all grains
% This initialization is just to improve the performance and the speed of
% this script
original_centroids = 100 * ones(num, 3);
% Calculate the centroid of initial grains
for i = 1:num
    k = boundary(V.Set(i, 1).V);
    [c, vol] = centroid(V.Set(i, 1).V, k);
    original_centroids(i, :) = c;
end

% Initializing the new centroids
centroids_in_last_iteration = 100 * ones(num, 3);
% Iterating to achieve a relatively uniform distribution for all the seeds.
% The main idea is:
% 1. find the boundry covered by the vertices for every cell
% 2. determine the centroid for every cell
% 3. set the new centroid coordinated to the matrix centroids_in_last_iteration matrix
% 4. move the original seeds to the newly generated centroids, by setting the oringinal_centroids to c
% 5. calculate the max distance of all seeds to their centroids. Stop the while loop when
%    the max distance is less than the threshold, namely the seeds are not moving and the algorithm converges at this point.
% Then stop the while loop
threshold = 1e-20;

while max_dist(original_centroids, centroids_in_last_iteration) > threshold

    for i = 1:num
        k = boundary(V.Set(i, 1).V);
        [c, vol] = centroid(V.Set(i, 1).V, k);
        centroids_in_last_iteration = original_centroids;
        original_centroids(i, :) = c;
    end

    [V, P] = mpt_voronoi(original_centroids', 'bound', B);
end

figure("Name", "Adjusted Cells")
plot(V)
