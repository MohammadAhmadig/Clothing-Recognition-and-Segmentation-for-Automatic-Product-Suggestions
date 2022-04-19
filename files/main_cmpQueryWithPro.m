clear;close all;

%im=imread('00.png');
load('query_prosw');
im = query_product2;
QuerySegfeatures = GetFeatures( im );
load('feature_matrix_product.mat');
errors = zeros(1,size(feature_matrix_product,1));
for i = 1:size(feature_matrix_product,1)
    queryVsProduct = (feature_matrix_product(i,:) - QuerySegfeatures).^2;
    errors(i) = sum(queryVsProduct) ;
end
[val,ind] = min(errors);
ind

