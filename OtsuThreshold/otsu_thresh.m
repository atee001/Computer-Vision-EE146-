function [T_calc] = otsu_thresh(imgGray, bcv_curr)
    [count, binLocations] = imhist(imgGray);
    K = size(binLocations,1); %number of intensities
    %create mean luminance map to optimize run time
    [bgMLUT,fgMLUT]= MakeMeanTables(count, binLocations);
    %remember binlocation is the X bit -> 8 bit compression
    q_max = -1;
    bcv_max = 0;
    n_one = 0;
    n_o = 0;
    T_calc = -1;
    for q = 1:K-1 %if q = K then everything is background ignore this case
       n_o = n_o + count(q);
       n_one = sum(count) - n_o;
       if (n_one > 0) && (n_o > 0) %as long as there is a foreground and bg set
           bcv_curr(q) = (n_one * n_o * power((bgMLUT(q)-fgMLUT(q)),2))/(power(sum(count),2));
            if bcv_curr(q) > bcv_max %maximize bcv first order equation
                bcv_max = bcv_curr(q);
                q_max = q;
            end
       end
    end
    %O(n) run time
    if(q_max > 0)
        T_calc = q_max/K;       
    end
    figure
    stem(binLocations, bcv_curr,'o');
    ylabel("Between Class Variance");
    xlabel("Intensities")
end