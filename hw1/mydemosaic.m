I = im2double(imread('demosaic/IMG_1308.pgm')); 
figure(1); clf; imshow(I);

% Red 
R = I;

R(2:2:end-2, 2:2:end-2) = 0.25 * ...
    (I(1:2:end-3, 1:2:end-2) + I(1:2:end-3, 3:2:end-1) + ... 
    I(3:2:end-1, 1:2:end-3) + I(3:2:end-1, 3:2:end-1));

R(1:2:end-1,2:2:end-2) = 0.5 * ...
    (I(1:2:end-1, 1:2:end-2) + I(1:2:end-1, 3:2:end-1)); 
R(2:2:end-2, 1:2:end-1) = 0.5 * ...
    (I(1:2:end-2, 1:2:end-1) + I(3:2:end-1, 1:2:end-1));
R(end, 2:2:end-2) = 0.5 * ...
    (I(end-1, 1:2:end-3) + I(end-1, 3:2:end-1));
R(2:2:end-1, end) = 0.5 * ...
    (I(1:2:end-3, end-1) + I(3:2:end-1, end-1));

R(1:2:end-1, end) = I(1:2:end-1, end-1);
R(end, 1:2:end-1) = I(end-1, 1:2:end-1);

R(end,end) = I(end-1,end-1);


% Green
G = I;

G(2:2:end-2, 2:2:end-2) = 0.25 * ...
    (I(1:2:end-3, 2:2:end-2) + I(2:2:end-2, 1:2:end-3) + ...
    I (2:2:end-2, 3:2:end-1) + I(3:2:end-1, 2:2:end-2));

G(1, 3:2:end-1) = 0.33 * ...
    (I(1, 2:2:end-1) + I(1, 4:2:end) + I(2, 3:2:end-1));
G(3:2:end-1, 1) = 0.33 * ...
    (I(2:2:end-2, 1) + I(3:2:end-1, 2) + I(4:2:end, 1));
G(2:2:end-2, end) = 0.33 * ...
    (I(1:2:end-2, end) + I(2:2:end-2, end-1) + I(3:2:end-1, end));
G(end, 2:2:end-2) = 0.33 * ...
    (I(end, 1:2:end-3) + I(end-1, 2:2:end-2) + I(end, 3:2:end-1));

G(1,1) = 0.5 * (I(1,2) + I(2,1));
G(end, end) = 0.5 * (I(end-1, end) + I(end, end-1));


% Blue
B = I;

B(3:2:end-1, 3:2:end-1) = 0.25 * ...
    (I(2:2:end-2, 2:2:end-2) + I(2:2:end-2, 4:2:end) + ...
    I(4:2:end, 2:2:end-2) + I(4:2:end, 4:2:end));

B(2:2:end, 3:2:end-1) = 0.5 * ...
    (I(2:2:end, 2:2:end-2) + I(2:2:end, 4:2:end));
B(3:2:end-1, 2:2:end) = 0.5 * ...
    (I(2:2:end-2, 2:2:end) + I(4:2:end, 2:2:end));
B(1, 3:2:end-1) = 0.5 * ... 
    (I(2, 2:2:end-2) + I(2, 4:2:end));
B(3:2:end-1, 1) = 0.5 * ...
    (I(2:2:end-2, 2) + I(4:2:end, 2));

B(1, 2:2:end) = I(2, 2:2:end);
B(2:2:end, 1) = I(2:2:end, 2);

B(1,1) = B(2,2);


% recombining RGB
J = zeros(size(I,1), size(I,2), 3);
J(:,:,1) = R;
J(:,:,2) = G;
J(:,:,3) = B;
figure(2); clf; imshow(J);