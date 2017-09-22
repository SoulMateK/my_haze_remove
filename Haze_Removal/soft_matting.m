function [ optimal_trans ] = soft_matting( trans, images )
%���¼���transmission���õ�����transmission
%���paper�У���ȡ3*3��lambda = 10^-4��epsilonδ֪
%parameter 
epsilon = 10^-5;
lambda  = 10^-4;
win_rad = 1;
dim_w = [2*win_rad+1 2*win_rad+1];

dim_images = size(images);
pixels_num = dim_images(1) * dim_images(2);
indices = 1: pixels_num;
indices_mat = reshape(indices, dim_images(1), dim_images(2));
row = [];
col = [];
result_win = [];
U = eye(3);
for i = indices
	[i, j] = ind2sub([dim_images(1) dim_images(2)], indices(i));
	xmin = max(1, i - win_rad);
	xmax = min(dim_images(1), i + win_rad); 
    ymin = max(1, j - win_rad);
    ymax = min(dim_images(2), j + win_rad);
    %may
    ind_win = indices_mat(xmin: xmax, ymin: ymax);
    ind_win = ind_win(:);
    win_length = length(ind_win);

    image_win = images(xmin: xmax, ymin: ymax, :);
    image_win = reshape(image_win, win_length, dim_images(3));
    mean_win = mean(image_win, 1);
    win_cov = cov(image_win, 1);
    win_var = (win_cov + (epsilon / win_length * U))^(-1);

    diver = image_win - repmat(mean_win, win_length, 1);
    result_temp_win = eye(win_length) - (1 + diver * win_var * diver') / win_length;
%     result_temp_win = (1 + diver * win_var * diver') / win_length;

    ind_win = repmat(ind_win, 1, win_length);
    row = [row; ind_win(:)];
    ind_win = ind_win';
    col = [col; ind_win(:)];
    result_win = [result_win; result_temp_win(:)];
end

laplacian_mat = sparse(row, col, result_win, pixels_num, pixels_num);
trans = reshape(trans, pixels_num, 1);
optimal_trans = (laplacian_mat + speye(size(laplacian_mat)) * lambda) \ (lambda * trans);
optimal_trans = reshape(optimal_trans, dim_images(1), dim_images(2));
end

