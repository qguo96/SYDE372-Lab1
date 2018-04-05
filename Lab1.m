% SYDE Lab 1 - Clusters and Classification Boundaries
% Presish Bhattachan 20553154
% Ali Akram 20526098
% Chenlei Shen 20457272
% Timothy Tsang 20556306

% Matrix size
Na=200;
Nb=200;
Nc=100;
Nd=200;
Ne=150;

% Mean
Ua=[5 10];
Ub=[10 15];
Uc=[5 10];
Ud=[15 10];
Ue=[10 5];

% Covariances
covA=[8 0; 0 4];
covB=[8 0; 0 4];
covC=[8 4; 4 40];
covD=[8 0; 0 8];
covE=[10 -5; -5 20];

% Create objects of class
ClassA = struct('N', Na, 'U', Ua, 'Cov', covA);
ClassB = struct('N', Nb, 'U', Ub, 'Cov', covB);
ClassC = struct('N', Nc, 'U', Uc, 'Cov', covC);
ClassD = struct('N', Nd, 'U', Ud, 'Cov', covD);
ClassE = struct('N', Ne, 'U', Ue, 'Cov', covE);

% Section 2 - Generating Clusters 
% Create random normal distributions for each class 
ClassA.cluster = normalDistribution(ClassA.N,ClassA.U,ClassA.Cov);
ClassB.cluster = normalDistribution(ClassB.N,ClassB.U,ClassB.Cov);
ClassC.cluster = normalDistribution(ClassC.N,ClassC.U,ClassC.Cov);
ClassD.cluster = normalDistribution(ClassD.N,ClassD.U,ClassD.Cov);
ClassE.cluster = normalDistribution(ClassE.N,ClassE.U,ClassE.Cov);

% Draw Equiprobability Contours
% Figure for Class A and B:
figure;
title('Class A and B: Cluster and Equiprobability Contour');
plotEquiprobabilityContour(ClassA.Cov, ClassA.U, ClassA.cluster);
hold on; 
plotEquiprobabilityContour(ClassB.Cov, ClassB.U, ClassB.cluster);
xlabel('x');
ylabel('y');

% Figure for Class C, D, and E:
figure;
title('Class C, D, and E: Cluster and Equiprobability Contour');
plotEquiprobabilityContour(ClassC.Cov, ClassC.U, ClassC.cluster);
hold on; 
plotEquiprobabilityContour(ClassD.Cov, ClassD.U, ClassD.cluster);
hold on; 
plotEquiprobabilityContour(ClassE.Cov, ClassE.U, ClassE.cluster);
xlabel('x');
ylabel('y');

% Create Meshgrid for Classifiers 
x = min([ClassA.cluster(:,1);ClassB.cluster(:,1)])-1:0.05:max([ClassA.cluster(:,1);ClassB.cluster(:,1)])+1;
y = min([ClassA.cluster(:,2);ClassB.cluster(:,2)])-1:0.05:max([ClassA.cluster(:,2);ClassB.cluster(:,2)])+1;
[x1, y1] = meshgrid(x, y);

x = min([ClassC.cluster(:,1);ClassD.cluster(:,1);ClassE.cluster(:,1)])-1:0.05:max([ClassC.cluster(:,1);ClassD.cluster(:,1);ClassE.cluster(:,1)])+1;
y = min([ClassC.cluster(:,2);ClassD.cluster(:,2);ClassE.cluster(:,2)])-1:0.05:max([ClassC.cluster(:,2);ClassD.cluster(:,2);ClassE.cluster(:,2)])+1;
[x2, y2] = meshgrid(x, y);

%% Section 3 - Classifiers 

%% MED 

% MED for Class A and B
[X_AB, Y_AB, MED_map_AB] = getMed2(ClassA.U, ClassB.U, x1, y1);
plotMed2(X_AB,Y_AB,MED_map_AB,ClassA,ClassB);

% MED for Class C, D, and E
[X_CDE, Y_CDE, MED_map_CDE] = getMed3(ClassC.U, ClassD.U, ClassE.U, x2, y2);
plotMed3(X_CDE, Y_CDE, MED_map_CDE,ClassC,ClassD,ClassE);

%% GED

% GED for Class A and B
distanceSize1 = zeros(size(x1, 1), size(y1, 2));
ged_1 = ged(covA, Ua, covB, Ub, x1, y1, distanceSize1);
plotGed2(x1,y1,ged_1,ClassA,ClassB);

% GED for Class C, D, and E
distanceSize2 = zeros(size(x2, 1), size(y2, 2));
ged_cd = ged(covC, Uc, covD, Ud, x2, y2, distanceSize2);
ged_de = ged(covD, Ud, covE, Ue, x2, y2, distanceSize2);
ged_ec = ged(covE, Ue, covC, Uc, x2, y2, distanceSize2);
ged_2 = gedClassifyMulticlass(x2,y2,ged_cd,ged_de,ged_ec);
plotGed3(x2,y2,ged_2,ClassC,ClassD,ClassE);

