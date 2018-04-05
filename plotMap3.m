function plotMap3(x,y,map,Class1, Class2, Class3) 
    figure;
    title('MAP for Class C, D, and E');
    plotEquiprobabilityContour(Class1.Cov, Class1.U, Class1.cluster);
    hold on;
    plotEquiprobabilityContour(Class2.Cov, Class2.U, Class2.cluster);
    hold on;
    plotEquiprobabilityContour(Class3.Cov, Class3.U, Class3.cluster);
    hold on;
    Class1 = scatter(Class1.cluster(:,1), Class1.cluster(:,2));
    hold on;
    Class2 = scatter(Class2.cluster(:,1), Class2.cluster(:,2));
    hold on;
    Class3 = scatter(Class3.cluster(:,1), Class3.cluster(:,2));
    hold on;

    % Plotting the MAP regions
    contour(x,y,map,[-100, 0]);
    % Plotting the MAP decision boundary
    contour(x,y,map,2,'Color','cyan');
    legend([Class1 Class2 Class3],{'Class C', 'Class D', 'Class E'});
    xlabel('x');
    ylabel('y');
end