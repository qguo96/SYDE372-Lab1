% Check each value to see which class it belongs to 
% Positive means belongs to class1, negative means belongs to class2
function [Z] = gedClassifyMulticlass(x,y,ged1,ged2,ged3)
    Z = zeros(size(x,1), size(y,2));    
    for (i=1:size(x, 1))
       for (j=1:size(y, 2))
          if (ged1(i,j) < 0 && ged3(i,j) > 0)
              % If distance is less than 0 for cd and greater than 0 for ec, it is part of class C
              Z(i,j) = 1;
          elseif (ged1(i,j) > 0 && ged2(i,j) < 0)
              % If distance is greater than 0 for cd and greater than 0 for de, it is part of class D
              Z(i,j) = 2;
          elseif (ged2(i,j) > 0 && ged3(i,j) < 0)
              % If distance is greater than 0 for de and less than 0 for ec, it is part of class E
              Z(i,j) = 3;
          end
       end
    end
end