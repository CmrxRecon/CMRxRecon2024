# -*- coding: utf-8 -*-
"""
@Time ： 2024/4/19 09:46
@Auth ： keevinzha
@File ：cal_data_size.py
@IDE ：PyCharm
"""

import os
import scipy.io as scio
import mat73
import numpy as np

def main(txt_dir):
    data_dir = '/Users/kevinguo/DataSets/ChallengeData/MultiCoil'
    data_type_list = ['BlackBlood', 'Cine', 'Mapping', 'Flow2d', 'Aorta', 'Tagging']
    data_set_list = ['TrainingSet', 'ValidationSet']
    with open(txt_dir, 'w') as f:
        for data_type in data_type_list:
            print('--------',data_type, file=f)
            data_type_path = os.path.join(data_dir, data_type)
            for data_set in data_set_list:
                print('------', data_set, file=f)
                data_set_path_list = []
                if data_set == 'TrainingSet':
                    data_set_path = os.path.join(data_type_path, data_set, 'FullSample')
                    data_set_path_list.append(data_set_path)
                else:
                    data_set_path = os.path.join(data_type_path, data_set, 'UnderSample_Task1')
                    data_set_path_list.append(data_set_path)
                    data_set_path = os.path.join(data_type_path, data_set, 'UnderSample_Task2')
                    data_set_path_list.append(data_set_path)
                for data_set_path in data_set_path_list:
                    if os.path.exists(data_set_path):
                        print('----', os.path.basename(data_set_path), file=f)
                        for root, dirs, files in os.walk(data_set_path):
                            for dir in dirs:
                                if dir[0] == 'P' and len(dir) == 4:
                                    print('--', dir, file=f)
                                    for kspace_root, kspace_dirs, kspace_files in os.walk(os.path.join(data_set_path, dir)):
                                        for kspace_file in kspace_files:
                                            if kspace_file[-3:] == 'mat':
                                                try:
                                                    kspace_data = scio.loadmat(os.path.join(kspace_root, kspace_file))
                                                except:
                                                    kspace_data = mat73.loadmat(os.path.join(kspace_root, kspace_file))
                                                kspace_data = kspace_data[list(kspace_data.keys())[0]]
                                                print(kspace_file, kspace_data.shape, file=f)


if __name__ == '__main__':
    txt_dir = './data_size.txt'
    main(txt_dir)




