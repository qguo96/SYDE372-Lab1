function [ Mesh_Grid_Plot ] = getMap(Sa, Sb, Ma, Mb, X, Y, Pa, Pb)
    %   General Form of MAP Decision Boundary Equation 
    %   where we find Q0,Q1,Q2,Q3,Q4 values

    rows = size(X, 1);
    columns = size(Y, 2);
    Mesh_Grid_Plot = zeros(rows, size(Y, 2));
    Q_0 = inv(Sa) - inv(Sb);
    Q_1 = 2*(Mb*inv(Sb) -Ma*inv(Sa));
    Q_2 = Ma*inv(Sa)*Ma' - Mb*inv(Sb)*Mb';
    Q_3 = log(Pb/Pa);
    Q_4 = log(det(Sa)/det(Sb));
    
    for i=1:rows
        for j=1:columns
            X_BAR = [X(i,j), Y(i,j)];
            %If value of the this is 0 then that is where the decision
            %boundary lies between Class A and Class B
            Mesh_Grid_Plot(i,j) = X_BAR*Q_0*X_BAR' + Q_1*X_BAR'+Q_2+2*Q_3+Q_4;
        end
    end
end