#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Package

ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_6"
__date__    = "2017/04/07"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import logging

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
class EXSPY(object):
	"""
	EXSPY 定義値
	"""
	pass

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def test():
	"""
	test
	"""
	pass

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
class ExSpyProperty(property):
	"""
	継承元のプロパティまで処理するクラス
	"""

	def __init__(self, fget=None, fset=None, fdel=None, doc=None):
		"""
		Constructor
		@param fget	Get メソッド		default:None
		@param fset	Set メソッド		default:None
		@param fdel	Del メソッド		default:None
		@param doc	Doc メソッド		default:None
		"""
		super(ExSpyProperty, self).__init__(fget, fset, fdel, doc)

	def __get__(self, owner, value):
		"""
		?
		@param owner ?
		@param value ?
		@return ?
		"""
		return getattr(owner, self.fget.__name__)()

	def __set__(self, owner, value):
		"""
		?
		@param owner ?
		@param value ?
		@return ?
		"""
		return getattr(owner, self.fset.__name__)(value)

# ------------------------------------------------------------
class AbstractExSpy(EXSPY):
	"""
	ExSpy Abstract Class
	"""

	def getlogger_name(self):
		return self.__class__.__name__

	def getlogger(self):
		return logging.getLogger(self.loggername)

	# ----------------------------------------------------
	## Gettter Logger is Debug Enabled?
	# @return True is Enabled
	def is_log_debug(self):
		return self.logger.isEnabledFor(logging.DEBUG)

	# ----------------------------------------------------
	## Gettter Logger is Info Enabled?
	# @return True is Enabled
	def is_log_info(self):
		return self.logger.isEnabledFor(logging.INFO)

	# ----------------------------------------------------
	## Gettter Logger is Warn Enabled?
	# @return True is Enabled
	def is_log_warn(self):
		return self.logger.isEnabledFor(logging.WARN)

	# ----------------------------------------------------
	## Gettter Logger is Error Enabled?
	# @return True is Enabled
	def is_log_error(self):
		return self.logger.isEnabledFor(logging.ERROR)

	# ----------------------------------------------------
	## Gettter Logger is Critical Enabled?
	# @return True is Enabled
	def is_log_critical(self):
		return self.logger.isEnabledFor(logging.CRITICAL)

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		# Log
		if self.islogdebug:
			self.logger.debug(self.__class__)

	# ----------------------------------------------------
	## Property
	loggername = ExSpyProperty(getlogger_name, None, None)
	islogdebug = ExSpyProperty(is_log_debug, None, None)
	isloginfo = ExSpyProperty(is_log_info, None, None)
	islogwarn = ExSpyProperty(is_log_warn, None, None)
	islogerror = ExSpyProperty(is_log_error, None, None)
	islogcritical = ExSpyProperty(is_log_critical, None, None)
	logger = ExSpyProperty(getlogger, None, None)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
