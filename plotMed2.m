function plotMed2(X,Y,med,Class1,Class2)
    %PLOT_ Summary of this function goes here
    %   Detailed explanation goes here
    figure;
    title('MED for Class A and B');    
    plotEquiprobabilityContour(Class1.Cov, Class1.U, Class1.cluster);
    hold on;
    plotEquiprobabilityContour(Class2.Cov, Class2.U, Class2.cluster);
    hold on;
    Class1 = scatter(Class1.cluster(:,1), Class1.cluster(:,2));
    hold on;
    Class2 = scatter(Class2.cluster(:,1), Class2.cluster(:,2));
    hold on;    
    contour(X,Y,med,[0,0], '-k', 'LineWidth', 3);
    legend([Class1 Class2],{'Class A', 'Class B'});
    xlabel('x');
    ylabel('y');
end