function [ features ] = GetFeatures( org , class)

I = rgb2gray(org);
% figure
% imshow(I)

% rotation invariant and L1 normalization
% 'Normalization','None'
% 'NumNeighbors',8
H1 = extractLBPFeatures(I,'Upright',false);
% numNeighbors = 8; numBins = numNeighbors*(numNeighbors-1)+3;
% mapping=getmapping(3,'u2');
% H1=lbp(I,1,3,mapping,'h'); %LBP histogram in (8,1) neighborhood
%                          %using uniform patterns

H1 = H1 / sum(H1);
% figure;
% subplot(2,1,1),stem(H1);


threshRGB = multithresh(org,8);
value = [0 threshRGB(1:end)];
indexes=value+1;
colorfeatures=zeros(size(value,2),3);
quantRGB = imquantize(org, threshRGB, value);
% figure
% imshow(quantRGB)
% [countsR,~] = imhist(quantRGB(:,:,1));
% [countsG,~] = imhist(quantRGB(:,:,2));
% [countsB,~] = imhist(quantRGB(:,:,3));
% colorfeatures(:,1) = countsR(indexes)';
% colorfeatures(:,2) = countsG(indexes)';
% colorfeatures(:,3) = countsB(indexes)';
% colorfeaturess = reshape(colorfeatures,[1 3*size(colorfeatures,1)]);
% colorfeaturess = colorfeaturess / sum(colorfeaturess);


run('VLFEATROOT/VLFEATROOT/toolbox/vl_setup')
image = rgb2gray(org);
image = single(image);
org_f = vl_sift(image);
org_f = org_f(:);

[rows, columns, ~] = size(org);
hsvImage = rgb2hsv(org); % Ranges from 0 to 1.
colorfeaturess = zeros(5,5,5);
for col = 1 : columns
    for row = 1 : rows
        hBin = floor(hsvImage(row, col, 1) * 10/2.5+1);
        sBin = floor(hsvImage(row, col, 2) * 10/2.5+1);
        vBin = floor(hsvImage(row, col, 3) * 10/2.5+1);
        colorfeaturess(hBin, sBin, vBin) = colorfeaturess(hBin, sBin, vBin) + 1;
    end
end

% length(org_f(1:16))
if class == 1
    features = [H1 org_f(1:80)' colorfeaturess(:)'];
elseif class == 2
    features = [H1 org_f(1:40)' colorfeaturess(:)'];
else 
    features = [H1 org_f(1:16)' colorfeaturess(:)'];
end

%features = colorfeaturess;
% brickVsBrick = (f00 - f01).^2;
% brickVsCarpet = (f00 - f02).^2;
% sum(brickVsCarpet)
% sum(brickVsBrick)




end

