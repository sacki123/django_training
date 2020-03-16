#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
日本消費税データ パッケージ


"""

__title__   = '日本消費税データ パッケージ'
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

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)

CONSUMPTION_JP = {
    '0001-01-01': {'begin_date': datetime.datetime.strptime('0001-01-01', '%Y-%m-%d'), 'end_date': datetime.datetime.strptime('1988-03-31', '%Y-%m-%d'), 'tax':  0},
    '1989-04-01': {'begin_date': datetime.datetime.strptime('1989-04-01', '%Y-%m-%d'), 'end_date': datetime.datetime.strptime('1997-03-31', '%Y-%m-%d'), 'tax': 3},
    '1997-04-01': {'begin_date': datetime.datetime.strptime('1997-04-01', '%Y-%m-%d'), 'end_date': datetime.datetime.strptime('2013-03-31', '%Y-%m-%d'), 'tax': 5},
    '2014-04-01': {'begin_date': datetime.datetime.strptime('2014-04-01', '%Y-%m-%d'), 'end_date': datetime.datetime.strptime('2019-09-30', '%Y-%m-%d'), 'tax': 8},
    '2019-10-01': {'begin_date': datetime.datetime.strptime('2019-10-01', '%Y-%m-%d'), 'end_date': datetime.datetime.strptime('9999-12-31', '%Y-%m-%d'), 'tax': 10}
}

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
