function [ J_dark ] = get_dark_channel( images )
%�������ͼ�񣬻�����Dark Channel
	
dim = size(images);
patch_size = 31;
J_dark = zeros(dim(1), dim(2));
images = padarray(images, [(patch_size-1)/2 (patch_size-1)/2], Inf);
for i = 1: dim(1)
	for j = 1: dim(2)
		patch = images(i: i+patch_size-1, j: j+patch_size-1, :);
		J_dark(i,j) = min(patch(:));
	end
end

end