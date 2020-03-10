function [V] = displace(center, vertices, erosion_constant)
    [r, c] = size(vertices);
    A = ones(r, 2);
    B = ones(r, 1);
    V = ones(r, 2);

    for i = 1 : r
        next = mod(i, r) + 1;
        delta_dist = erosion_constant * rand();
        if abs(vertices(i, 1) - vertices(next, 1)) > 1e-14
            k = (vertices(i,2) - vertices(next, 2)) / (vertices(i, 1) - vertices(next, 1));
            Edge = vertices(next, :) - vertices(i, :);
            vertice_center = center - vertices(i, :);
            norm_Edge = norm(Edge);
            projection = vertice_center * Edge' / norm_Edge;
            Intersect = Edge .* projection / norm_Edge + vertices(i, :);
            Norm = center - Intersect;
            new_intersect = Intersect + Norm .* delta_dist / norm(Norm);
            a = k;
            b = -1;
            c = new_intersect(2) - k * new_intersect(1);
            A(i, :) = [a, b];
            B(i, :) = -c;
        else
            a = 1;
            b = 0;
            c =  vertices(i, 1) + delta_dist * (center(1) - vertices(i, 1)) / norm(center(1) - vertices(i, 1));
            A(i, :) = [a, b];
            B(i, :) = c;
            
        end
    end

    for i = 1:r
        next = mod(i, r) + 1;
        equations = [A(i, :); A(next, :)];
        bs = [B(i, :); B(next, :)];
        V(i, :) = linsolve(equations, bs)';
    end
end