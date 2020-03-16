#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy sXMLBook Package

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
import datetime
from operator import itemgetter, attrgetter

# XML
from xml.dom.minidom import parse,Element

# ExSpy
from exspy import AbstractExSpy, EXSPY, ExSpyProperty
from exspy.resource.iniresource import ExSpyINIFileResourceBundle
from exspy.xml import single_element_by

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
## sXMLBook定義値
class EXSPY_SXB(EXSPY):

	ELEMENT_ID ="id"
	ELEMENT_INFO ="info"
	ELEMENT_ITEM ="item"
	ELEMENT_INDEX ="index"
	ELEMENT_TITLE ="title"
	ELEMENT_DESCRIPTION ="description"
	ELEMENT_RELEASE ="release"
	ELEMENT_DATE ="date"
	ELEMENT_COMPANY ="company"
	ELEMENT_HOMEPAGE ="homepage"
	ELEMENT_COPYRIGHT ="copyright"

	ATTRIBUTE_ID ="id"
	ATTRIBUTE_NAME ="name"

# ------------------------------------------------------------
## ExSpy 抽象sXMLBook クラス
#
class AbstractExSpySXB(AbstractExSpy):

	# ----------------------------------------------------
	## コンストラクタ
	#  @param self クラス自身
	def __init__(self):
		super(AbstractExSpySXB, self).__init__()

	def to_datetime(self, value):
		if value == None:
			return None
		elif isinstance(value, datetime.__class__):
			return value
		else:
			try:
				return datetime.datetime.strptime(value,"%Y/%m/%d %H:%M:%S")
			except:
				try:
					return datetime.datetime.strptime(value,"%Y/%m/%d")
				except:
					pass
		return None

	def __str__(self):
		return ""

# ------------------------------------------------------------
## ExSpy sXMLBook Info クラス
#
class ExSpySXBInfo(AbstractExSpySXB):

	def get_id(self):
		return self.FID

	def set_id(self, value):
		self.FID = value

	def get_title(self):
		return self.FTitle

	def set_title(self, value):
		self.FTitle = value

	def get_description(self):
		return self.FDescription

	def set_description(self, value):
		self.FDescription = value

	def get_date(self):
		return self.FDate

	def set_date(self, value):
		self.FDate = self.to_datetime(value)

	def get_release(self):
		return self.FRelease

	def set_release(self, value):
		self.FRelease = value

	def get_company(self):
		return self.FCompany

	def set_company(self, value):
		self.FCompany = value

	def get_homepage(self):
		return self.FHomepage

	def set_homepage(self, value):
		self.FHomepage = value

	def get_copyright(self):
		return self.FCopyright

	def set_copyright(self, value):
		self.FCopyright = value

	def __str__(self):
		return self.__class__.__name__

	# ----------------------------------------------------
	## コンストラクタ
	#  @param self クラス自身
	def __init__(self):
		super(ExSpySXBInfo, self).__init__()

		self.FID = None
		self.FTitle = None
		self.FDescription = None
		self.FDate = None
		self.FRelease = None
		self.FCompany = None
		self.FHomepage = None
		self.FCopyright = None

	def parse_mimidom(self, minidom):
		for node in minidom.childNodes:
			if node.nodeType == node.ELEMENT_NODE:
				name = node.nodeName
				value = node.firstChild.nodeValue
				if name == EXSPY_SXB.ELEMENT_ID:
					self.id = value
				elif name == EXSPY_SXB.ELEMENT_TITLE:
					self.title = value
				elif name == EXSPY_SXB.ELEMENT_DESCRIPTION:
					self.description = value
				elif name == EXSPY_SXB.ELEMENT_DATE:
					self.date = value
				elif name == EXSPY_SXB.ELEMENT_RELEASE:
					self.release =value
				elif name == EXSPY_SXB.ELEMENT_COMPANY:
					self.company =value
				elif name == EXSPY_SXB.ELEMENT_HOMEPAGE:
					self.homepage =value
				elif name == EXSPY_SXB.ELEMENT_COPYRIGHT:
					self.copyright =value

	# ----------------------------------------------------
	## Property
	id = ExSpyProperty(get_id, set_id, None)
	title = ExSpyProperty(get_title, set_title, None)
	description = ExSpyProperty(get_description, set_description, None)
	date = ExSpyProperty(get_date, set_date, None)
	company = ExSpyProperty(get_company, set_company, None)
	copyright = ExSpyProperty(get_copyright, set_copyright, None)
	homepage = ExSpyProperty(get_homepage, set_homepage, None)
	release = ExSpyProperty(get_release, set_release, None)

