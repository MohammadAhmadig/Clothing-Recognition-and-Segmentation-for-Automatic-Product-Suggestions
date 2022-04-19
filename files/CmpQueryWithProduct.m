function [ indexes ] = CmpQueryWithProduct( queryFMatrix,UpperFMatrix,LowerFMatrix,ShoesFMatrix )

% bayad baraye suggest bishtar az ye meghdar taghir kone
% hamchenin bayad baraye per class product avaz beshe (halate kolli anjam shode alan)
numOfSuggestion = 4;
indexes = zeros(numOfSuggestion,size(queryFMatrix,2));
for j =1:size(queryFMatrix,2)
    if(j==1)
        errors = zeros(1,size(UpperFMatrix,1));
        for i = 1:size(UpperFMatrix,1)
            %disp('a')
            queryVsProduct = (UpperFMatrix(i,:) - cell2mat(queryFMatrix(:,j))).^2;
            errors(i) = sum(queryVsProduct);
        end
        [~,sortedInd] = sort(errors);
        indexes(:,j) = (sortedInd(1,1:numOfSuggestion))';% indexes(:,j) yani kodum radifHa az UpperFMatrix suggest mikonad
        
    end
    if(j==2)
        errors = zeros(1,size(LowerFMatrix,1));
        for i = 1:size(LowerFMatrix,1)
            queryVsProduct = (LowerFMatrix(i,:) - cell2mat(queryFMatrix(j))).^2;
            errors(i) = sum(queryVsProduct) ;
        end
        %[~,indexes(:,j)] = min(errors);
        [~,sortedInd] = sort(errors);
        indexes(:,j) = (sortedInd(1,1:numOfSuggestion))';
        %disp('a')
    end
    if(j==3)
        errors = zeros(1,size(ShoesFMatrix,1));
        for i = 1:size(ShoesFMatrix,1)
            queryVsProduct = (ShoesFMatrix(i,:) - cell2mat(queryFMatrix(j))).^2;
            errors(i) = sum(queryVsProduct) ;
        end
        %[~,indexes(:,j)] = min(errors);
        [~,sortedInd] = sort(errors);
        indexes(:,j) = (sortedInd(1,1:numOfSuggestion))';
    end
    
end

% indexes(1) vase upperimlist va indexes(2) vase lowerimlist va .. ra ba
% subplot plot konad
end

