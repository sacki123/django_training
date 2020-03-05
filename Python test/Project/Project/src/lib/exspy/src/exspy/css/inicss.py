#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy CSS INI File Module

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
import ConfigParser
import codecs
import traceback

# ExSpy
from exspy.css import AbstractExSpyCSS

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
## ExSpy INI File CSS Class
class ExSpyINICSS(AbstractExSpyCSS):

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		super(ExSpyINICSS, self).__init__()

	# ----------------------------------------------------
	## .
	# @param basepath .
	def load_inis(self, basepath):
		self.load_ini(basepath, self.TYPE_HTML)
		self.load_ini(basepath, self.TYPE_CLASS)
		self.load_ini(basepath, self.TYPE_ID)

	# ----------------------------------------------------
	## .
	# @param basepath .
	# @param type .
	def load_ini(self, basepath, atype):
		env = self.envs[atype]
		css = self.csss[atype]

		ininame = basepath % (atype)
		ini = ConfigParser.SafeConfigParser()

		# utf-8
		try:
			ini.readfp(codecs.open(ininame, "r", "utf8"))
		except:
			pass

		for section in ini.sections():
			s = ini.options(section)

			if s == self.SECTION_ENV:
				value = env
			else:
				if css.has_key(section):
					value = css[section]
				else:
					value = {}
					css[section] = value
			for key in s:
				try:
					value[key] = ini.get(section, key)
				except:
					print(traceback.format_exc())
					print(section + ">" + key)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
