tic
img = imread('IMG_8763.jpg');
img_rec = haze_remove(img, 0, 'matte');
% img_rec = haze_remove(img, 1, 'filter');
toc
figure;
subplot(1,2,1);imshow(img);
subplot(1,2,2);imshow(img_rec);
