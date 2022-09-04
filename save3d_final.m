% first step
% read_data('C:\Users\LENOVO\Desktop\dissertation\code\3d.txt')
% 
% % second step
function final_matrix_2D = save3d_final(exl,r)
%     final_matrix_3D = zeros(490,265,500);
    final_matrix_2D = [245000,265];
    for i = 1:500
        [org_img,ans_img] = fat_exp(i,exl,r);
        org_img = org_img./80;
        ans_img = ans_img./80;
%         final_img = [final_img;ans_img];
%         final_matrix_3D(:,:,i) = ans_img;
        final_matrix_2D(490*(i-1)+1:490*i,1:265) = ans_img;
        i
    end
%     save('final_img_3D.mat','final_matrix_3D');
%     imshow(final_matrix_3D(:,:,300))

end
