function [ distance ] = get_MAP_for_cluster_c1( Sa, Sb, Ma, Mb, X, Pa, Pb)
    rows = size(X, 1);
    distance = zeros(1, rows);
    Q_0 = inv(Sa) - inv(Sb);
    Q_1 = 2*(Mb*inv(Sb) -Ma*inv(Sa));
    Q_2 = Ma*inv(Sa)*Ma' - Mb*inv(Sb)*Mb';
    Q_3 = log(Pb/Pa);
    Q_4 = log(det(Sa)/det(Sb));
    
    for i=1:rows
        X_BAR = X(i,:);
        distance(i) = X_BAR*Q_0*X_BAR' + Q_1*X_BAR'+Q_2+2*Q_3+Q_4;       
    end
end