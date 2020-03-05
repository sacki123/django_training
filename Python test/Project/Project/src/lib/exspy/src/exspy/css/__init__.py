#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy CSS Package

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

# ExSpy
from exspy import AbstractExSpy, EXSPY, ExSpyProperty
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

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
## ExSpy CSS Constant
class EXSPY_CSS(EXSPY):
	TYPE_HTML = "html"
	TYPE_ID = "id"
	TYPE_CLASS = "class"

	SECTION_ENV = "env"

# ------------------------------------------------------------
## ExSpy Abstract CSS Class
class AbstractExSpyCSS(AbstractExSpy, EXSPY_CSS):

	# ----------------------------------------------------
	## .
	# @return .
	def get_csss(self):
		return self.FCSSs

	# ----------------------------------------------------
	## .
	# @return .
	def get_envs(self):
		return self.FEnvs

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		super(AbstractExSpyCSS, self).__init__()

		# variable
		self.FCSSs = {}
		self.csss[EXSPY_CSS.TYPE_HTML] = {}
		self.csss[EXSPY_CSS.TYPE_CLASS] = {}
		self.csss[EXSPY_CSS.TYPE_ID] = {}
		self.FEnvs = {}
		self.envs[EXSPY_CSS.TYPE_HTML] = {}
		self.envs[EXSPY_CSS.TYPE_CLASS] = {}
		self.envs[EXSPY_CSS.TYPE_ID] = {}

	# ----------------------------------------------------
	## To CSS String
	# @param format .
	def to_csss(self, isformat=False):
		css =         self.to_css(self.csss[EXSPY_CSS.TYPE_HTML],   self.envs[EXSPY_CSS.TYPE_HTML], isformat)
		css = css + self.to_css(self.csss[EXSPY_CSS.TYPE_CLASS], self.envs[EXSPY_CSS.TYPE_CLASS], isformat)
		css = css + self.to_css(self.csss[EXSPY_CSS.TYPE_ID],        self.envs[EXSPY_CSS.TYPE_ID], isformat)
		return css

	# ----------------------------------------------------
	## To CSS String
	# @param css .
	# @param env .
	# @param format .
	def to_css(self, css, env, isformat=False):
		# for result
		s = ""

		# formatting
		if isformat:
			sf = u"%s\n%s {\n%s}\n"
			cf = u"%s  %s: %s;\n"
		else:
			sf = u"%s%s{%s}\n"
			cf = u"%s%s:%s;"

		# CSS
		for k,v in css.iteritems():
			if len(v):
				c = ""
				for d, b in v.iteritems():
					c = cf % (c, d, b)

				s = sf % (s, k, c)
		return s

	# ----------------------------------------------------
	## Property
	csss = ExSpyProperty(get_csss, None, None)
	envs = ExSpyProperty(get_envs, None, None)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