%% MAP

% MAP for Class A and B 
Total_Points_Case_1 = length(ClassA.cluster) + length(ClassB.cluster);
P_A = length(ClassA.cluster)/ Total_Points_Case_1;
P_B = length(ClassB.cluster)/ Total_Points_Case_1;

Class_A_B_MAP = getMap(ClassA.Cov,ClassB.Cov,ClassA.U,ClassB.U,x1,y1,P_A,P_B);
plotMap2(x1,y1,Class_A_B_MAP,ClassA,ClassB);

% MAP for Class C, D, and E 
Total_Points_Case_1 = length(ClassC.cluster) + length(ClassD.cluster) + length(ClassE.cluster);
P_C = length(ClassC.cluster)/ Total_Points_Case_1;
P_D = length(ClassD.cluster)/ Total_Points_Case_1;
P_E = length(ClassE.cluster)/ Total_Points_Case_1;

Class_C_D_MAP = getMap(ClassC.Cov,ClassD.Cov,ClassC.U,ClassD.U,x2,y2,P_C,P_D);
Class_D_E_MAP = getMap(ClassD.Cov,ClassE.Cov,ClassD.U,ClassE.U,x2,y2,P_D,P_E);
Class_E_C_MAP = getMap(ClassE.Cov,ClassC.Cov,ClassE.U,ClassC.U,x2,y2,P_E,P_C);
Mesh_Grid_Plot_2 = mapClassifyMulticlass(x2,y2,Class_C_D_MAP,Class_D_E_MAP,Class_E_C_MAP);
plotMap3(x2,y2,Mesh_Grid_Plot_2,ClassC,ClassD,ClassE);

%% Nearest Neighbor (NN)

% NN for Class A and B 
bruh = getNearestNeighbour(1,x1,y1,ClassA.cluster,ClassB.cluster);
plotNN2(x1,y1,bruh,ClassA,ClassB);

% NN for Class C, D, and E 
bruh1 = getNearestNeighbour(1,x2,y2,ClassC.cluster,ClassD.cluster,ClassE.cluster);
plotNN3(x2,y2,bruh1,ClassC,ClassD,ClassE);

%% k-Nearest Neighbor (kNN) 

% kNN for Class A and B 
breh = getNearestNeighbour(5,x1,y1,ClassA.cluster,ClassB.cluster);
plotkNN2(x1,y1,breh,ClassA,ClassB);

% kNN for Class C, D, and E 
breh1 = getNearestNeighbour(5,x2,y2,ClassC.cluster,ClassD.cluster,ClassE.cluster);
plotkNN3(x2,y2,breh1,ClassC,ClassD,ClassE);

%% Plotting Classifiers 

% Plotting MED, MICD, and MAP boundaries on same plot
plotMeanBasedClassifiers2(x1,y1,MED_map_AB,ged_1,Class_A_B_MAP,ClassA,ClassB);
plotMeanBasedClassifiers3(x2,y2,MED_map_CDE,ged_2,Mesh_Grid_Plot_2,ClassC,ClassD,ClassE);

% Plotting NN and KNN boundaries on same plot 
plotParametricClassifiers2(x1,y1,bruh,breh,ClassA,ClassB);
plotParametricClassifiers3(x2,y2,bruh1,breh1,ClassC,ClassD,ClassE);


%% Section 4 - Error Analysis 

%% MED Error Analysis 
% Confusion Matrix 
[a_as_a, a_as_b] = get_MED_for_cluster_c1(ClassA.cluster, ClassA.U', ClassB.U');
[b_as_b, b_as_a] = get_MED_for_cluster_c1(ClassB.cluster, ClassB.U', ClassA.U');

[ClassA.MEDconfusionMatrix, ClassB.MEDconfusionMatrix] = ...
    get_confusion_matrix_c1(a_as_a, a_as_b, b_as_b, b_as_a);

