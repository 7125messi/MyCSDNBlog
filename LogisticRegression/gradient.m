%%gradient method
function weights = gradient(x, y)
    alpha = 0.001;%Step
    maxCycle = 500;
    [m,n] = size(x);
    weights = ones(n,1);
    for i = 1 : maxCycle
        h = sigmoid(x * weights);
        error = y - h;
        weights = weights + alpha * x' * error;
    end
end
