function plotMap2(X,Y,map,Class1,Class2)
    figure;
    title('MAP for Class A and B');
    plotEquiprobabilityContour(Class1.Cov, Class1.U, Class1.cluster);
    hold on;
    plotEquiprobabilityContour(Class2.Cov, Class2.U, Class2.cluster);
    hold on;
    Class1 = scatter(Class1.cluster(:,1), Class1.cluster(:,2));
    hold on;
    Class2 = scatter(Class2.cluster(:,1), Class2.cluster(:,2));
    hold on;
    
    % Plotting the MAP regions
    contour(X,Y,map, [-100, 0]);
    % Plotting the MAP decision boundary
    contour(X,Y,map, [0, 0], 'Color', 'cyan', 'LineWidth', 1);
    legend([Class1 Class2],{'Class A', 'Class B'});
    xlabel('x');
    ylabel('y');
end