[c_as_c, c_as_d, c_as_e] = ...
    get_MED_for_cluster_c2(ClassC.cluster, ClassC.U', ClassD.U', ClassE.U');
[d_as_d, d_as_c, d_as_e] = ...
    get_MED_for_cluster_c2(ClassD.cluster, ClassD.U', ClassC.U', ClassE.U');
[e_as_e, e_as_c, e_as_d] = ...
    get_MED_for_cluster_c2(ClassE.cluster, ClassE.U', ClassC.U', ClassD.U');

[ClassC.MEDconfusionMatrix, ClassD.MEDconfusionMatrix, ClassE.MEDconfusionMatrix] = ...
    get_confusion_matrix_c2(c_as_c, c_as_d, c_as_e,...
                            d_as_d, d_as_c, d_as_e,...
                            e_as_e, e_as_c, e_as_d);

% Probability of Error (P(E))
P_Error_Med_2 = (a_as_b + b_as_a)/(ClassA.N + ClassB.N);
P_Error_Med_3 = (c_as_d + c_as_e + d_as_c + d_as_e + ...
    e_as_c + e_as_d)/(ClassC.N + ClassD.N + ClassE.N);

%% GED Error Analysis 
% Confusion Matrix 
[a_as_a, a_as_b] = get_GED_for_cluster_c1(...
    ClassA.cluster, ClassA.Cov, ClassA.U, ClassB.Cov, ClassB.U);
[b_as_b, b_as_a] = get_GED_for_cluster_c1(...
    ClassB.cluster, ClassB.Cov, ClassB.U, ClassA.Cov, ClassA.U);

[ClassA.GEDconfusionMatrix, ClassB.GEDconfusionMatrix] = ...
    get_confusion_matrix_c1(a_as_a, a_as_b, b_as_b, b_as_a);

[c_as_c, c_as_d, c_as_e] = ...
    get_GED_for_cluster_c2(ClassC.cluster, ClassC.Cov, ClassC.U, ClassD.Cov, ClassD.U, ClassE.Cov, ClassE.U);
[d_as_d, d_as_c, d_as_e] = ...
    get_GED_for_cluster_c2(ClassD.cluster, ClassD.Cov, ClassD.U, ClassC.Cov, ClassC.U, ClassE.Cov, ClassE.U);
[e_as_e, e_as_c, e_as_d] = ...
    get_GED_for_cluster_c2(ClassE.cluster, ClassE.Cov, ClassE.U, ClassC.Cov, ClassC.U, ClassD.Cov, ClassD.U);

[ClassC.GEDconfusionMatrix, ClassD.GEDconfusionMatrix, ClassE.GEDconfusionMatrix] = ...
    get_confusion_matrix_c2(c_as_c, c_as_d, c_as_e,...
                            d_as_d, d_as_c, d_as_e,...
                            e_as_e, e_as_c, e_as_d);
                
% Probability of Error (P(E))
P_Error_Ged_2 = (a_as_b + b_as_a)/(ClassA.N + ClassB.N);
P_Error_Ged_3 = (c_as_d + c_as_e + d_as_c + d_as_e + ...
    e_as_c + e_as_d)/(ClassC.N + ClassD.N + ClassE.N);

%% MAP Error Analysis 
% Confusion Matrix 
[MAP_a_b] = get_MAP_for_cluster_c1(...
    ClassA.Cov,ClassB.Cov,ClassA.U,ClassB.U,ClassA.cluster,P_A,P_B);
s = sign(MAP_a_b);
a_as_a = sum(s(:)==-1);
a_as_b = sum(s(:)==1);
[MAP_b_a] = get_MAP_for_cluster_c1(...
    ClassB.Cov,ClassA.Cov,ClassB.U,ClassA.U,ClassB.cluster,P_B,P_A);
s = sign(MAP_b_a);
b_as_b = sum(s(:)==-1);
b_as_a = sum(s(:)==1);
[ClassA.MAPconfusionMatrix, ClassB.MAPconfusionMatrix] = ...
    get_confusion_matrix_c1(a_as_a, a_as_b, b_as_b, b_as_a);

[c_as_c, c_as_d, c_as_e] = get_MAP_for_cluster_c2(...
    ClassC.Cov,ClassD.Cov,ClassE.Cov,ClassC.U,ClassD.U,ClassE.U,P_C,P_D,P_E,ClassC.cluster);
[d_as_c, d_as_d, d_as_e] = get_MAP_for_cluster_c2(...
    ClassC.Cov,ClassD.Cov,ClassE.Cov,ClassC.U,ClassD.U,ClassE.U,P_C,P_D,P_E,ClassD.cluster);
[e_as_c, e_as_d, e_as_e] = get_MAP_for_cluster_c2(...
    ClassC.Cov,ClassD.Cov,ClassE.Cov,ClassC.U,ClassD.U,ClassE.U,P_C,P_D,P_E,ClassE.cluster);

[ClassC.MAPconfusionMatrix, ClassD.MAPconfusionMatrix, ClassE.MAPconfusionMatrix] = ...
    get_confusion_matrix_c2(c_as_c, c_as_d, c_as_e,...
                            d_as_d, d_as_c, d_as_e,...
                            e_as_e, e_as_c, e_as_d);
        
% Probability of Error (P(E))
P_Error_Map_2 = (a_as_b + b_as_a)/(ClassA.N + ClassB.N);
P_Error_Map_3 = (c_as_d + c_as_e + d_as_c + d_as_e + ...
    e_as_c + e_as_d)/(ClassC.N + ClassD.N + ClassE.N);


%% NN Error Analysis 

% Confusion Matrix 
% Find out the confusion matrix of the Nearest neighbour two class problem
classA_test = normalDistribution(ClassA.N,ClassA.U,ClassA.Cov);
classB_test = normalDistribution(ClassB.N,ClassB.U,ClassB.Cov);
classC_test = normalDistribution(ClassC.N,ClassC.U,ClassC.Cov);
classD_test = normalDistribution(ClassD.N,ClassD.U,ClassD.Cov);
classE_test = normalDistribution(ClassE.N,ClassE.U,ClassE.Cov);

classA_test_classifier = getNearestNeighbour(1,classA_test(:,1),classA_test(:,2),ClassA.cluster,ClassB.cluster);
classB_test_classifier = getNearestNeighbour(1,classB_test(:,1),classB_test(:,2),ClassA.cluster,ClassB.cluster);
classC_test_classifier = getNearestNeighbour(1,classC_test(:,1),classC_test(:,2),ClassC.cluster,ClassD.cluster,ClassE.cluster);
classD_test_classifier = getNearestNeighbour(1,classD_test(:,1),classD_test(:,2),ClassC.cluster,ClassD.cluster,ClassE.cluster);
classE_test_classifier = getNearestNeighbour(1,classE_test(:,1),classE_test(:,2),ClassC.cluster,ClassD.cluster,ClassE.cluster);

[nn_confusion_matrix_2] = get_NN2_confusion_matrix(classA_test_classifier,classB_test_classifier);
[nn_confusion_matrix_3] = get_NN3_confusion_matrix(classC_test_classifier,classD_test_classifier,classE_test_classifier);

% Probability of Error (P(E))
P_Error_NN_2 = (nn_confusion_matrix_2(1,2) + nn_confusion_matrix_2(2,1))/(ClassA.N + ClassB.N);
P_Error_NN_3 = (nn_confusion_matrix_3(1,2) + nn_confusion_matrix_3(1,3) + ... 
    nn_confusion_matrix_3(2,1) + nn_confusion_matrix_3(2,3) + ... 
    nn_confusion_matrix_3(3,1) + nn_confusion_matrix_3(3,2))/...
    (ClassC.N + ClassD.N + ClassE.N);


%% kNN Error Analysis 
% Confusion Matrix 
classA_test = normalDistribution(ClassA.N,ClassA.U,ClassA.Cov);
classB_test = normalDistribution(ClassB.N,ClassB.U,ClassB.Cov);
classC_test = normalDistribution(ClassC.N,ClassC.U,ClassC.Cov);
classD_test = normalDistribution(ClassD.N,ClassD.U,ClassD.Cov);
classE_test = normalDistribution(ClassE.N,ClassE.U,ClassE.Cov);

classA_test_kclassifier = getNearestNeighbour(5,classA_test(:,1),classA_test(:,2),ClassA.cluster,ClassB.cluster);
classB_test_kclassifier = getNearestNeighbour(5,classB_test(:,1),classB_test(:,2),ClassA.cluster,ClassB.cluster);
classC_test_kclassifier = getNearestNeighbour(5,classC_test(:,1),classC_test(:,2),ClassC.cluster,ClassD.cluster,ClassE.cluster);
classD_test_kclassifier = getNearestNeighbour(5,classD_test(:,1),classD_test(:,2),ClassC.cluster,ClassD.cluster,ClassE.cluster);
classE_test_kclassifier = getNearestNeighbour(5,classE_test(:,1),classE_test(:,2),ClassC.cluster,ClassD.cluster,ClassE.cluster);

[knn_confusion_matrix_2] = get_KNN2_confusion_matrix(classA_test_kclassifier,classB_test_kclassifier);
[knn_confusion_matrix_3] = get_KNN3_confusion_matrix(classC_test_kclassifier,classD_test_kclassifier,classE_test_kclassifier);

% Probability of Error (P(E))
P_Error_KNN_2 = (knn_confusion_matrix_2(1,2) + knn_confusion_matrix_2(2,1))/(ClassA.N + ClassB.N);
P_Error_KNN_3 = (knn_confusion_matrix_3(1,2) + knn_confusion_matrix_3(1,3) + ... 
    knn_confusion_matrix_3(2,1) + knn_confusion_matrix_3(2,3) + ... 
    knn_confusion_matrix_3(3,1) + knn_confusion_matrix_3(3,2))/...
    (ClassC.N + ClassD.N + ClassE.N);
