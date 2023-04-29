function [bgMLUT, fgMLUT] = MakeMeanTables(count, binLocations)
%UNTITLED2 Summary of this function goes here
%Look up table for foreground and background mean values where the index of
%table is the threshold value q
%   Detailed explanation goes here    
    fgMLUT = zeros(256,1); %initialize mean LUT for background
    bgMLUT = zeros(256,1); %%initialize mean LUT for foreground
    n_o = 0; %numpixels in background
    s_o = 0; %intensity * count
    K = size(binLocations,1); %number of intensities
    for q = 1:K
        n_o = n_o + count(q);
        s_o = s_o + (q*count(q));
        if n_o > 0
            bgMLUT(q) = (double(s_o)/n_o);
        else
            bgMLUT(q) = -1;
        end        
    end
    n_one = 0; %numpixels in foreground
    s_one = 0; %intensity * count
    for q = (K-1):-1:1
        n_one = n_one + count(q+1);
        s_one = s_one + ((q+1)*count(q+1));
        if n_one > 0
            fgMLUT(q) = (double(s_one)/n_one);
        else
            fgMLUT(q) = -1;
        end        
    end
end