function [ trans ] = estimate_trans( images, A )

omega = 0.95;
for i = 1: 3
	images(:, :, i) = images(:, :, i) ./ A(i);
end
trans = 1 - omega * get_dark_channel(images);

end

