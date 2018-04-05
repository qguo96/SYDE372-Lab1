function plotEquiprobabilityContour(cov, mean, cluster)    
    
[eigenvector,eigenvalue] = eig(cov);
[index, r] = find(eigenvalue == max(max(eigenvalue)));

% Get largest eigenvector
largestEigenvector = eigenvector(:, index);
largestEigenvalue = max(max(eigenvalue));

%Find smallest eigenvector 
if (index==1)
    smallestEigenvalue=max(eigenvalue(:,2));
    smallestEigenvector=eigenvector(:,2);
else
    smallestEigenvalue=max(eigenvalue(:,1));
    smallestEigenvector=eigenvector(1,:);
end

% Get angle 
theta = atan2(largestEigenvector(2), largestEigenvector(1));

theta_grid = linspace(0,2*pi);
a=sqrt(largestEigenvalue);
b=sqrt(smallestEigenvalue);
ellipse_x_r  = a*cos( theta_grid );
ellipse_y_r  = b*sin( theta_grid );

R = [ cos(theta) sin(theta); -sin(theta) cos(theta) ];

r_ellipse = [ellipse_x_r;ellipse_y_r]' * R;
hold on;
plot(r_ellipse(:,1) + mean(1),r_ellipse(:,2) + mean(2),'-')

scatter(cluster(:,1), cluster(:,2));
hold on;
end