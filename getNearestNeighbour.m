function class_location = getNearestNeighbour(k,x,y,cluster1,cluster2,cluster3)
    class_location = zeros(size(x,1),size(y,2));
    
    %For each point in the cluster, test the distance between the gridpoint
    %and that cluster point. The closer the distance, the one that it is
    %going to be defined to.
    for i = 1:size(x,1)
        for j = 1:size(x,2)
            sample_point = [x(i,j) y(i,j)];
            cluster_A = find_cluster_distances(cluster1,sample_point);
            cluster_B = find_cluster_distances(cluster2,sample_point);
            if nargin > 5
                cluster_C = find_cluster_distances(cluster3,sample_point);
                class_location(i,j) = compare_distances(k,cluster_A,cluster_B,cluster_C);
            else
                class_location(i,j) = compare_distances(k,cluster_A,cluster_B);
            end
        end
    end
end

function dist = find_distance(main_point, sample_point)
    x_part = main_point(1,1) - sample_point(1,1);
    y_part = main_point(1,2) - sample_point(1,2);
    dist = sqrt(x_part^2+y_part^2);
end

function [distances] = find_cluster_distances(cluster,sample_point)
    distances = zeros(size(cluster,1),1);
    for i = 1:size(cluster,1)
        distances(i,1) = find_distance(cluster(i,:),sample_point);
    end
end

function class = compare_distances(k,clusterA,clusterB,clusterC)
    % Find out which class the point is at.
    % 0 is class A
    % 1 is class B
    % 2 is class C
    clusterA = sort(clusterA);
    clusterB = sort(clusterB);
    if nargin > 3
        clusterC = sort(clusterC);
    end
    if k == 1
        if nargin > 3
            if clusterA(1,1) < clusterB(1,1)
                class = 0;
                if clusterA(1,1) > clusterC(1,1)
                    class = 2;
                end
            else
                class = 1;
                if clusterB(1,1) > clusterC(1,1)
                    class = 2;
                end
            end
         else
            if clusterA(1,1) < clusterB(1,1)
                class = 0;
            else
                class = 1;
            end
        end
    else
        clusterAAvg = mean(clusterA(1:k,1));
        clusterBAvg = mean(clusterB(1:k,1));
        if nargin > 3
            clusterCAvg = mean(clusterC(1:k,1));
        end
        if nargin > 3
            if clusterAAvg < clusterBAvg
                class = 0;
                if clusterAAvg > clusterCAvg
                    class = 2;
                end
            else
                class = 1;
                if clusterBAvg > clusterCAvg
                    class = 2;
                end
            end
        else
            if clusterAAvg < clusterBAvg
                class = 0;
            else
                class = 1;
            end
        end
    end
end