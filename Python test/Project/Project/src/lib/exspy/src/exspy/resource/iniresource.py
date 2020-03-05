#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy INI Resource Module

 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_3"
__date__    = "2013/08/28"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import traceback

# ExSpy
from exspy.util import load_config
from exspy import ExSpyProperty
from exspy.resource import AbstractExSpyFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy INI File Resource Class
class ExSpyINIFileResourceBundle(AbstractExSpyFileResourceBundle):

	# ----------------------------------------------------
	## .
	# @return .
	def get_ext_name(self):
		return ".ini"

	# ----------------------------------------------------
	## .
	# @return .
	def get_resources(self):
		return self.FResources

	# ----------------------------------------------------
	## Constructor
	# basefilename or pythonfile is required.
	# @param pythonfile .
	# @param section .
	# @param l .
	def __init__(self, pythonfile, section="resource", osenv=False):
		super(ExSpyINIFileResourceBundle, self).__init__(pythonfile, section=section)
		self.FResources = {}

		self._osenv = osenv

	# ----------------------------------------------------
	## .
	# @param l .
	# @return .
	def get_resource(self, loc):
		lindex = self.get_locale_name(loc)

		try:
			result = self.get_resources()[lindex]
			if self.islogdebug:
				self.logger.debug(lindex)
				self.logger.debug(result)
			if result:
				return result
		except:
			if self.islogdebug:
				self.logger.debug(traceback.format_exc())

		return self.init_resource(loc)

	# ----------------------------------------------------
	## .
	# @param loc .
	# @return .
	def init_resource(self, loc):
		lindex = self.get_locale_name(loc)

		res = self.get_resource_name(lindex)

		config = load_config(res, osenv=self._osenv)
		self.resources[lindex] = config

		return config

	def items(self, section):
		res = self.get_resource(None)
		if res:
			return self.get_resource(None).items(section)
		return {}

	def get(self, section, name):
		return self.get_resource(None).get(section, name)

	# ----------------------------------------------------
	## .
	# @param key .
	# @param l .
	# @return .
	def get_resource_value(self, key, l, section):
		if self.islogdebug:
			self.logger.debug(key)
			self.logger.debug(l)
		res = self.get_resource(l)
#		print(section)
#		print(res.sections())
#		print(res.items(section))

		if res != None:
			try:
				s = section
				if s == None:
					s = self.section

				result = res.get(s, key)
				if self.islogdebug:
					self.logger.debug(result)
				return result
			except:
				if self.islogdebug:
					self.logger.debug(traceback.format_exc())
		return None

	# ----------------------------------------------------
	## Property
	resources = ExSpyProperty(get_resources, None, None)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
