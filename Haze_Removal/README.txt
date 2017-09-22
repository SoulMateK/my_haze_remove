使用方法:调用函数 recovery_img = haze_remove(img, exposure, method)
img 为原图，RGB(0-255),
exposure 为曝光，值为0或1，建议天空区域情况设置为1，其他情况为0
method 为选用方法，值为‘matte’或'filter'，建议使用'filter'加快运算
recovery_img 为返回的去雾图片