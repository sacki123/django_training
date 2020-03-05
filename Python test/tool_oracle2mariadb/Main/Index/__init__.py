#!/usr/bin/python
# -*- coding: utf-8 -*-

from Main import AbstractOracle2Mariadb
from Main.Table import Table
from Main.Comment import Comment



class Index(AbstractOracle2Mariadb):
    def __init__(self, file_name):
        # self.index = index
        pass

    def creat_index(self):
        pass

    def creat_unique_index(self):
        pass

# class SubClass(Table, Index, Comment):
#     def __init__(self):
#         pass