function [x2 y2] = applyH(H, x1, y1)
    p(1,:) = x1(:);
    p(2,:) = y1(:);
    p(3,:) = 1;

    x2 = H(1,:) * p;
    y2 = H(2,:) * p;
    w  = H(3,:) * p;

    x2 = x2 ./ w;
    y2 = y2 ./ w;
end