#!/usr/bin/python
# -*- coding: utf-8 -*-

import os



flat = "/"
str_variable = "\""
table = "CREATE TABLE"
index = "INDEX"
comment = "COMMENT"


def get_file_path_input(file_name):
    # Current directory Path
    DIR_NAME = os.path.dirname(__file__)
    path_file = os.path.join(DIR_NAME, '../input/', file_name)
    return path_file

def get_file_path_output(file_name):
    # Current directory Path
    DIR_NAME = os.path.dirname(__file__)
    path_file = os.path.join(DIR_NAME, '../output/', file_name)
    return path_file



if __name__ == '__main__':
    pass
