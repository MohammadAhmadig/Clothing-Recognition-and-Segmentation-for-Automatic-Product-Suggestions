function Conv= erode(img,f)

    img=double(img);
    [s1,s2]=size(img);
    [x,y]=size(f);
    Floor=floor(x/2);
    Ceil=ceil(x/2);
    Conv=zeros(s1,s2);
    for i=Ceil:s1-Floor
        for j=Ceil:s2-Floor
            win=img(i-Floor:x+i-Ceil,j-Floor:y+j-Ceil);
            if win(2,2)
                a = win & f;
                Conv(i,j) = min(min(a));
            end
        end
    end

end