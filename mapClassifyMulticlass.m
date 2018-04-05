function [Z] = mapClassifyMulticlass(x,y,Class_C_D_MAP,Class_D_E_MAP,Class_E_C_MAP)
    Z = zeros(size(x,1), size(y,2));    
    for i = 1:size(x,1)
        for j = 1:size(y,2)
            if Class_C_D_MAP(i,j) >= 0 && Class_D_E_MAP(i,j) <= 0
                Z(i,j) = 1;
            elseif Class_D_E_MAP(i,j) >= 0 && Class_E_C_MAP(i,j) <= 0
                Z(i,j) = 2;
            elseif  Class_E_C_MAP(i,j) >= 0 && Class_C_D_MAP(i,j) <= 0
                Z(i,j) = 3;
            end
        end
    end
end