# -*- coding: utf-8 -*-
"""
@Time ： 2024/4/23 12:32
@Auth ： keevinzha
@File ：data_check.py
@IDE ：PyCharm
"""

import os

def check_data(json_file_path, data_path):
    """
    Check if the data exists
    :param json_file_path: json file path
    :param data_path: should be the parent path of the "MultiCoil" folder
    :return: file not exists will be written to data_not_exists.txt
    """
    with open(json_file_path, 'r') as f:
        data_list = f.readlines()
    if os.path.exists('./data_not_exists.txt'):
        os.remove('./data_not_exists.txt')
    for data in data_list:
        data = data.strip()
        data = data.replace('\"', '')
        data = os.path.join(data_path, data)
        if not os.path.exists(data):
            print(data, 'not exists')

            with open('./data_not_exists.txt', 'a') as f:
                f.write(data)
                f.write('\n')

if __name__ == '__main__':
    json_file_path = './data.json'
    data_path = '/Users/kevinguo/DataSets/ChallengeData/'
    check_data(json_file_path, data_path)