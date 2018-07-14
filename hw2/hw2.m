% ===================================================================
% THE BEGINNING PARTS HAVE TO BE DONE SEMI-MANUALLY
% ===================================================================

% Load in images, change for different mosaics
imnames = {'atrium/IMG_1347.JPG','atrium/IMG_1348.JPG','atrium/IMG_1349.JPG'};
nimages = length(imnames);
baseim = 1; %index of the central "base" image

for i = 1:nimages
  ims{i} = imresize(im2double(imread(imnames{i})),0.25);
  ims_gray{i} = rgb2gray(ims{i});
  [h(i),w(i),~] = size(ims{i});
end

% uncomment to select points for new mosaics
% cpselect(ims{1}(), ims{3}());
% cpcorr(centerTopP, topP, ims_gray{1}(), ims_gray{2}());

% uncomment to load saved points, change for different mosaics
load botP.mat;
load centerBotP.mat;
load topP.mat;
load centerTopP.mat;

%compute homography, change arguments for different mosaics
H{2} = computeH(topP', centerTopP');
H{3} = computeH(botP', centerBotP');


% ===================================================================
%EVERYTHING AFTER THIS POINT IS AUTOMATIC
% ===================================================================

H{baseim} = eye(3);
for i = 1:nimages
   Hi{i} = inv(H{i}); 
end


for i = 1:nimages
  cx = [1 h(i)];  
  cy = [1 w(i)];
  [cx_warped{i}, cy_warped{i}] = applyH(H{i}(),cx,cy);
end


minx = 1;
miny = 1;
maxx = h(1);
maxy = w(1);
for i = 1:nimages
    minx = (min(min(cx_warped{i}), minx));
    miny = (min(min(cy_warped{i}), miny));
    maxx = (max(max(cx_warped{i}), maxx));
    maxy = (max(max(cy_warped{i}), maxy));
end
warpmin = min(minx, miny);
warpmax = max(maxx, maxy);


[xx, yy] = meshgrid(warpmin:warpmax, warpmin:warpmax-200);
for i = 1:nimages
    [xq, yq] = applyH(Hi{i}, xx(:), yy(:));
    R = interp2(ims{i}(:,:,1),xq,yq);
    G = interp2(ims{i}(:,:,2),xq,yq);
    B = interp2(ims{i}(:,:,3),xq,yq);

    J{i} = cat(3,R,G,B);
    J{i} = reshape(J{i}, [size(xx,1), size(yy,2), 3]);
    
    warpedIm = J{i};
    mask{i} = ~isnan(warpedIm);
    warpedIm(isnan(warpedIm)) = 0;
    J{i} = warpedIm;
    figure, imshow(J{i});
end


gauss = fspecial('gaussian', 15, 5); % not sure about the gauss values
alpha = mask;
for i = 1:nimages
    mask{i} = double(mask{i});
    alpha{i} = imfilter(mask{i}, gauss);
    alpha{i} = alpha{i} .* mask{i};
    % figure, imagesc(alpha{i});
end


sum = zeros(size(alpha{baseim}));
for i = 1:nimages
    sum = sum + alpha{i};
end


for i = 1:nimages
    alpha{i} = alpha{i} ./ sum;
end


mosaic = J{baseim} .* alpha{baseim};
for i = 2:nimages
    mosaic = mosaic + (J{i} .* alpha{i});
end

figure, imshow(mosaic);
% figure, imagesc(mosaic);
% imwrite(mosaic, 'atrium mosaic.jpg');