#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Date/Time Package

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
import datetime, time
import traceback
import sys
if __name__ == '__main__':
	sys.path.append(".")

# ExSpy
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
## Resource Variable
RESOURCE = ExSpyINIFileResourceBundle(__file__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def to_string(formattext, value):
	if (formattext == None) or (value == None):
		return None

	values = {
			"year": 0,
			"month": 0,
			"day": 0,
			"hour": 0,
			"minute": 0,
			"second": 0,
			"microsecond": 0,
		}
	try:
		values["year"] = value.year
		values["month"] = value.month
		values["day"] = value.day
	except:
		pass
	try:
		values["hour"] = value.hour
		values["minute"] = value.minute
		values["second"] = value.second
		values["microsecond"] = value.microsecond
	except:
		pass

	return formattext % values

def to_string_resource(value, key, locale=locale.getdefaultlocale(), resource=RESOURCE):
	formattext = resource.get_string(key, None, locale)
	return to_string(formattext, value)

def to_string_date_value(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return to_string_resource(value, "DATE_VALUE_FORMAT", locale, resource)

def to_string_date_display(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return to_string_resource(value, "DATE_DISPLAY_FORMAT", locale, resource)

def to_string_datetime_value(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return to_string_resource(value, "DATETIME_VALUE_FORMAT", locale, resource)

def to_string_datetime_display(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return to_string_resource(value, "DATETIME_DISPLAY_FORMAT", locale, resource)

def to_string_time_value(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return to_string_resource(value, "TIME_VALUE_FORMAT", locale, resource)

def to_string_time_display(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return to_string_resource(value, "TIME_DISPLAY_FORMAT", locale, resource)

def structtime_datetime(value):
	if value:
		return datetime.datetime(*value[:6])
	return None

def to_structtime_resource(value, key, locale=locale.getdefaultlocale(), resource=RESOURCE):
	formats = [resource.get_string(key, None, None)]

	try:
		formats.append(resource.get_string(key, None, locale))
	except:
#		print(traceback.format_exc())
		pass

	return to_structtime_formats(value, formats)

def to_structtime_formats(value, formats):
	if value:
		for f in formats:
			try:
				return time.strptime(value, f)
			except:
#				print(value)
#				print(format)
#				print(traceback.format_exc())
				pass
	return None

def to_datetime_value(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	return structtime_datetime(to_structtime_resource(value, "DATETIME_PARSE_FORMAT", locale, resource))

def to_date_value(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	dt = structtime_datetime(to_structtime_resource(value, "DATE_PARSE_FORMAT", locale, resource))
	if dt:
		return dt.date()
	return None

def to_time_value(value, locale=locale.getdefaultlocale(), resource=RESOURCE):
	dt = structtime_datetime(to_structtime_resource(value, "TIME_PARSE_FORMAT", locale, resource))
	if dt:
		return dt.time()
	return None

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------

#def printALL(dt):
#	print "------------------------------------------"
#	print(dt)
#	print(to_string_date_value(dt))
#	print(to_string_date_display(dt))
#	print(to_string_datetime_value(dt))
#	print(to_string_datetime_display(dt))
#	print(to_string_time_value(dt))
#	print(to_string_time_display(dt))

## Main
if __name__ == '__main__':
#	printALL(datetime.datetime.now())
#	printALL(datetime.date.today())
#	printALL(datetime.datetime.now().time())
#
#	print(to_datetime_value(to_string_date_value(datetime.datetime.now())))
#	print(to_datetime_value(to_string_datetime_value(datetime.datetime.now())))
#	print(to_datetime_value(to_string_time_value(datetime.datetime.now())))
#	print(to_date_value(to_string_date_value(datetime.datetime.now())))
#	print(to_date_value(to_string_datetime_value(datetime.datetime.now())))
#	print(to_date_value(to_string_time_value(datetime.datetime.now())))
#	print(to_time_value(to_string_date_value(datetime.datetime.now())))
#	print(to_time_value(to_string_datetime_value(datetime.datetime.now())))
#	print(to_time_value(to_string_time_value(datetime.datetime.now())))

	pass

# ------------------------------------------------------------
