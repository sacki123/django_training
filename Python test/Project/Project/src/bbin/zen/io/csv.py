#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
CSV パッケージ


"""

__title__   = 'CSV パッケージ'
__author__  = "ExpertSoftware Inc."
__status__  = "develop"
__version__ = "0.0.0_0"
__date__    = "2018/07/27"
__license__ = ''
__desc__    = '%s Ver%s (%s)' % (__title__, __version__, __date__)

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
from logging import getLogger
import csv

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def csv_open(filename, encoding='utf-8'):
	# ログ
	log.debug((filename, encoding,))

	with open(filename, encoding='utf-8') as cf:
		return list(csv.reader(cf))

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
