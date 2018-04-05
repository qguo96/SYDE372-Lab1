function [ counter1, counter2 ] = get_GED_for_cluster_c1( ...
    X, cov1, mean1, cov2, mean2)
   % Transposing the covariances 
   inv1 = inv(cov1);
   inv2 = inv(cov2);
   counter1 = 0;
   counter2 = 0;
   
   % MICD/GED equation
   for i=1:size(X,1)
      xBar = X(i,:);
      distance1 = (sqrt((xBar - mean1) * inv1 * (xBar - mean1)'));
      distance2 = (sqrt((xBar - mean2) * inv2 * (xBar - mean2)'));
      if distance1 < distance2
          counter1 = counter1 + 1;
      elseif distance2 < distance1
          counter2 = counter2 + 1;
      end
   end 
end