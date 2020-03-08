function distance = max_dist(a, b)
    [r, c] = size(a);
    x = a(:, 1) - b(:, 1);
    y = a(:, 2) - b(:, 2);
    z = a(:, 3) - b(:, 3);
    dist = [];

    for i = 1:r - 1
        dist(i) = sqrt((x(i) - x(i + 1))^2 + (y(i) - y(i + 1))^2 + (z(i) - z(i + 1))^2);
    end

    dist(r) = sqrt((x(r) - x(1))^2 + (y(r) - y(1))^2 + (z(r) - z(1))^2);
    distance = max(dist);
end
