function minV = interestOperator( I, r, c, w )

v = zeros( 1, 4 );
v(1) = var( I( r, (c-w):(c+w)));
v(2) = var( I((r-w):(r+w), c ));

%compute diagonal points
d1 = zeros( 2*w+1, 1 );
d2 = zeros( 2*w+1, 1 );
for i = 1 : 2*w+1
    d1( i ) = I( r-w-1+i, c-w-1+i );
    d2( i ) = I( r-w-1+i, c+w-i+1 );
end

v(3) = var( d1 );
v(4) = var( d2 );

minV = min( v );