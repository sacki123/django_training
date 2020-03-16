#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy sXMLBook RSS Module

 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_5"
__date__    = "2013/12/15"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python

# RSS
import feedgenerator

# ExSpy

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

def add_rss_item(rss, sxb, base_url, item):
	item = rss.add_item(
		title = item.title,
		link = base_url % item.id,
		description = item.description,
		author_name= sxb.info.company,
		pubdate = item.date,
	)

def create_rss(sxb, rss_url, base_url):
	rss = feedgenerator.Rss201rev2Feed(
		title = sxb.info.title,
		link = sxb.info.homepage,
		feed_url = rss_url,
		description = sxb.info.description,
		author_name= sxb.info.company,
		pubdate = sxb.info.date
	)

	for item in sxb.get_items_sorted():
		add_rss_item(rss, sxb, base_url, item)

	return rss.writeString('utf-8')

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
