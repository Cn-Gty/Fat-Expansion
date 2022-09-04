%% data after distinguish
function get_distinguished_data
    dist_all = [];
    for n = 1:500
        slice = v3_fda(n);
        dist_all = [dist_all; slice];
        n
    end
    save('distinguish_all.mat','dist_all')
% figure();
% imshow(dist_all./80)
end