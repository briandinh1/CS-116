function output = synth_quilt(tindex,tile_vec,tilesize,overlap)
%
% synthesize an output image given a set of tile indices
% where the tiles overlap, stitch the images together
% by finding an optimal seam between them
%
%  tindex : array containing the tile indices to use
%  tile_vec : array containing the tiles
%  tilesize : the size of the tiles  (should be sqrt of the size of the tile vectors)
%  overlap : overlap amount between tiles
%
%  output : the output image

if (tilesize ~= sqrt(size(tile_vec,1)))
  error('tilesize does not match the size of vectors in tile_vec');
end


% 
% stitch each row into a separate image by repeatedly calling your stitch function
% 

stitched_rows = cell(size(tindex,1),1);
for row = 1:size(tindex,1)
    tile_image = tile_vec(:,tindex(row,1));
    tile_image = reshape(tile_image,tilesize,tilesize); 
    stitched_rows{row} = tile_image;
    
    for col = 2:size(tindex,2)
        tile_image = tile_vec(:,tindex(row,col));
        tile_image = reshape(tile_image,tilesize,tilesize);
        stitched_rows{row} = stitch(stitched_rows{row},tile_image,overlap);
    end
end

%
% now stitch the rows together into the final result 
% (I suggest calling your stitch function on transposed row 
% images and then transpose the result back)
%

output = stitched_rows{1}';
for i = 2:size(stitched_rows,1)
    output = stitch(output,stitched_rows{i}',overlap);
end
output = output';


