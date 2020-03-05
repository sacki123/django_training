#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
日本の祝日データ変換ツール


"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_0"
__date__    = "2014/03/01"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import sys
reload(sys)
sys.setdefaultencoding("utf-8")
import pandas
import traceback
import csv, codecs

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
## Resource Variable
URL_CSV = 'http://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## .
# @param date .
# @param l locale
# @return .
#def get_holiday_from_date(date, l=locale.getlocale()):
#	return get_holiday(date.year, date.month, date.day)

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	csv_reader = csv.reader(codecs.open('syukujitsu.csv', 'r', encoding="shift_jis"))


	out_php = codecs.open('syukujitsu.php', 'w', 'utf-8')
	out_ini = codecs.open('syukujitsu.ini', 'w', 'utf-8')
	out_py = codecs.open('syukujitsu.py', 'w', 'utf-8')
	out_sql = codecs.open('syukujitsu.sql', 'w', 'utf-8')

	out_php.write(u"<?php\n")
	out_php.write(u"  HOLIDAY=array(\n")
	out_ini.write(u"[resource]\n")
	out_py.write(u"HOLIDAY = dict{\n")
	#CREATE TABLE fruit(id INT AUTO_INCREMENT NOT NULL PRIMARY KEY, name VARCHAR(50), price INT);
	#date, year, month, day, caption
	out_sql.write(u"""// MySQL\n/*
CREATE TABLE holiday(
	holiday date NOT NULL PRIMARY KEY
	, year int
	, month int
	, day int
	, caption VARCHAR(20)
);
ALTER TABLE holiday ADD INDEX holiday_days(year, month, day);
*/\n""")
	out_sql.write(u"DELETE FROM HOLIDAY;\n")
	first = True
	for row in csv_reader:
		d = row[0].split('-',3)
		if (len(d)>2):
			n = row[1]
			out_php.write(u"    %s%s%s=>'%s',\n" % (d[0], d[1], d[2], n))
			out_ini.write(u"HOLIDAY_%s%s%s=%s\n" % (d[0], d[1], d[2], n))
			if not first:
				out_py.write(u",\n")
			out_py.write(u"%s%s%s: u\"%s\"" % (d[0], d[1], d[2], n))
			out_sql.write(u"INSERT INTO holiday(holiday, year, month, day, caption) VALUES('%s', %s, %s, %s, '%s');\n" % (row[0], d[0], d[1], d[2], n))
			first = False

	out_php.write(u"  );\n")
	out_py.write(u"\n}\n")

	out_php.close()
	out_ini.close()
	out_py.close()
	out_sql.close()

#国民の祝日月日,国民の祝日名

# ------------------------------------------------------------
