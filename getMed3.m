function [X, Y, MED_map] = getMed3(mean1, mean2, mean3, X, Y)
    boundary = 0;
    class_l = 1;
    class_k = 2;
    class_o = 3;
    l_mean = transpose(mean1);
    k_mean = transpose(mean2);
    o_mean = transpose(mean3);
    MED_map = zeros(size(X, 1), size(Y,2));

    for i = 1:size(MED_map, 1)
        for j = 1:size(MED_map, 2)
            l_dist = (X(i, j) - l_mean(1))^2 + (Y(i, j) - l_mean(2))^2;
            k_dist = (X(i, j) - k_mean(1))^2 + (Y(i, j) - k_mean(2))^2;
            o_dist = (X(i, j) - o_mean(1))^2 + (Y(i, j) - o_mean(2))^2;
            if l_dist < k_dist && l_dist < o_dist
                MED_map(i, j) = class_l;
            elseif k_dist < l_dist && k_dist < o_dist
                MED_map(i, j) = class_k;
            elseif o_dist < k_dist && o_dist < l_dist
                MED_map(i, j) = class_o;
            else
                MED_map(i, j) = boundary;
            end
        end
    end
end