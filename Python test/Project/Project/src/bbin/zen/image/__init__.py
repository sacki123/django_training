#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
イメージ パッケージ


"""

__title__   = 'イメージ パッケージ'
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

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def tiff2pdf(input_filename, output_filename):
	"""
	TIFF（マルチ）ファイルをPDFファイルへ変換
	"""
	# ログ
	log.debug((input_filename, output_filename))

	try:
		# TODO
		pass
	except:
		# 例外処理
		log.error(traceback.format_exc())

		# 例外続行
		raise

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
