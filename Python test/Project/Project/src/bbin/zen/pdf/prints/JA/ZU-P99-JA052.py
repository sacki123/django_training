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

from zen.pdf import constant
from zen.pdf.prints import RequestPrinter

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)


# ------------------------------------------------------------
# Function Section
# ------------------------------------------------------------

def execute(command):
    # ログ
    log.debug(command)

    try:
        # file_print = command.files.setup_files_print(constant.OUTPUT_PDF_FILE_DIRECTORY + "%s" % command.category)
        # command.files.print_files(file_print, False)
        print("execute function on chohyobango")
        obj = RequestPrinter("mongo_id")
        data = obj.get_history_request()
        for k, v in data.items():
            print("%s - %s" % (k, v))
    except:
        # 例外処理
        log.error(traceback.format_exc())

    # ログ.
    log.info(command)
    return 1
