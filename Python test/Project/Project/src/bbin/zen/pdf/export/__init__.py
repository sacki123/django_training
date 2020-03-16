#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
帳票(PDF) パッケージ


"""

__title__   = '帳票(PDF) パッケージ'
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

# zen
from zen.pdf import AbstractCommand

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
class ExportCommand(AbstractCommand):
	"""
	PDFエクスポートクラス
	"""

	def __init__(self, config, unit):
		"""
		コンストラクタ
		"""
		super().__init__(config, unit)

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
		return 0

# ------------------------------------------------------------
