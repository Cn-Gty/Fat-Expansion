%% func
function ans_matrix = fda(n)
    f = load('all_data_2d.mat');
    %% a certain slice
    % note that import all_data_2d.mat first
    % n = 312;
    data = f.all_data(490*(n-1)+1:490*n,:);
    org_data = data;
    % uniformed_data = data./80;
    % % imshow(uniformed_data)

    %% re-assign air, bones, skin, musle, fat and organ
    for i = 1:490
        for j = 1:265
            if data(i,j) == 51      % skin
                data(i,j) = 20;
            elseif data(i,j) == 49  % muscle
                data(i,j) = 30;
            elseif data(i,j) == 45  % bone
                data(i,j) = 50;
            elseif data(i,j) == 48  % fat 
                data(i,j) = 70;
            elseif data(i,j) == 0   % air
                data(i,j) = 0;
            else                    % organ
                data(i,j) = 40;
            end
        end
    end
    % uniformed_data = data./80;
    % imshow(uniformed_data)

    %% fat assignment (viseral fat and subcutanous fat)
    sub_fat_length = 12;
    test_matrix = data;
    ans_matrix = data;
    % diskf = fspecial('disk',sub_fat_length);
    diskf = double(strel('disk',sub_fat_length).Neighborhood);
    % get skin
    for i = 1:490
        for j = 1:265
            if data(i,j) ~= 20  % not skin
                test_matrix(i,j) = 0;
            else
                test_matrix(i,j) = 80;            
            end
        end
    end
    uniformed_data = test_matrix./80;
    % imshow(uniformed_data)    %
    filtered_img = imfilter(uniformed_data,diskf);
    for i = 1:490
        for j = 1:265
            if data(i,j) == 70 
                if filtered_img(i,j) > 0
                    ans_matrix(i,j) = 80;
                else
                    ans_matrix(i,j) = 10;
                end
            end
        end
    end
    % imshow(ans_matrix./80)    %
    %% sub-algorithm (part1 label relative fat) 
    test_matrix = data;
    % get fat
    for i = 1:490
        for j = 1:265
            if data(i,j) == 70  % is fat
                test_matrix(i,j) = 1;
            else
                test_matrix(i,j) = 0;            
            end
        end
    end
    label = bwlabel(test_matrix);
    % % check label
    % la = label;
    % for i = 1:490
    %     for j = 1:265
    %             if label(i,j) ~= 1  % is fat
    %                 la(i,j) = 0;         
    %             end
    %     end
    % end
    % figure()
    % imshow(la)
    % max(max(label)) % how many 'classes' in this label
    % sub_algorithm (part2 visceral fat initial distinguish)
    vis_fat_len = 7;
    diskf2 = fspecial('disk',vis_fat_len);
    % find organ
    for i =1:490
        for j = 1:265
            if data(i,j) == 40
                test_matrix(i,j) = 1;
            else
                test_matrix(i,j) = 0;
            end
        end
    end
    vis_fat_matrix = imfilter(test_matrix,diskf2);
    for i =1:490
        for j = 1:265
            if data(i,j) == 70
                if vis_fat_matrix(i,j) > 0
                    ans_matrix(i,j) = 15;
                end
            end
        end
    end
    control_index = [];
    % figure()
    % imshow(ans_matrix./80)
    %% sub_algorithm main
    ans2 = ans_matrix;
    % figure()
    % imshow(ans2./80)
    wind = [];
    breakp = 1;
    for i = 1:490
        for j = 1:265
            if ans2(i,j) == 80
                indexx = label(i,j);
                if ismember(indexx,control_index)
                    continue;
                else 
                    control_index = [control_index,indexx];
                end
                matrix_same_label = [];
                for x = 1:490
                    for y = 1:265
                        if label(x,y) == indexx
                            matrix_same_label = [matrix_same_label,[x;y]]; % 2*n matrix
                            if ans2(x,y) == 15       % 
                                % break the inner loop do nothing
                                matrix_same_label = [];
                                breakp = -1;
                                break;
                            end
                        end
                    end
                    if breakp == -1
                        break;
                    end
                end
                % change this label fat into sub_fat
                [r,c] = size(matrix_same_label);
                for m = 1:c
                    ans_matrix(matrix_same_label(1,m),matrix_same_label(2,m)) = 80;                
                end
                wind = [wind,[indexx;c]];
            end
            if ans_matrix(i,j) == 10
                ans_matrix(i,j) = 15;
            end
        end
    end
    % figure()
    % imshow(ans_matrix./80)
    % hold on;


    
    %% polynomial improvement
    if n > 210  && n < 462 % hundred times of trying
        %% muscle inside wall
        xl = [];
        yl = [];
        xr = [];
        yr = [];
        for i = 100:390
            flgl = 0;
            flgr = 0;
            for j = 1:264
                if ans_matrix(i,j) == 30 && ans_matrix(i,j+1) ~= 30 && flgl==0
                    if length(xl) == 0
                        xl = [xl;i];
                        yl = [yl;j-1];
                    elseif abs(yl(end)-j) < 58
                        xl = [xl;i];
                        yl = [yl;j-1];
                        flgl = 1;
                    end
    %                 xl = [xl;i];
    %                 yl = [yl;j-1];
    %                 flgl = 1;
    %                 flgr = 0;
                    for j2 = j+1:264
                        if ans_matrix(i,j2) ~= 30 && ans_matrix(i,j2+1) == 30
                            if flgr == 0    % first right pixel
                                xr = [xr;i];
                                yr = [yr;j2];
                                flgr = 1;
                            else            % not the first right pixel, subsitude
                                xr = [xr(1:end-1);i];
                                yr = [yr(1:end-1);j2];
                            end
                        end           
                    end
                    if flgr == 0
                        xl = xl(1:end-1);
                        yl = yl(1:end-1);
                    end     
                end
            end
        end
        muscle_wall_x = [xl;xr(end:-1:1)];
        muscle_wall_y = [yl;yr(end:-1:1)];
    %     figure()
    %     imshow(ans_matrix./80)
    %     hold on;
    %     plot(yl,xl,'x')
    %     hold on;
    %     plot(yr,xr,'o')
    %     plot(muscle_wall_y,muscle_wall_x)
        %% Change wrong_vis_fat into sub_fat
        for i = 1:490
            for j = 1:265
                if ans_matrix(i,j) == 15 && ~inpolygon(i,j,muscle_wall_x,muscle_wall_y)
                    ans_matrix(i,j) = 80;
                end
            end
        end
    end

    %% when n bigger than 460, all subfat
    for i = 1:490
        for j = 1:265
            if n > 460
               if ans_matrix(i,j) == 15
                   ans_matrix(i,j) = 80;
               end
            end
        end
    end
%     figure();
%     imshow(ans_matrix./80)
end
