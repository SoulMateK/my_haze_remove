function [ A ] = get_atm_light( J_dark, images )
%���Atmospheric Light

dim = size(images);
pixels_num = dim(1) * dim(2);
pick_num = round(0.01 * pixels_num);
[~, index] = sort(reshape(J_dark, pixels_num, 1),'descend');
index = index(1:pick_num);
gray_images = rgb2gray(images);
images = reshape(images, pixels_num, dim(3));
gray_images = reshape(gray_images, pixels_num, 1);
gray_images = gray_images(index, :);
[~,in] = max(gray_images);
A = images(index(in), :);

end