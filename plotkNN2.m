function plotkNN2(x, y, knn, Class1, Class2) 
    figure;
    plotEquiprobabilityContour(Class1.Cov, Class1.U, Class1.cluster);
    plotEquiprobabilityContour(Class2.Cov, Class2.U, Class2.cluster);
    hold on;
    Class1 = scatter(Class1.cluster(:,1), Class1.cluster(:,2));
    hold on;
    Class2 = scatter(Class2.cluster(:,1), Class2.cluster(:,2));
    hold on;
    contour(x, y, knn);
    title('K Nearest Neighbour - Class A and B')
    legend([Class1 Class2],{'Class A', 'Class B'});
    xlabel('x');
    ylabel('y');
end