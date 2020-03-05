#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Resource Package

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
import locale
import os.path
import re
import traceback
from abc import ABCMeta, abstractmethod

# ExSpy
from exspy import ExSpyProperty
from exspy import EXSPY, AbstractExSpy

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy Resource Constant
class EXSPY_RESOURCEBUNDLE(EXSPY):
	pass

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy Absstract Resource Class
class AbstractExSpyResourceBundle(AbstractExSpy, EXSPY_RESOURCEBUNDLE):
	__metaclass__ = ABCMeta

	# ----------------------------------------------------
	## .
	# @return .
	def get_section(self):
		return self.FSection
	# ----------------------------------------------------
	## .
	# @return .
	def set_section(self, value):
		self.FSection = value


	# ----------------------------------------------------
	## Constructor
	def __init__(self, section=None):
		# super
		super(AbstractExSpyResourceBundle, self).__init__()
		self.FSection = section

	# ----------------------------------------------------
	## .
	# @param key .
	# @param default .
	# @return .
	def get_string(self, key, default=None, section=None):
		return self.get_value(key, default, section)

	# ----------------------------------------------------
	## .
	# @param key .
	# @param default .
	# @return .
	def get_value(self, key, default, section=None):
		return default

	# ----------------------------------------------------
	## Property
	section = ExSpyProperty(get_section, set_section, None)

# ------------------------------------------------------------
## ExSpy Absstract Locale Resource Class
class AbstractExSpyLocaleResourceBundle(AbstractExSpyResourceBundle):
	__metaclass__ = ABCMeta

	# ----------------------------------------------------
	## Constructor
	# @param l .
	def __init__(self, section=None):
		# super
		super(AbstractExSpyLocaleResourceBundle, self).__init__(section)

	# ----------------------------------------------------
	## .
	# @param key .
	# @param default .
	# @param l .
	# @return .
	def get_string(self, key, default=None, l=locale.getlocale(), section=None):
		s = section
		if (s == None):
			s = self.section
		return self.get_value(key, default, l, s)

	# ----------------------------------------------------
	## .
	# @param key .
	# @param default .
	# @param l .
	# @return .
	# @abstractmethod
	def get_value(self, key, default, l, section=None):
		pass

# ------------------------------------------------------------
## ExSpy Absstract File Resource Class
class AbstractExSpyFileResourceBundle(AbstractExSpyLocaleResourceBundle):
	__metaclass__ = ABCMeta

	# ----------------------------------------------------
	## .
	# @return .
	def get_basepath_name(self):
		return self.FBasePathName

	# ----------------------------------------------------
	## .
	# @return .
	def get_ext_name(self):
		return ""

	# ----------------------------------------------------
	## Constructor
	# basefilename or pythonfile is required.
	# @param pythonfile .
	# @param basepathname .
	# @param l .
	def __init__(self, pythonfile=None, basepathname=None, section=None):
		super(AbstractExSpyFileResourceBundle, self).__init__(section)

		# .
		if basepathname== None:
			b = re.sub(r'\.py.$', "", pythonfile)
			b = re.sub(r'\.py$', "", b)
			b = re.sub(r'\.ini$', "", b)
			b = re.sub(r'\.yaml$', "", b)
			b = re.sub(r'\.xml$', "", b)
			self.FBasePathName = b
		else:
			self.FBasePathName = basepathname

	# ----------------------------------------------------
	## .
	# @param key .
	# @param l .
	# @return .
	def get_resource_value(self, key, l, section=None):
		return None

	# ----------------------------------------------------
	## .
	# @param key .
	# @param default .
	# @param l .
	# @return .
	def get_value(self, key, default, l, section=None):
		# .
		if (l != None):
			res = self.get_resource_value(key, l, section)
			if (res != None):
				return res

		# .
		res = self.get_resource_value(key, None, section)
		if (res != None):
			return res

		# .
		return default

	def get_locale_name(self, l):
		if l != None:
			if isinstance(l, str):
				return l
			elif isinstance(l, unicode):
				return l
			else:
				try:
					return l[0]
				except:
					pass

		return None


	# ----------------------------------------------------
	## .
	# @param lname .
	# @return .
	def get_resource_name(self, lname):
		ln = ""

		if lname != None:
			if lname == "Japanese_Japan":
				ln = "_" + "ja_JP"
			elif lname == "English_United States":
				ln = "_" + "en_US"
			else:
				ln = "_" + lname

		return u"%s%s%s" % (self.basepathname, ln, self.extname)

	# ----------------------------------------------------
	## .
	# @param l .
	# @return .
	def get_resource(self, l):
		pass

	# ----------------------------------------------------
	## .
	# @param l .
	# @return .
	def init_resource(self, l):
		pass

	# ----------------------------------------------------
	## Property
	basepathname = ExSpyProperty(get_basepath_name, None, None)
	extname = ExSpyProperty(get_ext_name, None, None)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
