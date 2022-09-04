function [data,final_ans] = fat_exp(n,exl,r)
%% fat exp volume
%     exl = 2.27; % liters
    ex = exl*10^6;

    muscle_vis_no = load('muscle_vis.mat').out_wall_muscle_no;
    organ_vis_no = load('organ_vis.mat').out_wall_organ_no;

    total_no = muscle_vis_no + organ_vis_no;

    %weight
    ratio_o_m = r;

    depth_muscle = ex/(muscle_vis_no+ratio_o_m*organ_vis_no);
    depth = round(depth_muscle);

    %% exp
    f = load('distinguish_all.mat');
    % n = 1;
    data = f.dist_all(490*(n-1)+1:490*n,:); % slice
    filter_m = double(strel('disk',depth).Neighborhood);
    filter_o = double(strel('disk',depth*ratio_o_m).Neighborhood);
    final_ans = data;
    % muscle part
    f_data = data;
    for i = 1:490
        for j = 1:265
            if f_data(i,j) == 15
                f_data(i,j) = 1;
            else 
                f_data(i,j) = 0;
            end
        end
    end
    filtered_m_img = imfilter(f_data,filter_m);
    for i = 1:490 
        for j = 1:265
            if final_ans(i,j) == 30
                if filtered_m_img(i,j) > 1
                    final_ans(i,j) = 15;
                end
            end
        end
    end
% 
%     figure()
%     subplot(132)
%     imshow(final_ans./80)

    % organ part
    filtered_o_img = imfilter(f_data,filter_o);
    for i = 1:490 
        for j = 1:265
            if final_ans(i,j) == 40
                if filtered_o_img(i,j) > 1
                    final_ans(i,j) = 15;
                end
            end
        end
    end
% 
%     subplot(133)
%     imshow(final_ans./80)
%     subplot(131)
%     imshow(data./80)
end