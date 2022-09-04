% function read_final
clear;    
processed_img = load('ALL_PROCESSED_DATA.mat').processed_img;
threeD = reshape(processed_img,[500,265,490]);
a = threeD(1,:,:);
b = reshape(a,[490,265]);
imshow(b)
%     for i = 1:
    
% end