function path = shortest_path(costs)

%
% given a 2D array of costs, compute the minimum cost vertical path
% from top to bottom which, at each step, either goes straight or
% one pixel to the left or right.
%
% costs:  a HxW array of costs
%
% path: a Hx1 vector containing the indices (values in 1...W) for 
%       each step along the path
%
%
%
    M = zeros(size(costs));
    M(1,:) = costs(1,:);
    for row = 2:size(costs,1)
      M(row,:) = costs(row,:) + get_min(M(row-1,:));
    end
    path = get_path(M);
end


function [path] = get_path(M)
   path = zeros(size(M,1),1);
   [~, path(end)] = min(M(end,:));
   
   for row = size(M,1)-1:-1:1
       col = path(row+1);
       if (col == 1)
           [~, path(row)] = min([M(row,col), ...
               M(row,col+1), inf(1,size(M,2)-2)]);
       elseif (col == size(M,2))
           [~, path(row)] = min([inf(1,size(M,2)-2), ...
               M(row,end-1), M(row,end)]);
       else
           [~, path(row)] = min([inf(1,col-2), M(row,col-1), ... 
               M(row,col), M(row,col+1), inf(1,size(M,2)-col-1)]);
       end
   end
end


function [minrow] = get_min(M)
   minrow = zeros(size(M));
   minrow(1) = min(M(1), M(2));
   for col = 2:size(M,2)-1
       minrow(col) = min([M(col-1), M(col), M(col+1)]);
   end
   minrow(end) = min(M(end-1), M(end));
end