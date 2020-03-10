n = 2;
set = V.Set(n);
A = set.A;
b = set.b;
v = set.V;

figure
xlim([-0.5,1])
ylim([-0.5,1])
hold on;
for i = 1:length(b)
    next = mod(i, length(b)) + 1;
    if abs(v(i, 1) - v(next, 1)) > 1e-15
        k = (v(i,2) - v(next, 2)) / (v(i, 1) - v(next, 1));
        x = linspace(v(i, 1), v(next, 1),100);
        y = k .* (x - v(i,1)) + v(i, 2);
        plot(x, y)
    else
        y = linspace(v(i,2), v(next, 2),100);
        x = ones(size(y))*v(i,1);
        plot(x,y)
    end
    
end

plot(S(1,n), S(2,n), "*", "MarkerSize", 5)
    