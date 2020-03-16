#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy XML Package

 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_2"
__date__    = "2013/08/11"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import sys
import traceback

# XML
from xml.dom.minidom import parse, Element

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
def value_note(node, default=None):
	try:
		return node.firstChild.data
	except:
		return default

# ------------------------------------------------------------
def single_note(nodes):
	try:
		return nodes[0]
	except:
		return None

# ------------------------------------------------------------
def single_element_by(parent, name):
	return single_note(parent.getElementsByTagName(name))

# ------------------------------------------------------------
def node_id(xml, tagname, attr, pid):
	for item in xml.getElementsByTagName(tagname):
		try:
			if item.attributes[attr].nodeValue == pid:
				return item
		except:
			print(traceback.format_exc())
			pass

	return None

# ------------------------------------------------------------
## テキストの特殊文字を置換
# @param text XMLテキスト
# @return 処理結果
def text_xml(text):
	if text == None:
		return None

	text = text.replace('&', '&amp;')
	text = text.replace('<', '&lt;')
	text = text.replace('>', '&gt;')
	text = text.replace('"', '&quot;')

	return text

# ------------------------------------------------------------
## XML Node to String
# @param node XML Node
# @param trip True is Trim.
# @param indent Indent char
# @param newline return char
# @return result
def str_node(node, trip=True, indent=u"", newline=u"\n"):
	text  = ""

	# DOCUMENT
	if node.nodeType == node.DOCUMENT_NODE:
		text = u"<?xml version=\"1.0\" encoding=\"UTF-8\" ?>%s" % (newline)

	# TEXT
	elif node.nodeType == node.TEXT_NODE:
		a = text_xml(node.data)
		if a != None:
			if trip == True:
				a = a.strip()
			text = u"%s%s" % (text, a)

	# node.CDATA_SECTION_NODE
	elif node.nodeType == node.CDATA_SECTION_NODE:
		a = node.data
		if a != None:
			if trip == True:
				a = a.strip()
			text = u"%s%s" % (text, a)

	# コメント
	elif node.nodeType == node.COMMENT_NODE:
		a = node.data
		if a != None:
			text = u"%s%s<!-- %s" % (text, newline, a)

	# ELEMENT
	elif node.nodeType == node. ELEMENT_NODE:
		text = u"%s%s<%s" % (text, newline, node.nodeName)
		if (node.hasAttributes):
			for item in node.attributes.items():
				text = u"%s %s=\"%s\"" % (text, item[0], text_xml(item[1]))

	aaaa = None
	if (node.hasChildNodes):
		for child in node.childNodes:
			if aaaa == None:
				aaaa = u"%s" % (str_node(child, trip, newline))
			else:
				aaaa = u"%s%s" % (aaaa, str_node(child, trip, newline))

	# ELEMENT
	if node.nodeType == node.ELEMENT_NODE:
		if (aaaa == None):
			text = u"%s />" % (text)
		else:
			text = u"%s>" % (text)
	# コメント
	elif node.nodeType == node.COMMENT_NODE:
		if (aaaa == None):
			text = u"%s -->" % (text)
		else:
			text = u"%s>" % (text)

	if aaaa != None:
		text = u"%s%s" % (text, aaaa)

	# ELEMENT
	if node.nodeType == node. ELEMENT_NODE:
		if aaaa != None:
			text = u"%s</%s>" % (text, node.nodeName)
	return text

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
