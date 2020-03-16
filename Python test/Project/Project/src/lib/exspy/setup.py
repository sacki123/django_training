#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExS Python Install Package (setup.py)

ExpertSoftware Inc Python Common
"""

__name__ = "exspy"
__desc__ = "ExpertSoftware Inc Python"
__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0"
__date__    = "2017/04/07"
__email__ = 'expertsoftware.i@gmail.com'
__license__ = 'LGPL'
__url__='https://github.com/ksonohara/exspy',

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python

# distutils
from distutils.core import setup

# ExSpy

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
classifiers = [
	"Classifier: Development Status :: 3 - Alpha ",
	"Classifier: Intended Audience :: Developers",
	"Classifier: Operating System :: OS Independent",
	"Classifier: Programming Language :: Python",
	"Classifier: Programming Language :: Python :: 2.6",
	"Classifier: Programming Language :: Python :: 2.7",
	"Classifier: Topic :: Software Development :: Libraries :: Python Modules",
]
keywords=[
	'Frameworks',
]
setup (
	name=__name__,
	description=__desc__,
	version=__version__,
	license = __license__,
	author = __author__,
	author_email = __email__,
	url = __url__,

	classifiers=classifiers,
	keywords=keywords,

	packages=[
				"exspy",
				"exspy/calendar",
				"exspy/css",
				"exspy/date",
				"exspy/disk",
				"exspy/exception",
				"exspy/ldap",
				"exspy/mail",
				"exspy/main",
				"exspy/network",
				"exspy/resource",
				"exspy/sxb",
				"exspy/tool",
				"exspy/xml",
			],
	package_dir={
				"exspy":"src/exspy",
				"exspy/calendar":"src/exspy/calendar",
				"exspy/css":"src/exspy/css",
				"exspy/date":"src/exspy/date",
				"exspy/disk":"src/exspy/disk",
				"exspy/exception":"src/exspy/exception",
				"exspy/ldap":"src/exspy/ldap",
				"exspy/mail":"src/exspy/mail",
				"exspy/main":"src/exspy/main",
				"exspy/network":"src/exspy/network",
				"exspy/resource":"src/exspy/resource",
				"exspy/sxb":"src/exspy/sxb",
				"exspy/tool":"src/exspy/tool",
				"exspy/xml":"src/exspy/xml",
			},
	package_data={
				'exspy': [
					'calendar/*.ini',
					'stat_disks/*.vbs',
					'tool/*.ini'
				]
			},
)

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Main Section
# ------------------------------------------------------------

# ------------------------------------------------------------
