#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Main Package

 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_0"
__date__    = "2013/03/31"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
from optparse import OptionParser
import sys
import logging
import traceback

# ExSpy
from exspy import AbstractExSpy, EXSPY
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
## Resource Variable
RESOURCE = ExSpyINIFileResourceBundle(__file__)

# ------------------------------------------------------------
## ExSpy Main Constant
class EXSPY_MAIN(EXSPY):
	pass

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Get resource for Multi Locale
# @param key Resource key
# @param default Default value
# @param locale Locale
# @param resource Target Resource bundle
def _(key, default, locale=None, resource=RESOURCE):
	try:
		return resource.get_string(key, default, locale)
	except:
		return default

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy Abstract Param Class
class AbstractExSpyParam(object):

	# ----------------------------------------------------
	## .
	# @return .
	def getOpt(self):
		return None

	# ----------------------------------------------------
	## .
	# @return .
	def getLongOpt(self):
		return None

	# ----------------------------------------------------
	## .
	# @return .
	def getMessage(self):
		return None

	# ----------------------------------------------------
	## .
	# @return .
	def isRequired(self):
		return False

	# ----------------------------------------------------
	## .
	# @return .
	def isValue(self):
		return False

	# ----------------------------------------------------
	## .
	# @return .
	def getDefault(self):
		return None

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		# super
		super(AbstractExSpyParam, self).__init__()

		# variable
		self.FValues = None

# ------------------------------------------------------------
## ExSpy Param Class
class ExSpyParam(AbstractExSpyParam):

	# ----------------------------------------------------
	## .
	# @return .
	def getOpt(self):
		return self.FOpt

	# ----------------------------------------------------
	## .
	# @return .
	def getLongOpt(self):
		return self.FLongOpt

	# ----------------------------------------------------
	## .
	# @return .
	def getMessage(self):
		return self.FMessage

	# ----------------------------------------------------
	## .
	# @return .
	def getDefault(self):
		return self.FDefault

	# ----------------------------------------------------
	## .
	# @return .
	def isRequired(self):
		return self.FRequired

	# ----------------------------------------------------
	## .
	# @return .
	def isValue(self):
		return self.FValue

	# ----------------------------------------------------
	## Constructor
	# @param opt .
	# @param longopt .
	# @param message .
	# @param required .
	# @param value .
	# @param default .
	def __init__(self, opt, longopt, message, required, value, default=None):
		# super
		super(ExSpyParam, self).__init__()

		# variable
		self.FOpt = opt
		self.FLongOpt = longopt
		self.FMessage = message
		self.FRequired = required
		self.FValue = value
		self.FDefault = default

# ------------------------------------------------------------
## ExSpy Resource Param Class
class ExSpyResourceParam(ExSpyParam):

	# ----------------------------------------------------
	## Constructor
	# @param resource .
	# @param prefix .
	def __init__(self, resource, prefix):
		# super
		opt = _(prefix + "_opt", None, None, resource)
		longopt = _(prefix + "_longopt", None, None, resource)
		message = _(prefix + "_message", None, None, resource)
		required = _(prefix + "_required", None, None, resource)
		value = _(prefix + "_value", None, None, resource)
		default = _(prefix + "_default", None, None, resource)

		# variable
		super(ExSpyResourceParam, self).__init__(opt, longopt, message, required, value, default)

# ------------------------------------------------------------
## ExSpy Abstract Main Class
class AbstractExSpyMain(AbstractExSpy, EXSPY_MAIN):

	# ----------------------------------------------------
	## .
	# @return .
	def getParams(self):
		return self.FParams

	# ----------------------------------------------------
	## .
	# @return .
	def getOptions(self):
		return self.FOptions

	# ----------------------------------------------------
	## .
	# @return .
	def getApplicationVersion(self):
		return __version__

	# ----------------------------------------------------
	## .
	# @return .
	def getApplicationTitle(self):
		return self.__class__.__name__

	# ----------------------------------------------------
	## .
	# @return .
	def getApplicationCopyright(self):
		return __license__

	# ----------------------------------------------------
	## .
	# @return .
	def getApplicationDate(self):
		return __date__

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		# 継承元実行
		super(AbstractExSpyMain, self).__init__()

		# 引数
		self.FParams = {}

	# ----------------------------------------------------
	## .
	def init(self):
		return 0

	# ----------------------------------------------------
	## .
	def destory(self):
		pass

	# ----------------------------------------------------
	## .
	# @return 0 is continue.
	def params(self):
		parser = OptionParser()
		for k in self.getParams().keys():
			p = self.getParams()[k]

			opt = None
			longopt = None
			action = "store"
			if not p.isValue():
				if p.getDefault():
					action = "store_false"
				else:
					action = "store_true"
			dest = k

			if p.getOpt:
				opt = "-%s" % p.getOpt()
			if p.getLongOpt():
				longopt = "--%s" % p.getLongOpt()

			parser.add_option(opt, longopt, help=p.getMessage(), action=action, dest=dest)

		# params
		(options, args) = parser.parse_args()
		self.FOptions = options
		return 0

	# ----------------------------------------------------
	## Perform
	# @return 0 is continue.
	def perform(self):
		# 処理結果
		return 0

	# ----------------------------------------------------
	## Prepare
	# @return 0 is continue.
	def prepare(self):
		# 処理結果
		return 0

	# ----------------------------------------------------
	## .
	# @param message .
	# @param level .
	def log(self, message, level=logging.NOTSET):
		self.logger.log(level, message)
		print(message)

	# ----------------------------------------------------
	## .
	# @param verbose .
	def version(self, verbose=False):
		self.log(u"%s Ver.%s" % (self.getApplicationTitle(), self.getApplicationVersion()))
		if verbose:
			self.log(u"  %s" % (self.getApplicationCopyright()))
			self.log(u"  %s" % (self.getApplicationDate()))

	# ----------------------------------------------------
	## .
	# @param verbose .
	def help(self, verbose=False):
		self.version(True)

		self.log(u"")

		for p in self.getParams().values():
			if p.getLongOpt() == None:
				self.log("  %s" % p)
		for p in self.getParams().values():
			if p.getOpt() and p.getLongOpt():
				self.log("  %s" % p)
		for p in self.getParams().values():
			if p.getOpt() == None:
				self.log("  %s" % p)

	# ----------------------------------------------------
	## .
	# @return .
	def __call__(self):
		# exit code
		code = 0

		try:
			# execute
			code = self.execute()
		finally:
			# destory
			self.destory()

		if code != 0:
			self.help()

		# exit code
		return code

	# ----------------------------------------------------
	## Execute
	# @return exit code.
	def execute(self):
		try:
			# init
			code = self.init()
			if code != 0:
				return code

			# params
			code = self.params()
			if code != 0:
				return code

			# prepare
			code = self.prepare()
			if code != 0:
				return code

			# perform
			return self.perform()
		finally:
			# destory
			self.destory()

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
