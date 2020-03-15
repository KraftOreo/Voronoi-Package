function [bool] = on_border(vertices)
    bool = false;
    [r, ~] = size(vertices);
    for i = 1:r
        bool = bool || abs(vertices(i, 1) - 0) < 1e-15 || abs(vertices(i, 1) - 1) < 1e-15...
        || abs(vertices(i, 1) - 0) < 1e-15 ||abs(vertices(i, 2) - 0) < 1e-15 || abs(vertices(i, 2) - 1) < 1e-15;
    end
end 