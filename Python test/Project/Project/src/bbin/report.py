#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
帳票コマンド プログラム


"""

__title__ = '帳票コマンドラインツール'
__author__ = "ExpertSoftware Inc."
__status__ = "develop"
__version__ = "0.0.0_0"
__date__ = "2018/07/27"
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

# zen
from zen.pdf.make import MakeCommand
from zen.pdf.export import ExportCommand
from zen.pdf.prints import PrintsCommand
from zen.pdf.run import RunCommand
from zen.pdf import constant


# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# Read .ini file
config = configparser.ConfigParser()

# ------------------------------------------------------------
# Function Section
# ------------------------------------------------------------
def ini_get(ini, section, name, default):
    try:
        return ini.get(section, name)
    except:
        return default


# ------------------------------------------------------------
# Class Section
# ------------------------------------------------------------

def print_help():
    """
    ヘルプ表示関数
    """
    
    print(u'''
■ プログラム情報：
%s %s
''' % (sys.argv[0], __desc__))
    
    print(u'■ コマンド')
    print(u'')
    
    print(u'■ 引数の説明：')
    print(u'□ 印刷(make&print)')
    print(u'python %s [コンフィグファイル] run  [機能番号]' % sys.argv[0])
    print(u'')
    print(u'□ 印刷実行（PDF生成無し）')
    print(u'python %s [コンフィグファイル] print  [機能番号]' % sys.argv[0])
    print(u'')
    print(u'□ PDF作成しストレージ保存')
    print(u'python %s [コンフィグファイル] make   [機能番号]' % sys.argv[0])
    print(u'')
    print(u'□ 保存PDFを出力')
    print(u'python %s [コンフィグファイル] export [機能番号]' % sys.argv[0])


# ------------------------------------------------------------
# Main Section
# ------------------------------------------------------------


if __name__ == '__main__':
    # 初期化
    exit_code = 0
    
    # ログ
    log.info(__desc__)
    
    try:
        # 引数処理
        log.debug(sys.argv)
        input_default_file = sys.argv[1]
        DIR_NAME = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
        config_file = DIR_NAME + input_default_file
        os.path.exists(config_file)
        config.read(config_file)
        command = sys.argv[2][0].upper() + sys.argv[2][1:]
        unit = None
        if command == "Prints":
            # global unit
            unit = dict()
            unit["sub_command"] = sys.argv[3]
            unit["ip_address"] = sys.argv[4]
            unit["mongo_id"] = sys.argv[5]
        elif command == "Make":
            unit = sys.argv[3]
        # メイン処理
        e = '''c = %sCommand(config, unit, "%s")
exit_code = c.execute()''' % (command, command)
        log.debug(e)
        exec(e)
    except:
        # 例外処理
        log.error(traceback.format_exc())
    
    # 処理出来なかった場合ヘルプ表示
    if exit_code != 1:
        print_help()
    # else:
    #     constant.print_error(constant.error_list)
    # ログ
    log.info(exit_code)
# ------------------------------------------------------------
