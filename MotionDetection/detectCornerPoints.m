function ip = detectCornerPoints( I, thres, w )
[ r, c ] = size( I );
ip = [];
for i = 1 : r
    for j = 1 : c 
        if i-w>0 && j-w>0 && i+w<=r && j+w<=c
            
            if interestOperator( I, i, j, w ) >= thres
                ip = [ip; i,j];
            end
        end
    end
end