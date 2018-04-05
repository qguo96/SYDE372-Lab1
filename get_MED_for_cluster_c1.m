function [ classified_as_l, classified_as_k ] = get_MED_for_cluster_c1( l, l_mean, k_mean )
    classified_as_l = 0;
    classified_as_k = 0;
    
    for i = 1:size(l, 1)
        l_dist = (l(i,1) - l_mean(1))^2 + (l(i,2) - l_mean(2))^2;
        k_dist = (l(i,1) - k_mean(1))^2 + (l(i,2) - k_mean(2))^2;
        if l_dist < k_dist 
            classified_as_l = classified_as_l + 1;
        else if k_dist < l_dist
            classified_as_k = classified_as_k + 1;        
        end
        end
    end
end