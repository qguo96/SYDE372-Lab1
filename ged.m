function [distance] = ged(cov1, mean1, cov2, mean2, x, y, distanceSize) 
   % Transposing the covariances 
   inv1 = inv(cov1);
   inv2 = inv(cov2);
   distance = distanceSize;
   
   % MICD/GED equation
   for (i=1:size(x,1))
      for(j=1:size(y,2))
           xBar = [x(i,j) y(i,j)];
           distance(i, j) = (sqrt((xBar - mean1) * inv1 * (xBar - mean1)')) - (sqrt((xBar - mean2) * inv2 * (xBar - mean2)'));
      end
   end        
end