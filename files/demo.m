addpath visualization;
if isunix()
  addpath mex_unix;
elseif ispc()
  addpath mex_pc;
end

compile;

% load and display model
load('PARSE_model'); 
visualizemodel(model);
disp('model template visualization');
disp('press any key to continue'); 
pause;
visualizeskeleton(model);
disp('model tree visualization');
disp('press any key to continue'); 
pause;

imlist = dir('images/*.jpg');
for i = 1:length(imlist)
    % load and display image
    im = imread(['images/' imlist(i).name]);
    clf; imagesc(im); axis image; axis off; drawnow;

    % call detect function
    tic;
    boxes = detect_fast(im, model, min(model.thresh,-1));
    dettime = toc; % record cpu time
    boxes = nms(boxes, .1); % nonmaximal suppression
    colorset = {'g','g','y','m','m','m','m','y','y','y','r','r','r','r','y','c','c','c','c','y','y','y','b','b','b','b'};
    [x1,x2,y1,y2] = showboxes(im, boxes(1,:),colorset); % show the best detection
    %showboxes(im, boxes,colorset);  % show all detections
    fprintf('detection took %.1f seconds\n',dettime);
    disp('press any key to continue');
    pause;
end

% x1 = round(x1);
% x2 = round(x2);
% y1 = round(y1);
% y2 = round(y2);
matrix=zeros(size(im,2),size(im,1));
xy=round( [x1;x2;y1;y2]);
xy(find(xy<1))=1;
temp =xy(3:4,:);
temp(find(temp>size(im,1)))=size(im,1);
xy(3:4,:) = temp;
temp2 = xy(1:2,:);
%xy(find(xy(3:4,:)>size(im,1)))=size(im,1);
temp2(find(temp2>size(im,2)))=size(im,2);
xy(1:2,:) = temp2;
for i = 1:26
    matrix(xy(1,i):xy(2,i),xy(3,i):xy(4,i))=1;
end

%erode
% figure;imshow(matrix);title('Original Image')
% mask = ones(9);
% imageErosion = erode(matrix, mask);
% matrix = imageErosion;

rgb=nan(size(im));
rgb(:,:,1)= uint8(matrix').*im(:,:,1);
rgb(:,:,2)= uint8(matrix').*im(:,:,2);
rgb(:,:,3)= uint8(matrix').*im(:,:,3);
figure;
imshow(uint8(rgb));
disp('done');


