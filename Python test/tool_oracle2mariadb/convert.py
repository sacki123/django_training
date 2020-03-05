#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
帳票コマンド プログラム


"""

__title__ = '帳票コマンドラインツール'
__author__ = "ExpertSoftware Inc."
__status__ = "develop"
__version__ = "0.0.0_0"
__date__ = "2019/02/20"
__license__ = ''
__desc__ = '%s Ver%s (%s)' % (__title__, __version__, __date__)
# ------------------------------------------------------------
# Import Section
# ------------------------------------------------------------
# Python
import os
import sys

import traceback
import configparser
from logging import getLogger

from Main import AbstractOracle2Mariadb
from Main.Comment import Comment
from Main.Table import Table
from Main.Index import Index
# from Main import SubClass

log = getLogger(__name__)

class SubClass(Table, Index, Comment):
    def __init__(self, file_name):
        super().__init__(file_name)
        # self.table = AbstractOracle2Mariadb()

if __name__ == '__main__':
    # 初期化
    exit_code = 0
    
    # ログ
    log.info(__desc__)
    
    try:
        # 引数処理
        log.debug(sys.argv)
        input_name_file = sys.argv[1]
        # メイン処理
        # e = '''c = AbstractOracle2Mariadb(%s)''' % (input_name_file)
        # log.debug(e)
        # exec(e)
        e = SubClass(input_name_file)
    except:
        # 例外処理
        log.error(traceback.format_exc())