# Fat-Expansion
%%%%%%%%%%%%%%%%%%%%%%% Digital Human Phantom (DHP) %%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                        %%
%% Read this INSTRUCTIONS to run the code properly                        %%
%% This Dissertation code is written by MATLAB R2021b and Python 3.10.5   %%
%% Make sure you have install the MATLAB and Python correctly             %%
%%                                                                        %%
%% NOTE: If you only need result, jump directly to the third part: GUI    %%
%%                                                                        %%
%% Code Version: 1.0        Developer: Taiyue Guo                         %%
%% Enjoy :D                                                               %%
%%                                                                        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Content
1. Data and data format
    1.1 v1_00400.pgm to v1_00899.pgm
    1.2 3d.txt
    1.3 all_data_2d.mat 
    1.4 distinguish_all.mat
    1.5 muscle_vis.mat and organ_vis.mat
    1.6 final_img_22_2D.mat
    1.7 ALL_PROCESSED_DATA.mat 
2. Functions 
    2.1 all_data_output2txt.py
    2.2 read3d.m
    2.3 v3_fda.m and get_distinguished_data.m
    2.4 vis_fat_wall_no.m
    2.5 fat_exp.m
3. GUI
4. Code Running Instructions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

1. Data and data format
1.1 v1_00400.pgm to v1_00899.pgm
    Those are original data, collected from a normal Japanese 
    man. Each of them contain 265 * 490 values.
1.2 3d.txt
    This 3d.txt file is the pure value from original data.
    It have 245000 * 265 values in total.
1.3 all_data_2d.mat 
    This file provides a readable format for the MATLAB.
    It concludes all the values from 3d.txt file.
1.4 distinguish_all.mat
    This file includes the distinguished data (data after
    distinguishing sub_fat and vis_fat).
1.5 muscle_vis.mat and organ_vis.mat
    Those two files record the total pixels between vis_fat
    and others(muscles and organs).
1.6 final_img_22_2D.mat
    This file records the final result when the two parameters
    are default(2,2). 
1.7 ALL_PROCESSED_DATA.mat 
    This file is saved by the UI. It provides the processed data.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

2. Functions
2.1 all_data_output2txt.py
    This function is used to transfer .pgm file into a pure 
    .txt file, which concludes all the values. 
    Note that you have to change two paths in this file.
2.2 read3d.m
    This function is used to read all the data from '3d.txt'.
    The result is output into the 'all_data_2d.mat' file.
    Also it allow us to view the data in a different direction.
2.3 v3_fda.m and get_distinguished_data.m
    v3 means the third version of the fat distinguish algorithm.
    v3_fda.m can get sub_fat and vis_fat be distinguished in 
    current slice.
    Use get_distinguished_data.m to save all slices output into 
    'distinguish_all.mat'
2.4 vis_fat_wall_no.m
    This function will save all the pixels between visceral fat 
    and others(such as bones, muscles and organs). They are 
    saved into 'muscle_vis.mat' and 'organ_vis.mat'.
2.5 fat_exp.m
    This function is used to implement the fat expansion 
    algorithm. Three main variables can be define here. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

3. GUI
    If you just need the result, please READ FROM HERE!!!
    Two parameters are shown on the left top corner, they can be 
    changed. 
    Then click 'run' button. If the values are default, data 
    could be directly loaded, and need several seconds. Else, 
    you may wait for several minutes(about 10 minutes) in order to 
    get your target data. 
    After programs processing, 'Data Ready!' text will show on 
    the text bar.
    Then select the direction you want to view. (T,S,C) by clicking 
    the 'select direction' button.
    The last step is sliding the slider on the middle. The original 
    image and the processed image will shown on the right.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

4. Code Running Instructions
    If you want to run the code from the beginning to the end, you 
    should READ THIS INSTRUCTION.
    The order of codes is as chapter two showing, I will note down 
    again here.
    4.1 First running 'all_data_output2txt.py', this is a Python file.
        Remember to change the path of the input data and the output 
        path is current code folder. This function will get a '3d.txt' file.
    4.2 Then come to the code 'read3D.m', comment all lines except line8 and 
        line9, this function will read previous '3d.txt' into a .mat form.
        Now, save the variable 'all_data'(it will show in workspace) into
        current folder, named 'all_data_2d.mat'
    4.3 Next, running the function named 'get_distinguished_data.m', this
        function will call another function called 'v3_fda.m', which will
        operates the fda in one slice. This function will automatically 
        save a file named 'distinguish_all.mat'
    4.4 Run function 'vis_fat_wall_no.m'. This function will save two 
        variables, which will be used in the next function.
    4.5 Finally goto code named 'fat_exp.m', uncomment line 46 to line 48 and
        line 62 to line 65(in order not showing so much figures in GUI, I have 
        to comment those lines out, if you need to check a certain slice of 
        image, you have to uncomment them), input 3 parameters' value.
        Then the processed image can be seen in the output figure.   
    Function 'fat_exp.m' will only allow us to view one output in one time,
    so I highly recommend the reader to view the output through GUI.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    The University of Manchester
                email: taiyue.guo@postgrad.manchester.ac.uk
                    supervisor: Dr. Fumie Costen
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
