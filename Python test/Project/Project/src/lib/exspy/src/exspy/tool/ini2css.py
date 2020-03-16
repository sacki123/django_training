#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy INI>CSS Tool Module

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
import sys
if __name__ == '__main__':
	sys.path.append(".")
	sys.path.append("src")
import os

# ExSpy
from exspy.main import ExSpyResourceParam
from exspy.css.inicss import ExSpyINICSS
from exspy.tool import AbstractExSpyTool
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
## Get resource for Multi Locale
# @param key Resource key
# @param default Default value
# @param locale Locale
# @param resource Target Resource bundle
def _(key, default, locale=None, resource=RESOURCE):
	try:
		return resource.get_string(key, default, locale)
	except:
		return default

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy INI>CSS Tool Class
class ExSpyINI2CSSTool(AbstractExSpyTool):

	# ----------------------------------------------------
	## Constructor
	def __init__(self):
		# super
		super(ExSpyINI2CSSTool, self).__init__()

		# params
		self.getParams()["prefix"] = (ExSpyResourceParam(RESOURCE, "prefix"))
		self.getParams()["path"] = (ExSpyResourceParam(RESOURCE, "path"))
		self.getParams()["output"] = (ExSpyResourceParam(RESOURCE, "output"))
		self.getParams()["format"] = (ExSpyResourceParam(RESOURCE, "format"))
		self.getParams()["version"] = (ExSpyResourceParam(RESOURCE, "version"))

	# ----------------------------------------------------
	## Perform
	# @return exit code.
	def perform(self):
		if self.getOptions().version:
			self.version()
			return 0

		# CSS
		ini = ExSpyINICSS()
		ini.load_inis(u"%s.%s.ini" % (os.path.join(self.getOptions().path, self.getOptions().prefix), "%s"))

		# output
		print ini.to_csss(self.getOptions().format)

		# exit code
		return 0

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
# ------------------------------------------------------------
#  使い方：
#  	INIファイルは以下の構成となる
#  		[名前].html.ini
#  		[名前].class.ini
#  		[名前].id.ini
#  	*[名前]は引数-iにて指定
#  
#  	セクション[env]は処理時に値を置換する変数として機能する
#  		例：
#  			[env]
#  			test=red
#  
#  			color=%test%＞color=red
#  
#  引数：
#  	-p
#  		INIファイルパス
#  
#  	-i
#  		INIファイルプレフィックス [名前]
#  
#  	-f
#  		この引数が指定された場合整形モードで出力される
#  
#  	-o (未実装)
#  		出力ファイル名
#  		この引数が指定されない場合はコンソールに出力される
#  
#  	--h (未実装)
#  		ヘルプメッセージ
#  	--v (未実装)
#  		バージョン情報
if __name__ == '__main__':
	ini2css = ExSpyINI2CSSTool()
	exit(ini2css())

# ------------------------------------------------------------
