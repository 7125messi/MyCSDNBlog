function [ H ] = g( X )
    H = 1 ./ (1 + exp(-X));
end

