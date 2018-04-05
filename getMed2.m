function [X, Y, MED_map] = getMed2(mean1, mean2, X, Y)
    l_mean = transpose(mean1);
    k_mean = transpose(mean2);
    MED_map = zeros(size(X, 1), size(Y,2));

    for i = 1:size(MED_map, 1)
        for j = 1:size(MED_map, 2)
            k_dist = (X(i, j) - k_mean(1))^2 + (Y(i, j) - k_mean(2))^2;
            l_dist = (X(i, j) - l_mean(1))^2 + (Y(i, j) - l_mean(2))^2;
            MED_map(i, j) = k_dist - l_dist;
        end
    end
end