# ------------------------------------------------------------
## ExSpy 抽象sXMLBook クラス
#
class ExSpySXBItem(AbstractExSpySXB):

	def get_id(self):
		return self.FID

	def set_id(self, value):
		self.FID = value

	def get_title(self):
		return self.FTitle

	def set_title(self, value):
		self.FTitle = value

	def get_description(self):
		return self.FDescription

	def set_description(self, value):
		self.FDescription = value

	def get_date(self):
		return self.FDate

	def set_date(self, value):
		self.FDate = self.to_datetime(value)

	def get_enddate(self):
		return self.FEndDate

	def set_enddate(self, value):
		self.FEndDate = self.to_datetime(value)

	def get_parent(self):
		return self.FParent

	def __str__(self):
		return self.__class__.__name__

	# ----------------------------------------------------
	## コンストラクタ
	#  @param self クラス自身
	def __init__(self, parent, pid=None):
		super(ExSpySXBItem, self).__init__()

		self.FParent = parent

		self.FID = pid
		self.FTitle = None
		self.FDescription = None
		self.FDate = datetime.datetime.today()
		self.FEndDate = None

	def parse_mimidom(self, minidom):
		if minidom.hasAttribute(EXSPY_SXB.ATTRIBUTE_ID):
			self.id = minidom.getAttribute(EXSPY_SXB.ATTRIBUTE_ID)
		for node in minidom.childNodes:
			if node.nodeType == node.ELEMENT_NODE:
				name = node.nodeName
				value = node.firstChild.nodeValue

				if name == EXSPY_SXB.ELEMENT_TITLE:
					self.title = value
				elif name == EXSPY_SXB.ELEMENT_DESCRIPTION:
					self.description = value
				elif name == EXSPY_SXB.ELEMENT_DATE:
					self.date = value

	# ----------------------------------------------------
	## Property
	id = ExSpyProperty(get_id, set_id, None)
	title = ExSpyProperty(get_title, set_title, None)
	description = ExSpyProperty(get_description, set_description, None)
	date = ExSpyProperty(get_date, set_date, None)
	enddate = ExSpyProperty(get_enddate, set_enddate, None)
	parent = ExSpyProperty(get_parent, None, None)

# ------------------------------------------------------------
## ExSpy 抽象sXMLBook クラス
#
class ExSpySXBIndex(AbstractExSpySXB):

	def get_item(self):
		return self.FItem

	def set_item(self, value):
		self.FItem = value

	def get_indexes(self):
		return self.FIndexes

	def get_parent(self):
		return self.FParent

	# ----------------------------------------------------
	## コンストラクタ
	#  @param self クラス自身
	def __init__(self, parent, Item=None):
		super(ExSpySXBIndex, self).__init__()

		self.FParent = parent

		self.FItem = Item
		self.FIndexes = []

	def parse_mimidom(self, minidom):
		if minidom.hasAttribute(EXSPY_SXB.ATTRIBUTE_NAME):
			pid = minidom.getAttribute(EXSPY_SXB.ATTRIBUTE_NAME)
			self.item = self.parent.items[pid]

		for node in minidom.childNodes:
			if node.nodeType == node.ELEMENT_NODE:
				name = node.nodeName
				if name == EXSPY_SXB.ELEMENT_INDEX:
					try:
						sxb = ExSpySXBIndex(self.parent)
						sxb.parse_mimidom(node)
						self.indexes.append(sxb)
					except:
						pass

	# ----------------------------------------------------
	## Property
	parent = ExSpyProperty(get_parent, None, None)
	item = ExSpyProperty(get_item, set_item, None)
	indexes = ExSpyProperty(get_indexes, None, None)

# ------------------------------------------------------------
## ExSpy 抽象sXMLBook クラス
#
class ExSpySXMLBook(AbstractExSpySXB):

	def get_indexes(self):
		return self.FIndexes

	def get_items(self):
		return self.FItems

	def get_info(self):
		return self.FInfo

	def set_info(self, value):
		self.FInfo = value

	# ----------------------------------------------------
	## コンストラクタ
	#  @param self クラス自身
	def __init__(self):
		super(ExSpySXMLBook, self).__init__()

		self.FInfo = ExSpySXBInfo()
		self.FItems = {}
		self.FIndexes = []

	def __str__(self):
		return u"<%s>\n%s\n" % (self.info, self.items)

	def parse_file(self, filename, info=True):
		self.parse_mimidom(parse(filename), info)

	def parse_mimidom(self, minidom, info=True):
		element = minidom.documentElement

		if info:
			sxb_info = single_element_by(element, EXSPY_SXB.ELEMENT_INFO)
			self.info.parse_mimidom(sxb_info)

		for node in element.childNodes:
			if node.nodeType == node.ELEMENT_NODE:
				name = node.nodeName
				if name == EXSPY_SXB.ELEMENT_ITEM:
					sxb = ExSpySXBItem(self)
					sxb.parse_mimidom(node)
					self.items[sxb.id] = sxb

		for node in element.childNodes:
			if node.nodeType == node.ELEMENT_NODE:
				name = node.nodeName
				if name == EXSPY_SXB.ELEMENT_INDEX:
					try:
						sxb = ExSpySXBIndex(self)
						sxb.parse_mimidom(node)
						self.indexes.append(sxb)
					except:
						pass

	def get_items_sorted(self, key="FDate"):
		return sorted(self.items.values(), key=attrgetter(key))

	# ----------------------------------------------------
	## Property
	indexes = ExSpyProperty(get_indexes, None, None)
	items = ExSpyProperty(get_items, None, None)
	info = ExSpyProperty(get_info, set_info, None)

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	pass

# ------------------------------------------------------------
