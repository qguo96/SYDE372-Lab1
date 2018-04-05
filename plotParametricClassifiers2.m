function plotParametricClassifiers2(x,y,nn,knn,Class1,Class2) 
    figure;
    title('NN and KNN Class A and B');    
    plotEquiprobabilityContour(Class1.Cov, Class1.U, Class1.cluster);
    hold on;
    plotEquiprobabilityContour(Class2.Cov, Class2.U, Class2.cluster);
    hold on;
    Class1 = scatter(Class1.cluster(:,1), Class1.cluster(:,2));
    hold on;
    Class2 = scatter(Class2.cluster(:,1), Class2.cluster(:,2));
    hold on;    
    contour(x,y,nn,'Color','Red', 'LineWidth', 1);
    contour(x,y,knn,'Color','Black', 'LineWidth', 1);
    legend([Class1 Class2],{'Class A', 'Class B'});
    xlabel('x');
    ylabel('y');
end