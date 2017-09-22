function [ J ] = recover_scene_radiance( images, A, trans, sky_mk )
%�õ�����J
K = 70/255;
t0 = 0.1;
J = zeros(size(images));
for i = 1: 3
    if sky_mk == 1
        J(:,:,i) = A(i) + (images(:,:,i) - A(i)) ./ min(max(K./abs(images(:,:,i) - A(i)), 1) .* max(trans, t0), 1);
    else
        J(:,:,i) = A(i) + (images(:,:,i) - A(i)) ./ max(trans, t0);
    end
	
end

end

