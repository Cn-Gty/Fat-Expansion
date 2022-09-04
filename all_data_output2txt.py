import myfunc
import matplotlib.pyplot as plt
import numpy as np

# np.set_printoptions(precision=2)
# np.set_printoptions(threshold=np.inf)
# np.set_printoptions(suppress=True)

# threeD_data=np.zeros((2,490,265),dtype=np.int)
output_path = 'C:\\Users\\LENOVO\\Desktop\\dissertation\\code\\'
data = []
nd = []
with open(output_path+'3d.txt','w') as f1:       # create a new blank txt file
    f1.write('')
for i in range(500):
    file_num_string = str(400+i)
    file_name = 'v1_00'+file_num_string+'.pgm'
    file_path = 'C:\\Users\\LENOVO\\Desktop\\dissertation\\week1\\files in web\\reuben\\reuben\\Reuben_Project_Code\\'
    file_full_path = file_path+file_name
    data = np.matrix(myfunc.get_img_data(file_full_path,490,265),dtype=int)
    # threeD_data[i,:,:] = data  #   get a 3d matrix
    with open(output_path+'3d.txt','a') as f:       # add new data to this file
        np.savetxt(f,data,fmt='%i')      # store a 2d file 
'''
    Now the file 3d.txt shows all the data of the entire database. 
    Note that need to change the number of loops.
    If we run reuben's data, the txt file have 245000 * 265 values, where 245000 = 490 * 500.
'''