function [confusion_matrix] = get_KNN2_confusion_matrix(a,b)
   a_true = length(find(a==0));
   a_false = length(find(a==1));
   b_true = length(find(b==0));
   b_false = length(find(b==1));
   
   confusion_matrix = ...
    [a_true, a_false; 
    b_true, b_false];
end