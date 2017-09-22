function img_out = boxfilter( img_in,w )
%   均值滤波
%
%   img_in:输入图像
%   w:窗口宽度

[height, width] = size(img_in);
img_out = zeros(size(img_in));

img_temp = cumsum(img_in, 1);
img_out(1:w/2+1, :) = img_temp(1+w/2:w+1, :);
img_out(w/2+2:height-w/2, :) = img_temp(w+2:height, :) - img_temp(1:height-w-1, :);
img_out(height-w/2+1:height, :) = repmat(img_temp(height, :), [w/2,1]) - img_temp(height-w:height-w/2-1, :);

img_temp = cumsum(img_out, 2);
img_out(:, 1:w/2+1) = img_temp(:, 1+w/2:w+1);
img_out(:, w/2+2:width-w/2) = img_temp(:, w+2:width) - img_temp(:, 1:width-w-1);
img_out(:, width-w/2+1:width) = repmat(img_temp(:, width), [1,w/2]) - img_temp(:, width-w:width-w/2-1);

end

