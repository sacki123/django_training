#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Network Module

 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_1"
__date__    = "2013/05/05"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import sys
if __name__ == '__main__':
	sys.path.append(".")
import os
import json
import platform
import commands

# ExSpy
from exspy import EXSPY

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy Mail Constant
class EXSPY_DISK(EXSPY):
	DISK_LIST_LINUX=u"""df -h --portability  -x tmpfs -x nfs"""

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

def stat_disks():
	if platform.system() == "Linux":
		df = commands.getoutput(DISK_LIST_LINUX)
		df = df.replace("\t", " ")
		while (df.find("  ") != -1):
			df = df.replace("  ", " ")

		l = df.splitlines()
		disks = {}
		cols = None
		for disk in l:
			ds = disk.split(" ")
			if cols == None:
				cols = ds
			else:
				disks[ds[0]] = {}
				for i in range(len(ds)):
					disks[ds[0]][cols[i]] = ds[i]
		return disks
	if platform.system() == "Windows":
		vbs = os.path.join(os.path.dirname(os.path.abspath( __file__ )), "stat_disks.vbs")
		df = os.popen(u"""cscript //Nologo %s""" % vbs).read() 

		return json.loads(df)

	return {'unkown': {'Use%': '0%', 'Used': '0G', 'Avail': '0G', 'Filesystem': 'unkown', 'Mounted': '/', 'Size': '0G'}}

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------
## Main
if __name__ == '__main__':
	print stat_disks()
	vars()
