function [ recover_img ] = haze_remove( img, exposure, method )
if nargin == 1
    method = 'matte';
    exposure = 0;
end
if nargin == 2
    if ischar(exposure)
        method = exposure;
        exposure = 0;
    else
        method = 'matte';
    end
end
img = double(img)./255;
dark = get_dark_channel(img);
A = get_atm_light(dark, img);
t = estimate_trans(img,A);
if strcmp( method, 'matte')
    t = soft_matting(t,img);
elseif strcmp( method, 'filter')
    I = rgb2gray(img);
    t = guidedfilter(I,t,100,0.001);
else
    error(['unkowned methold ' method '. Please Use matte or filter']);
end
recover_img = recover_scene_radiance(img,A,t,exposure);
if exposure == 1
    recover_img = recover_img + (1-recover_img) .* recover_img * 0.7;
    recover_img = imadjust(recover_img, [0.1 0.83],[]);
end

end

