#!/usr/bin/python
# -*- coding: utf-8 -*-

from Main import AbstractOracle2Mariadb
# from Main.Index import Index
# from Main.Comment import Comment



class Table(AbstractOracle2Mariadb):
    def __init__(self, file_name):
        # self.table_name = table_name
        super().__init__(file_name)

    def create_table(self, table_name):
        # sql = "DROP TABLE IF EXISTS  %s;" % self.table_name
        pass

# class SubClass(Table, Index, Comment):
#     def __init__(self):
#         pass