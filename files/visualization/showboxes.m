function [x1,x2,y1,y2] = showboxes(im, boxes, partcolor)

imagesc(im); axis image; axis off;
if ~isempty(boxes)
  numparts = length(partcolor);
  box = boxes(:,1:4*numparts);
  xy = reshape(box,size(box,1),4,numparts);
  xy = permute(xy,[1 3 2]);
	x1 = xy(:,:,1);
	y1 = xy(:,:,2);
	x2 = xy(:,:,3);
	y2 = xy(:,:,4);
	for p = 1:size(xy,2)
		line([x1(:,p) x1(:,p) x2(:,p) x2(:,p) x1(:,p)]',[y1(:,p) y2(:,p) y2(:,p) y1(:,p) y1(:,p)]',...
		'color',partcolor{p},'linewidth',2);
	end
end
drawnow;
