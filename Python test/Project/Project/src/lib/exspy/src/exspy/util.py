#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Util
 pip install pycrypto
 ExpertSoftware Inc Python Common
"""

__author__ = "K.Sonohara"
__status__ = "develop"
__version__ = "0.0.0_4"
__date__    = "2013/09/01"
__license__ = 'LGPL'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# Python
import ConfigParser
import traceback
import codecs
import os
import json
import base64
import random
import string
import uuid

# Crypto
try:
	from Crypto.Cipher import AES
	is_crypto = True
except:
	is_crypto = False

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
AES_KEY = '74127493827491823749273498632946'
UUID_PYTHON_KEY = 'h'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

class _io(object):
	def __init__(self, f):
		lines = f.read()
		f.close()

		lines = self.forenvs(lines)
		self._lines = lines.split("\n")
		self._linecount = 0

	def forenvs(self, lines):
		for n, v in os.environ.items():
			lines = self.forenv(lines, n, v)
		return lines

	def forenv(self, lines, n, value):
		try:
			k = u"${%s}" % n

			v = value.encode('utf-8')
			if is_crypto and (value[0] == '!'):
				v = decrypt(v[1:])

			return lines.replace(k, v)
		except:
			return lines

	def readline(self):
		if self._linecount >= len(self._lines):
			return None

		l = self._lines[self._linecount]
		self._linecount = self._linecount + 1
		if len(l) == 0:
			return "\n"
		if is_crypto and (l[0] == '!'):
			l = decrypt(l[1:])
		return l

	def close(self):
		pass

def load_config(filename, encoding="utf8", errornone=True, osenv=False):
	config = ConfigParser.SafeConfigParser()

	error = False

	try:
		f = codecs.open(filename, "r", encoding)
		if osenv:
			f = _io(f)

		try:
			config.readfp(f)
		finally:
			if f:
				f.close()
	except:
#		print(traceback.format_exc())
		error = True

	if error and errornone:
		return None

	return config

def decrypt(value, key=None):
	k = key
	if k == None:
		k = AES_KEY
	cipher = AES.new(k)

	data = base64.b64decode(value)
	v = cipher.decrypt(data)
	v = v.strip()
	v = base64.b64decode(v)

	return v

def encrypt(value, key=None):
	k = key
	if k == None:
		k = AES_KEY
	cipher = AES.new(k)


	data = base64.b64encode(value)

	c = len(data)
	v = data
	for i in range(64- (c % 64)):
		v = " " + v

	v = cipher.encrypt(v)
	e = base64.b64encode(v)

	return e

def load_json(file_json):
	f = open(file_json, 'r')
	j = None
	try:
		j = json.load(f)
	finally:
		try:
			f.close()
		except:
			pass
	return j

def random_string(length):
	return ''.join([random.choice(string.ascii_letters + string.digits) for i in range(length)])

def getGUID():
	return str(uuid.uuid4()) + UUID_PYTHON_KEY

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
