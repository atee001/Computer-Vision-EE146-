function [n_arr] = getNeighbors(img,x,y)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    n_arr = zeros(1,2); %msb is left lsb is top
    %left
    if(x > 1)
        n_arr(1) = img(x-1,y);
    end
    if(y > 1)
        n_arr(2) = img(x, y-1);
    end
end