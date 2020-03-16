#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Exception Package

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
import traceback

# ExSpy
from exspy import ExSpyProperty
from exspy import AbstractExSpy, EXSPY
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
## Resource Variable
RESOURCE = ExSpyINIFileResourceBundle(__file__)

# ------------------------------------------------------------
## ExSpy Exception Constant
class EXSPY_EXCEPTION(EXSPY):
	RESOURCE_KEY = "%s_%s"
	RESOURCE_MESSAGE = "message"

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Get value from resource for Multi Locale
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
## ExSpy Abstract Exception Class
class AbstractExSpyException(Exception, AbstractExSpy, EXSPY_EXCEPTION):

	# ----------------------------------------------------
	## .
	# @return .
	def get_message(self):
		return self.__class__.__name__

	# ----------------------------------------------------
	## .
	# @return .
	def __str__(self):
		return self.message

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		# super
		super(AbstractExSpyException, self).__init__()

	# ----------------------------------------------------
	## Property
	message = ExSpyProperty(get_message, None, None)

# ------------------------------------------------------------
## ExSpy Abstract Resource Exception Class
class AbstractExSpyResourceException(AbstractExSpyException):

	# ----------------------------------------------------
	## .
	# @return .
	def get_params(self):
		return self.FParams

	# ----------------------------------------------------
	## .
	# @return .
	def get_resource(self):
		return RESOURCE

	# ----------------------------------------------------
	## Constructor
	# @param params .
	def __init__(self, params):
		# super
		super(AbstractExSpyException, self).__init__()

		# variable
		self.FParams = params

	# ----------------------------------------------------
	## .
	# @return .
	def get_format_message(self):
		res = _(self.formatmessagekey, self.__class__.__name__, None, self.resource)
		if self.islogdebug:
			self.logger.debug(self.resource.basepathname)
			self.logger.debug(res)
		return res

	# ----------------------------------------------------
	## .
	# @return .
	def get_format_message_key(self):
		key = self.RESOURCE_KEY % (self.__class__.__name__, self.RESOURCE_MESSAGE)
		if self.islogdebug:
			self.logger.debug(key)
		return key

	# ----------------------------------------------------
	## .
	# @return .
	def get_message(self):
		try:
			formattext = self.formatmessage
			if self.islogdebug:
				self.logger.debug(formattext)
			if self.params:
				try:
					if self.islogdebug:
						self.logger.debug(self.params)
					return formattext % self.params
				except:
					if self.islogdebug:
						self.logger.debug(traceback.format_exc())
			return formattext
		except:
			if self.islogdebug:
				self.logger.debug(traceback.format_exc())
			return super(AbstractExSpyResourceException, self).get_message()

	# ----------------------------------------------------
	## Property
	formatmessage = ExSpyProperty(get_format_message, None, None)
	formatmessagekey = ExSpyProperty(get_format_message_key, None, None)
	params = ExSpyProperty(get_params, None, None)

# ------------------------------------------------------------
## ExSpy Abstract Resource List Exception Class
class AbstractExSpyExceptions(AbstractExSpyResourceException):

	# ----------------------------------------------------
	## .
	# @return .
	def get_exceptions(self):
		return self.FExceptions

	# ----------------------------------------------------
	## Constructor
	# @param exceptions .
	def __init__(self, exceptions=[]):
		# super
		super(AbstractExSpyExceptions, self).__init__()

		# variable
		self.FExceptions = exceptions

	# ----------------------------------------------------
	## Property
	exceptions = ExSpyProperty(get_exceptions, None, None)

# ------------------------------------------------------------
## ExSpy Resource List Exception Class
class ExSpyExceptions(AbstractExSpyExceptions):

	# ----------------------------------------------------
	## Constructor
	# @param exceptions .
	def __init__(self, exceptions=[]):
		# super
		super(ExSpyExceptions, self).__init__(exceptions)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
