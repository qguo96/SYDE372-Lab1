function plotkNN3(x, y, knn, Class1, Class2, Class3) 
    figure;
    hold on
    contour(x, y, knn);
    plotEquiprobabilityContour(Class1.Cov, Class1.U, Class1.cluster);
    plotEquiprobabilityContour(Class2.Cov, Class2.U, Class2.cluster);
    plotEquiprobabilityContour(Class3.Cov, Class3.U, Class3.cluster);
    hold on;
    Class1 = scatter(Class1.cluster(:,1), Class1.cluster(:,2));
    hold on;
    Class2 = scatter(Class2.cluster(:,1), Class2.cluster(:,2));
    hold on;
    Class3 = scatter(Class3.cluster(:,1), Class3.cluster(:,2));
    title('K Nearest Neighbour - Class C, D and E');
    legend([Class1 Class2 Class3],{'Class C', 'Class D', 'Class E'});
    xlabel('x');
    ylabel('y');
end