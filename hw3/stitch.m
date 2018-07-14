function [result] = stitch(leftI,rightI,overlap)

% 
% stitch together two grayscale images with a specified overlap
%
% leftI : the left image of size (H x W1)  
% rightI : the right image of size (H x W2)
% overlap : the width of the overlapping region.
%
% result : an image of size H x (W1+W2-overlap)
%
    if (size(leftI,1)~=size(rightI,1)) % make sure the images have compatible heights
      error('left and right image heights are not compatible');
    end

    
    L = leftI(:,1:size(leftI,2)-overlap); % left section
    LL = leftI(:,size(leftI,2)-overlap+1:end); % overlapped left section

    R = rightI(:,overlap+1:end); % right section
    RR = rightI(:,1:overlap); % overlapped right section

    % copy non-overlapping ends 
    result = zeros(size(leftI,1),size(leftI,2)+size(rightI,2)-overlap);
    result(:,1:size(leftI,2)-overlap) = L;
    result(:,size(result,2)-size(R,2)+1:end) = R;

    % copy overlapped areas according to seam path
    path = shortest_path(abs(LL-RR));
    LR = zeros(size(result,1),overlap);     
    for row = 1:size(result,1)
        LR(row,1:path(row)) = LL(row,1:path(row));
        LR(row,path(row)+1:end) = RR(row,path(row)+1:end);
    end   
    result(:,size(leftI,2)-overlap+1:size(result,2)-size(R,2)) = LR;
end