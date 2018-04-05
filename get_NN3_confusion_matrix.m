function [confusion_matrix] = get_NN3_confusion_matrix(c,d,e)
   c_c = length(find(c==0));
   c_d = length(find(c==1));
   c_e = length(find(c==2));
   d_c = length(find(d==0));
   d_d = length(find(d==1));
   d_e = length(find(d==2));
   e_c = length(find(e==0));
   e_d = length(find(e==1));
   e_e = length(find(e==2));

confusion_matrix = ...
    [c_c, c_d, c_e; 
     d_c, d_d, d_e;
     e_c, e_d, e_e];

end