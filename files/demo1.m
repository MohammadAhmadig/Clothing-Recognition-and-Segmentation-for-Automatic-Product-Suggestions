clear;close all;
addpath visualization;
if isunix()
  addpath mex_unix;
elseif ispc()
  addpath mex_pc;
end

compile;

% load and display model
load('PARSE_model'); 
% visualizemodel(model);

% initialize
label = {'Null','Head','Upper','Pants','Shoes'};
%upperInd = [3,8,9,10,15,20,21,22];% just yellow
upperInd = [3,8,9,10,15,20,21,22,4,5,6,7,16,17,18,19];
pantsInd = [11,12,13,23,24,25];
shoesInd = [14,26];
headInd = [1,2];

% disp('model template visualization');
% disp('press any key to continue'); 
% %pause;
% visualizeskeleton(model);
% disp('model tree visualization');
% disp('press any key to continue'); 
%pause;

imlist = dir('images/*.jpg');
for i = 1:length(imlist)
    % load and display image
    figure;
    im = imread(['images/' imlist(i).name]);
    clf; imagesc(im); axis image; axis off; drawnow;

    % call detect function
    tic;
    boxes = detect_fast(im, model, min(model.thresh,-1));
    dettime = toc; % record cpu time
    boxes = nms(boxes, .1); % nonmaximal suppression
    colorset = {'g','g','y','m','m','m','m','y','y','y','r','r','r','r','y','c','c','c','c','y','y','y','b','b','b','b'};
    figure;
    [x1,x2,y1,y2] = showboxes(im, boxes(1,:),colorset); % show the best detection
    %showboxes(im, boxes,colorset);  % show all detections
    fprintf('detection took %.1f seconds\n',dettime);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    labeledMatrix = zeros(size(im,1),size(im,2));
    xy=round( [x1;x2;y1;y2]);
    xy(find(xy<1))=1;
    temp =xy(3:4,:);
    temp(find(temp>size(im,1)))=size(im,1);
    xy(3:4,:) = temp;
    temp2 = xy(1:2,:);
    %xy(find(xy(3:4,:)>size(im,1)))=size(im,1);
    temp2(find(temp2>size(im,2)))=size(im,2);
    xy(1:2,:) = temp2;
    
    % Head
    [~,ind] = min(xy(1,headInd));%
    x1Head = headInd(ind);
    [~,ind] = max(xy(2,headInd));%
    x2Head = headInd(ind);
    [~,ind] = min(xy(3,headInd));%
    y1Head = headInd(ind);
    [~,ind] = max(xy(4,headInd));%
    y2Head = headInd(ind);
    Head = im(xy(3,y1Head):xy(4,y2Head),xy(1,x1Head):xy(2,x2Head),:);
    labeledMatrix(xy(3,y1Head):xy(4,y2Head),xy(1,x1Head):xy(2,x2Head)) = 1;
    
    % Upper
    [~,ind] = min(xy(1,upperInd));%
    x1Upper = upperInd(ind);
    [~,ind] = max(xy(2,upperInd));%
    x2Upper = upperInd(ind);
    [~,ind] = min(xy(3,upperInd));%
    y1Upper = upperInd(ind);
    [~,ind] = max(xy(4,upperInd));%
    y2Upper = upperInd(ind);
    Upper = im(xy(3,y1Upper):xy(4,y2Upper),xy(1,x1Upper):xy(2,x2Upper),:);
    labeledMatrix(xy(3,y1Upper):xy(4,y2Upper),xy(1,x1Upper):xy(2,x2Upper)) = 2;
    
    % pants
    [~,ind] = min(xy(1,pantsInd));%
    x1Pants = pantsInd(ind);
    [~,ind] = max(xy(2,pantsInd));%
    x2Pants = pantsInd(ind);
    [~,ind] = min(xy(3,pantsInd));%
    y1Pants = pantsInd(ind);
    [~,ind] = max(xy(4,pantsInd));%
    y2Pants = pantsInd(ind);
    Pants = im(xy(3,y1Pants):xy(4,y2Pants),xy(1,x1Pants):xy(2,x2Pants),:);
    labeledMatrix(xy(3,y1Pants):xy(4,y2Pants),xy(1,x1Pants):xy(2,x2Pants)) = 3;
    
    % shoes
    [~,ind] = min(xy(1,shoesInd));%
    x1Shoes = shoesInd(ind);
    [~,ind] = max(xy(2,shoesInd));%
    x2Shoes = shoesInd(ind);
    [~,ind] = min(xy(3,shoesInd));%
    y1Shoes = shoesInd(ind);
    [~,ind] = max(xy(4,shoesInd));%
    y2Shoes = shoesInd(ind);
    Shoes = im(xy(3,y1Shoes):xy(4,y2Shoes),xy(1,x1Shoes):xy(2,x2Shoes),:);
    labeledMatrix(xy(3,y1Shoes):xy(4,y2Shoes),xy(1,x1Shoes):xy(2,x2Shoes)) = 4;
    
%     figure;imshow(uint8(Head));
%     figure;imshow(uint8(Upper));
%     figure;imshow(uint8(Pants));
%     figure;imshow(uint8(Shoes));
    
    %
%     disp('press any key to continue');
%     pause;
    
    grayIm = rgb2gray(im);
    labeledMatrix(grayIm < 5) = 0;
    % roo khode image ham grayIm < 5 konam
    % call colored function and get Features and then call suggestion clothes
    segmentedMatrix = DispSegmentedImage( im , labeledMatrix );
    Indexes = Suggest_Product( im , labeledMatrix );
    Indexes
%     disp('press any key to continue');
%     pause;
end


