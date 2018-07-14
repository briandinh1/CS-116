function [H] = computeH(p1, p2)
    N = size(p1, 2);

    points1 = p1';
    points2 = p2';

    A = zeros(2*N, 8);
    h = zeros(8,1);
    b = p2(:);

    for i = 1:N
        c = (i-1)*2 + 1;
        x  = points1(i, 1);
        y  = points1(i, 2);
        xp = points2(i, 1);
        yp = points2(i, 2);
        A(c,:) = [x y 1 0 0 0 -x*xp -y*xp];
        A(c+1,:) = [0 0 0 x y 1 -x*yp -y*yp];
    end

    h = A \ b;
    h(9) = 1;

    H = reshape(h,3,3)';
end