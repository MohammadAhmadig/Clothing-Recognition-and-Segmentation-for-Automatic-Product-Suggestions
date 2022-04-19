function [ segmentedMatrix ] = DispSegmentedImage( Image , SMatrix )

%imname = '0126';
labels = {'Null','Head','Upper','Pants','Shoes'};
%our_products = [2 3 4];
%load('feature_matrix_product.mat');% bayad bara per class product avaz she
%load('label_list', 'label_list'); % load label list
%load(['annotations/pixel-level/' imname '.mat'], 'groundtruth'); % load an pixel-level annotation

%Image = imread(['photos/' imname '.jpg']);    % original image
%imshow(Image);
% get image-level labels name
unique_labels = unique(SMatrix);
label_names = cell(1, length(unique_labels));
for i = 1:length(unique_labels)
    label_names(i) = labels( unique_labels(i)+1 );
end

f = figure;
colors = colormap( jet(length(labels)*5) );   % set color map

% % 1. show original photo
subplot(1, 3, 1);  imshow(Image); hold on; title('Original'); 

% % 2. visualize annotation
gt_image = zeros(size(SMatrix, 1), size(SMatrix, 2), 3);

for labelidx = 1:length(unique_labels)
    [rows cols] = find(SMatrix == unique_labels(labelidx));
    % rang amizi colormap('lines')
    curcolor = colors(4*(unique_labels(labelidx)+1), :);
    for i=1:length(rows)
        gt_image(rows(i), cols(i), 1) = curcolor(1);
        gt_image(rows(i), cols(i), 2) = curcolor(2);
        gt_image(rows(i), cols(i), 3) = curcolor(3);
    end
end

subplot(1, 3, 2); 
imshow(gt_image); hold on; title('Segmented Clothes Image'); 

% % 3. visualize legend
subplot(1, 3, 3); 
axis off; hold on; % show off the axis 
for i=1:length(unique_labels)
    [rows cols] = find(SMatrix == unique_labels(i));
    plot(cols, rows, 's', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colors(4*(unique_labels(i)+1), :), 'MarkerSize', 10, 'visible', 'off');
end
set(gca, 'Ydir', 'reverse'); hold off;
legend(labels, 'Location', 'West');

segmentedMatrix = gt_image;
end

