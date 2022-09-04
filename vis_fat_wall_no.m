function vis_fat_wall_no
    %% fat exp
    fat_exp_len = 5;
    all_dist_dat = load('distinguish_all.mat');
    %% bone,muscle and organ adjacent pixels.
    % vis_fat wall;
    vis_muscle_allx = [];
    vis_muscle_ally = [];
    vis_bone_allx = [];
    vis_bone_ally = [];    
    vis_organ_allx = [];
    vis_organ_ally = [];
    % cur slice pixel
    vis_fat_musclex_cur = [];
    vis_fat_muscley_cur = [];
    vis_fat_bonex_cur = [];
    vis_fat_boney_cur = [];
    vis_fat_organx_cur = [];
    vis_fat_organy_cur = [];
    for n = 1:500
        cur_slice = all_dist_dat.dist_all(490*(n-1)+1:490*n,:);
        for i = 2:489
            for j = 2:264
                if cur_slice(i,j) == 15
                    if cur_slice(i-1,j) == 30 || cur_slice(i+1,j) == 30 || ...
                            cur_slice(i,j+1) == 30 || cur_slice(i,j-1) == 30
                        vis_fat_musclex_cur = [vis_fat_musclex_cur;i];
                        vis_fat_muscley_cur = [vis_fat_muscley_cur;j];
                    end
                    if cur_slice(i-1,j) == 50 || cur_slice(i+1,j) == 50 || ...
                        cur_slice(i,j+1) == 50 || cur_slice(i,j-1) == 50
                        vis_fat_bonex_cur = [vis_fat_bonex_cur;i];
                        vis_fat_boney_cur = [vis_fat_boney_cur;j];
                    end
                    if cur_slice(i-1,j) == 40 || cur_slice(i+1,j) == 40 || ...
                        cur_slice(i,j+1) == 40 || cur_slice(i,j-1) == 40
                        vis_fat_organx_cur = [vis_fat_organx_cur;i];
                        vis_fat_organy_cur = [vis_fat_organy_cur;j];
                    end
                end
            end
        end
        vis_muscle_allx = [vis_muscle_allx;vis_fat_musclex_cur];
        vis_muscle_ally = [vis_muscle_ally;vis_fat_muscley_cur];    
        vis_bone_allx = [vis_bone_allx;vis_fat_bonex_cur];
        vis_bone_ally = [vis_bone_ally;vis_fat_boney_cur];    
        vis_organ_allx = [vis_organ_allx;vis_fat_organx_cur];
        vis_organ_ally = [vis_organ_ally;vis_fat_organy_cur];
        % view img
%         figure()
%         imshow(cur_slice./80)
%         hold on;
%         scatter(vis_fat_muscley_cur,vis_fat_musclex_cur,1)    
%         hold on;
%         scatter(vis_fat_boney_cur,vis_fat_bonex_cur,1)
%         hold on;
%         scatter(vis_fat_organy_cur,vis_fat_organx_cur,1)
        % reset
        vis_fat_musclex_cur = [];
        vis_fat_muscley_cur = [];
        vis_fat_bonex_cur = [];
        vis_fat_boney_cur = [];
        vis_fat_organx_cur = [];
        vis_fat_organy_cur = [];
    end
    out_wall_muscle_no = length(vis_muscle_allx);
    out_wall_bone_no = length(vis_bone_allx);
    out_wall_organ_no = length(vis_organ_allx);
    save('muscle_vis.mat','out_wall_muscle_no');
    save('organ_vis.mat','out_wall_organ_no');
end
