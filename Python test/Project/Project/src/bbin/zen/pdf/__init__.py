#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
帳票(PDF) パッケージ


"""

__title__ = '帳票(PDF) パッケージ'
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
import traceback
from logging import getLogger
from importlib import import_module

# zen
from zen.db.mongo import ZenMongoDB

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)


# ------------------------------------------------------------
# Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
# Class Section
# ------------------------------------------------------------


class AbstractCommand(object):
    """
    基底クラス
    """

    def __init__(self, config, unit, command=None):
        """
        コンストラクタ
        """
        # ログ
        log.debug(self)
        self.command = command
        self.config = config
        self.unit = unit

    def prepare(self):
        """
        処理前準備
        実行ユニットの初期化を事前に行う
        @return 終了コード
        """
        exit_code = -1
        try:
            if self.command == "Make":
                if "-" in self.unit:
                    # Handle unit args[3]
                    lst_unit_str = self.unit.split("-")
                    self.activity_code = lst_unit_str[1]
                    self.category = lst_unit_str[2][:2]
                    self.kinoubango = lst_unit_str[2][2:]
                    self.func = import_module(
                        "%s.%s.%s.%s" % (self.__module__, self.activity_code, self.category, self.unit))
                    # イベント処理実行
                    exit_code = self.onPrepare()
                else:
                    data = ZenMongoDB()
                    list_unit = data.find_report_number(self.unit, data.collection)
                    for i in range(len(list_unit)):
                        lst_unit_str = list_unit[i].split("-")
                        self.activity_code = lst_unit_str[1]
                        self.category = lst_unit_str[2][:2]
                        self.kinoubango = lst_unit_str[2][2:]
                        # 関数取得
                        self.func = import_module(
                            "%s.%s.%s.%s" % (self.__module__, self.activity_code, self.category, list_unit[i]))
                        # イベント処理実行
                        exit_code = self.onPrepare()
                        if i < len(list_unit) - 1:
                            self.onExecute()
            elif self.command == "Prints":
                self.sub_command = self.unit.get("sub_command")
                self.ip_address = self.unit.get("ip_address")
                self.mongo_id = self.unit.get("mongo_id")
                # # start TODO: temp value to wait next code order
                # self.func = import_module(
                #         "%s.%s" % (self.__module__, "JA.ZU-P99-JA052"))
                # # end  TODO: temp value to wait next code order
                # イベント処理実行
                exit_code = self.onPrepare()
            else:
                exit_code = 0
        except:
            # 例外処理
            log.error(traceback.format_exc())
        # ログ
        log.debug(exit_code)
        return exit_code

    def execute(self):
        """
        処理実行

        @return 終了コード
        """
        exit_code = self.prepare()
        if exit_code > 0:
            return self.onExecute()
        return exit_code

    def onExecute(self):
        """
        処理実行

        @return 終了コード
        """
        return self.func.execute(self)

    def onPrepare(self):
        """
        処理前準備

        @return 終了コード
        """
        return 1

# ------------------------------------------------------------
