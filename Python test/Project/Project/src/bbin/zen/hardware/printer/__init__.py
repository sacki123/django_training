#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
プリンター パッケージ


"""

__title__   = 'プリンター パッケージ'
__author__  = "ExpertSoftware Inc."
__status__  = "develop"
__version__ = "0.0.0_0"
__date__    = "2018/07/27"
__license__ = ''
__desc__    = '%s Ver%s (%s)' % (__title__, __version__, __date__)

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import os
import subprocess
import configparser
from logging import getLogger

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

ACROBAT_PATH = 'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe'

CONFIG_PRINTER_NAME = 'name'
CONFIG_PRINTER_DRIVER = 'driver'
CONFIG_PRINTER_PORT = 'port'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def load_printer_config(filename):
	"""
	コンフィグファイル読込
	"""
	# ログ
	log.debug((filename,))
	config = configparser.ConfigParser()
	config.read(filename)
	return config

def print_pdf(config, printer_name, filename):
	"""
	PDF印刷(Windows環境下では原則としてAcrobatReaderDCを使用)
	"""
	# ログ
	log.debug((printer_name, filename,))

	# 初期化
	name=config[printer_name][CONFIG_PRINTER_NAME]
	driver=config[printer_name][CONFIG_PRINTER_DRIVER]
	port=config[printer_name][CONFIG_PRINTER_PORT]
	log.debug((name, driver, port, ))

	if os.path.isfile(ACROBAT_PATH):
		print(ACROBAT_PATH)
		a = subprocess.Popen([
ACROBAT_PATH,
'/n',
'/s',
'/t',
filename,
name,
driver,
port,
])
		# TODO タイムアウトやエラー処理
		a.wait(timeout=10)

	return 0

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
