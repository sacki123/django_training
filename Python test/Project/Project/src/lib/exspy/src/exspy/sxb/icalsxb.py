#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy sXMLBook iCalendar Module

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

# iCal
from icalendar import Calendar, Event

# ExSpy

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

def add_ical_item(ical, sxb, item):
	event = None

	if item.date != None:
		event = Event()
		event.add("uid", item.id)
		event.add('summary', item.title)
		if item.description != None:
			event.add('description', item.description)
#		event.add('location', u"")
		event.add('dtstart', item.date)
		enddate = item.enddate
		if enddate == None:
			enddate = item.date
		event.add('dtend', enddate)
		ical.add_component(event)
	return event

def create_ical(sxb, vendor, product):
	ical = Calendar()
	ical.add('version', '2.0')
	ical.add('prodid', '-//%s//%s//EN' % (vendor, product))
	ical.add('X-APPLE-CALENDAR-COLOR', '#BBBBBB')
	ical.add('CALSCALE', 'GREGORIAN')
	ical.add('X-WR-TIMEZONE', 'Asia/Tokyo')

	for item in sxb.get_items_sorted():
		add_ical_item(ical, sxb, item)

	return ical

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
