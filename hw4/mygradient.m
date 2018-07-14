function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%

dx = imfilter(I,[-1,0,1],'symmetric');
dy = imfilter(I,[-1;0;1],'symmetric');

mag = sqrt((dx.^2) + (dy.^2));

ori = atan(dy./dx);
ori(isnan(ori)) = 0;

