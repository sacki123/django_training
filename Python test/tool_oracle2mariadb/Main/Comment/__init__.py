#!/usr/bin/python
# -*- coding: utf-8 -*-
import os
import sys

# sys.path.append(os.path.abspath("."))
from Main import AbstractOracle2Mariadb
# from Main.Table import Table
# from Main.Index import Index


class Comment(AbstractOracle2Mariadb):
    def __init__(self, file_name):
        pass
    def comment_on_table(self):
        pass
    def comment_on_column(self):
        pass


# class SubClass(Table, Index, Comment):
#     def __init__(self):
#         pass