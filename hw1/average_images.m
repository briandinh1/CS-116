%SET 1
filelist = dir('set1/*.jpg');

imname = ['set1/' filelist(1).name];
nextim = im2double(imread(imname));
I = nextim;

for i=1:length(filelist)
    imname = ['set1/' filelist(i).name];
    nextim = im2double(imread(imname));
    I = I + nextim;
end

I = I ./ length(filelist);
figure(1); clf; image(I);



%SET 2
filelist = dir('set2/*.jpg');

imname = ['set2/' filelist(1).name];
nextim = im2double(imread(imname));
I2 = nextim;

for i=1:length(filelist)
    imname = ['set2/' filelist(i).name];
    nextim = im2double(imread(imname));
    I2 = I2 + nextim;
end

I2 = I2 ./ length(filelist);
figure(2); clf; image(I2);