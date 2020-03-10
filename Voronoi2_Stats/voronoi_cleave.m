clc
clear;
num = 10;
S = rand(2, num); % Generate the coordinate matrix of the seeds which is 3 by num
% S = (S - min(S)) ./ (max(S) - min(S)); % Normalize the coordinates of the seed to [0, 1]
B = Polyhedron([0 0; 1 0; 1 1; 0 1;]); % Generate the bound for the seed, namely the shape of object, which is a cube in this case.
% Calculate the voronoi structure for the seeds
[V, P] = mpt_voronoi(S, 'bound', B);
figure("Name", "Oringinal cells")
% plot the original distribution of the cells
plot(P)
for n = 1 : num
   seed = S(:, n)';
   v = V.Set(n).V;
   new_v = displace(seed, v, 0.01);
   new_Poly(n) = Polyhedron(new_v);
end
hold on;
plot(S(1,:), S(2,:), "*", "MarkerSize", 5)
figure
plot(new_Poly)
hold on;
plot(S(1,:), S(2,:), "*", "MarkerSize", 5)