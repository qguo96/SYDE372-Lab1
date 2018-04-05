function [ classified_as_l, classified_as_k, classified_as_m ] = get_MED_for_cluster_c2( l, l_mean, k_mean, m_mean )
    classified_as_l = 0;
    classified_as_k = 0;
    classified_as_m = 0;
    
    for i = 1:size(l, 1)
        l_dist = (l(i,1) - l_mean(1))^2 + (l(i,2) - l_mean(2))^2;
        k_dist = (l(i,1) - k_mean(1))^2 + (l(i,2) - k_mean(2))^2;
        m_dist = (l(i,1) - m_mean(1))^2 + (l(i,2) - m_mean(2))^2;
        if l_dist < k_dist && l_dist < m_dist
            classified_as_l = classified_as_l + 1;
        elseif k_dist < l_dist && k_dist < m_dist
            classified_as_k = classified_as_k + 1;
        elseif m_dist < l_dist && m_dist < k_dist
            classified_as_m = classified_as_m + 1;
        end
    end
end