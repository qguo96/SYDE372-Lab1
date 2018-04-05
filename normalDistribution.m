function Z = normalDistribution(num, mean, covariance)
    reducedMatrix = chol(covariance);
    Z = repmat(mean,num,1) + randn(num,2)*reducedMatrix;
end