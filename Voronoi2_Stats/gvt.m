clear
clc
lambda = 100;
% generate the coordinates which is randomly distributed.
original_x = lambda^0.5 * randn(lambda, 1);
original_y = lambda^0.5 * randn(lambda, 1);
original_x = (original_x - min(original_x)) / (max(original_x)-min(original_x));
original_y = (original_y - min(original_y)) / (max(original_y) - min(original_y));
% move all the seeds to the centroid
[px, py] = lloydsAlgorithm(original_x, original_y, [0 0; 0 lambda^0.5; lambda^0.5 lambda^0.5; lambda^0.5 0], 250, false);
figure("Name", "Actual distribution")
for k = 1:12
    ax(k) = subplot(7,7,k);
end
% segment the moving path to 10 part and calculate the distribution of cells' area
plot_num = 0;
% initialize a matrix to store the mean, variance, minimum and maximum for every iteration.
distribution_parameters = ones(21, 4);
% calculate the distribution and plot the distribution
for k = 0:0.1:1
    x_cor = (1 - k) * original_x + k * px;
    y_cor = (1 - k) * original_y + k * py;
    e = [x_cor, y_cor];
    [v, c] = voronoin(e);

    for p = 1:lambda
        t = [v(c{p}, 1), v(c{p}, 2)];
        [r, s] = size(t);
        a = 0;

        for q = 2:r - 1
            a1 = 1/2 * abs((t(q, 1) - t(1, 1)) * (t(q + 1, 2) - t(1, 2)) - (t(q + 1, 1) - t(1, 1)) * (t(q, 2) - t(1, 2)));
            a = a + a1;
        end

        Area(p) = a;
    end

    %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ind_inf = isinf(Area);
    [inf_r inf_c] = find(ind_inf == 1);
    Area(inf_c) = [];
    ind_nan = isnan(Area);
    Area(ind_nan) = [];
    Area(Area > 2) = [];
    n = 20;
    x = linspace(min(Area), max(Area), n);
    y = zeros(1, n);

    for i = 1:length(Area)

        for j = 1:n - 1

            if Area(i) > x(j) && Area(i) <= x(j + 1)
                y(j) = y(j) + 1;
            else
                y(j) = y(j) + 0;
            end

        end

    end
    plot_num = plot_num + 1;
    subplot(ax(plot_num))
    bar(x, y / length(Area))
    distribution_parameters(plot_num, 1) = mean(Area);
    distribution_parameters(plot_num, 2) = var(Area);
    distribution_parameters(plot_num, 3) = min(Area);
    distribution_parameters(plot_num, 4) = max(Area);

end

figure("Name", "Estimated distribution")
hold on;
for i = 1:12
    x = linspace(min(distribution_parameters(:, 3)), max(distribution_parameters(:, 4)), 300);
    y = exp(-(x-distribution_parameters(i,1)).^2/(2 * distribution_parameters(i, 2)))/(2 * pi * distribution_parameters(i, 2)).^0.5;
    plot(x, y, "LineWidth", 1.5)
end