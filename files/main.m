
% SHOW_PIXEL_ANNO visualization of pixel-level annotations
% Wei YANG 2014
% platero.yang (at) gmail.com
clear;close all;
imname = '0126';
our_products = [4 7 13 14 31 39];
load('feature_matrix_product.mat');% bayad bara per class product avaz she
load('label_list', 'label_list'); % load label list
load(['annotations/pixel-level/' imname '.mat'], 'groundtruth'); % load an pixel-level annotation

im = imread(['photos/' imname '.jpg']);    % original image
imshow(im);
% get image-level labels name
cur_labels = unique(groundtruth);
label_names = cell(1, length(cur_labels));
for i = 1:length(cur_labels)
    label_names(i) = label_list( cur_labels(i)+1 );
end

f = figure;
colors = colormap( jet(length(label_list)) );   % set color map

% % 1. show original photo
subplot(1, 3, 1);  imshow(im); hold on; title('Original'); 

% % 2. visualize annotation
gt_image = zeros(size(groundtruth, 1), size(groundtruth, 2), 3);

for labelidx = 1:length(cur_labels)
    [rows cols] = find(groundtruth == cur_labels(labelidx));
    % rang amizi colormap('lines')
    curcolor = colors(cur_labels(labelidx)+1, :);
    for i=1:length(rows)
        gt_image(rows(i), cols(i), 1) = curcolor(1);
        gt_image(rows(i), cols(i), 2) = curcolor(2);
        gt_image(rows(i), cols(i), 3) = curcolor(3);
    end
end

subplot(1, 3, 2); 
imshow(gt_image); hold on; title('Ground Truth'); 

% % 3. visualize legend
subplot(1, 3, 3); 
axis off; hold on; % show off the axis 
for i=1:length(cur_labels)
    [rows cols] = find(groundtruth == cur_labels(i));
    plot(cols, rows, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(cur_labels(i)+1, :), 'MarkerSize', 10, 'visible', 'off');
end
set(gca, 'Ydir', 'reverse'); hold off;
legend(label_names, 'Location', 'West');
%pause; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
query_feature_matrix = [];
for i = 1:length(our_products)
    if (ismember(our_products(i),cur_labels))
        query_product = zeros(size(groundtruth, 1), size(groundtruth, 2), 3);
        [rows cols] = find(groundtruth == our_products(i));% 13 coat   31 pants
        %query_product(rows,cols) = im(rows,cols);
        for i=1:length(rows)
            query_product(rows(i), cols(i),:) = im(rows(i), cols(i),:);
        end
        query_product = uint8(query_product);
        features = GetFeatures( query_product );
        query_feature_matrix = [query_feature_matrix;features];
    end
    
end

indexes = CmpQueryWithProduct( query_feature_matrix,feature_matrix_product );
indexes

% query_product2 = zeros(size(groundtruth, 1), size(groundtruth, 2), 3);
% [rows cols] = find(groundtruth == 48);% 13 coat   31 pants
% %query_product(rows,cols) = im(rows,cols);
% 
% for i=1:length(rows)
%     query_product2(rows(i), cols(i),:) = im(rows(i), cols(i),:);
% end
% figure
% query_product2 = uint8(query_product2);
% imshow(query_product2);



