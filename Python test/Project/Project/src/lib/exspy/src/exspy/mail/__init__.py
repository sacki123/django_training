#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy Mail Package

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
import smtplib
from email.MIMEText import MIMEText
from email.Header import Header
from email.Utils import formatdate

# ExSpy
from exspy import AbstractExSpy, EXSPY
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy Mail Constant
class EXSPY_MAIL(EXSPY):
	pass

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

def create_mail(subject, body, frommail, tomail=None, encode="ISO-2022-JP"):
	mail = MIMEText(body, 'plain', encode)
	mail['Return-Path'] = frommail
	mail['Reply-To'] = frommail
	mail['Subject'] = Header(subject, encode)
	mail['From'] = frommail
	if tomail != None:
		mail['To'] = tomail
	mail['Date'] = formatdate(localtime=True)
	return mail

def send_mail(frommail, tomail, mail, host=None, connect=False):
	if host:
		smtp = smtplib.SMTP(host)
	else:
		smtp = smtplib.SMTP()

	if connect:
		smtp.connect()

	smtp.sendmail(frommail, [tomail], mail.as_string())
	smtp.close()

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
