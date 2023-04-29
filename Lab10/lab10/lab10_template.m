%lab 10

clc
clear all
close all

%% parameters
thres = 5;
minArea = 10;
%% part 1


f1 = imread( 'car_frame1.jpg' );
f2 = imread( 'car_frame2.jpg' );

imshow(f1);
imshow(f2);
% convert f1 and f2 to grayscale and double precision
% code here

g1 = double(rgb2gray(f1));
g2 = double(rgb2gray(f2));

% get the difference between g1 and g2, then find the location where the
% difference is larger than the threshold (thres)
% code here

cc = (abs(g1 - g2) > thres);
% u se morphlogical ops to the difference image

cc = bwareaopen( cc, minArea );
cc = imclose( cc, strel( 'disk', 5 ));

figure; imshow( cc );
% get bounding box (bb) from regionprops 
% code here

bb = regionprops(cc, "BoundingBox");
% use insertShape to put bb on image I
% code here

cc = double(cc);

% bb returns struct containing tl and length and width 
%converted the struct to cell then to array to use as position argument 

I = insertShape(cc, "Rectangle", cell2mat(struct2cell(bb)));

figure; imshow( I );

%% part 2
w = 1;  % this is our window size
% detect the corner points
ip =  detectCornerPoints( g1, 1000, 1 );

nIp = length( ip( :, 1 ));
feat1 = zeros( nIp, (2*w+1)^2);
for i = 1 : nIp
    % get the sub pixel values of g1 from 3x3 window based on the corner points, 
    % code here
    %assuming ip is the center pixel of the window
  
    w_one = g1((ip(i,1)-1):(ip(i,1)+1), (ip(i,2)-1):(ip(i,2)+1));
    %ip(i,1)-1 to ip(i,1)+1 is length 3 width
    %ip(i,2)-1 to ip(i,2)+1 is legnth 3 height
    % reshape() the feature to 1x9, numel() can be used for counting
    % the number of elements in a matrix
    % code here
    feat1(i, :) = reshape(w_one,1,9);
end

% init the variables for computing the motion vectors
[r,c] = size( g2 );
feat2 = zeros( (r-2*w)*(c-2*w), (2*w+1)^2);
p2 = zeros( (r-2*w)*(c-2*w), 2 );
count = 1;
for i = 1+w:r-w
    for j= 1+w:c-w
        % get the sub pixel values of g2 from 3x3 window, 
        % code here
        w_two = g2((i-1):(i+1), (j-1):(j+1));
        % reshape() the feature to 1x9
        % code here
        feat2(count, :) = reshape(w_two, 1,9);
        % record the location of i, j in p2
        % code here
        p2(count, :) = [i j];
        % increase the counter
        count = count + 1;
    end
end



idxP = matchFeatures(feat1,feat2);
mp1 = ip( idxP( :, 1 ), : );
mp2 = p2( idxP( :, 2 ), : );
figure; showMatchedFeatures(g1,g2,fliplr(mp1),fliplr(mp2),'montage');