I = im2double(imread('fb.png'));
A = I(1:100, 1:100);

% 6a.
figure(1); clf; plot(sort(A(:)'));

% 6b.
figure(2); clf; hist(sort(A(:)'),32);

% 6c.
B = A;
threshold = 0.5; %based on histogram results
for c = (1:100)
    for r = (1:100)
        if B(r,c) < threshold
            B(r,c) = 0.0;
        else 
            B(r,c) = 1.0;
        end
    end
end
figure(3); clf; imshow(B);

% 6d.
mint = mean(sort(A(:)'));
C = A;
for c = (1:100)
    for (r = 1:100)
        C(r,c) = C(r,c) - mint;
        if C(r,c) < 0
            C(r,c) = 0;
        end
    end
end
figure(4); clf; imshow(C);

% 6e.
y = [1:6];
y = reshape(y,[3,2])

% 6f.
[min idx] = min(A(:));
[r c] = ind2sub(size(A),idx);

% 6g.
v = [1 8 8 2 1 3 9 8]
numel(unique(v))