function [ counter_c, counter_d, counter_e, random] = get_MAP_for_cluster_c2( Sc, Sd, Se, Mc, Md, Me, Pc, Pd, Pe, X)
    % X is the class we are trying to classify
    counter_c = 0;
    counter_d = 0;
    counter_e = 0;
    
    % if there are any exceptions 
    random = 0; 
    
    %check distance between c and d
    rows = size(X, 1);

    for i=1:rows
        X_BAR = X(i,:);
        Q_0 = inv(Sc) - inv(Sd);
        Q_1 = 2*(Md*inv(Sd) -Mc*inv(Sc));
        Q_2 = Mc*inv(Sc)*Mc' - Md*inv(Sd)*Md';
        Q_3 = log(Pd/Pc);
        Q_4 = log(det(Sc)/det(Sd));
        
        distance_1 = X_BAR*Q_0*X_BAR' + Q_1*X_BAR'+Q_2+2*Q_3+Q_4; 

        %belongs to class c
        if distance_1 <= 0
            %now compare with class C and E
            Q_0 = inv(Sc) - inv(Se);
            Q_1 = 2*(Me*inv(Se) - Mc*inv(Sc));
            Q_2 = Mc*inv(Sc)*Mc' - Me*inv(Se)*Me';
            Q_3 = log(Pe/Pc);
            Q_4 = log(det(Sc)/det(Se));
            distance_2 = X_BAR*Q_0*X_BAR' + Q_1*X_BAR'+Q_2+2*Q_3+Q_4;

            if distance_2 <= 0 
                %classifies as C
                counter_c = counter_c + 1;
            elseif distance_2 > 0
                counter_e = counter_e + 1;                
            else 
                random = random+1;
            end 

        else
            %doesn't classify as Class_C
            Q_0 = inv(Sd) - inv(Se);
            Q_1 = 2*(Me*inv(Se) -Md*inv(Sd));
            Q_2 = Md*inv(Sd)*Md' - Me*inv(Se)*Me';
            Q_3 = log(Pe/Pd);
            Q_4 = log(det(Sd)/det(Se));
            %check if its closer D or E
            distance_3 = X_BAR*Q_0*X_BAR' + Q_1*X_BAR'+Q_2+2*Q_3+Q_4;

            if distance_3 <= 0 
                % classifies as D
                counter_d = counter_d + 1;
            elseif distance_3 > 0
                counter_e = counter_e + 1;
                
            else
                 random = random+1;
            end 
        end
    end        
end