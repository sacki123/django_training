#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
MySQL( パッケージ

※原則としてdjangoのデータベースの仕組みを使うがこちらは臨時用
"""

__title__   = 'DB パッケージ'
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
from logging import getLogger
import configparser
import MySQLdb

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def connect_db(config):
	"""
	MySQL接続
	"""

	# ログ
	log.debug((config,))

	try:
		db = MySQLdb.connect(
			user=config['db']['USER'],
			passwd=config['db']['PASSWORD'],
			host=config['db']['HOST'],
			db=config['db']['NAME'],
			charset="utf8mb4"
		)

		# 処理結果
		return db
	except:
		# 例外処理
		log.error(traceback.format_exc())

		raise

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
