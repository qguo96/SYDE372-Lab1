function [ counter1, counter2, counter3 ] = get_GED_for_cluster_c2( ...
    X, cov1, mean1, cov2, mean2, cov3, mean3 )

    inv1 = inv(cov1);
   inv2 = inv(cov2);
   inv3 = inv(cov3);
   
   counter1 = 0;
   counter2 = 0;
   counter3 = 0;
   
   for i=1:size(X,1)
      xBar = X(i,:);
      distance1 = (sqrt((xBar - mean1) * inv1 * (xBar - mean1)'));
      distance2 = (sqrt((xBar - mean2) * inv2 * (xBar - mean2)'));
      distance3 = (sqrt((xBar - mean3) * inv3 * (xBar - mean3)'));
      if (distance1 < distance2) && (distance1 < distance3)
          counter1 = counter1 + 1;
      elseif (distance2 < distance1) && (distance2 < distance3)
          counter2 = counter2 + 1;
      elseif (distance3 < distance1) && (distance3 < distance2)
          counter3 = counter3 + 1;
      end
   end 
end