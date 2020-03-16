#!/usr/bin/python
# -*- coding: utf-8 -*-

import os

# constant
from Main import constant
# from Main.Table import Table
# from Main.Comment import Comment
# from Main.Index import Index
# from Main.Table import Table


class AbstractOracle2Mariadb(object):
    def __init__(self, file_name):
        self.file_name = file_name
        self.partFile_input = constant.get_file_path_input(self.file_name)
        self.partFile_output = constant.get_file_path_output(self.file_name)
        # self.flat = "/"
        # self.str_variable = "\""
        # self.table = "CREATE TABLE"
        # self.index = "INDEX"
        # self.comment = "COMMENT"
        self.file = self.read_file_oracle()

    def read_file_oracle(self):
        # Open and read the file as a single buffer
        fd = open(self.partFile_input, 'r', encoding="utf-8_sig")
        sqlFile = fd.read()
        lit = sqlFile.split(constant.flat)
        # for line in lit:
        #     if constant.table in line:
        #         # table = SubClass(line)
        #         lit1 = line.split(" ")
        #         name_table = lit1[2][:-3].replace(constant.str_variable,'')
        #         # table = Table(name_table)
        #         print(name_table)
        #     elif constant.index in line:
        #         lit1 = line.split(" ")
        #         print(lit1)
        #     elif constant.comment in line:
        #         lit1 = line.split(" ")
        #         print(lit1)
        return lit
        # print(len(lit))
        # sqlFile = sqlFile.replace("NVARCHAR2", "VARCHAR").replace("/", ";").replace("BINARY_DOUBLE","DOUBLE").replace("VISIBLE"," ").replace("CLOB","TEXT").replace('\"','')
        # f = open(self.partFile_output, "w+",encoding="utf-8_sig")
        # f.write(sqlFile)
        # fd.close()
        # return sqlFile

    def read_next_line(self):
        #次の行の読み取り
        pass


