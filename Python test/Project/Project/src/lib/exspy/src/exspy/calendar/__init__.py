#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Calendar Package

 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_4"
__date__    = "2013/09/01"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import locale

# ExSpy
from exspy import EXSPY
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
## Resource Variable
RESOURCE = ExSpyINIFileResourceBundle(__file__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## .
# @param date .
# @param l locale
# @return .
def get_holiday_from_date(date, l=locale.getlocale()):
	return get_holiday(date.year, date.month, date.day)

# ------------------------------------------------------------
## .
# @param year .
# @param month .
# @param day .
# @param l locale
# @return .
def get_holiday(year, month, day, l=locale.getlocale()):
	try:
		key = u"HOLIDAY_%04d%02d%02d" % (year, month, day)

		return RESOURCE.get_string(key, None, l)
	except:
		return None

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy Calendar Constant
class EXSPY_CALENDAR(EXSPY):
	pass

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
