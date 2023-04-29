function Q = chamferMatch( BW, R )

[m,n] = size( BW );
[r,c] = size( R );

D = bwdist( BW );
Q = zeros( m-r,n-c );

fg = nnz( R );
for i = 1 : m-r
    for j = 1 : n-c
        tempI = D( i:i+r-1, j:j+c-1 );
        Q( i, j ) = sum( tempI( R )) / fg;
    end
end