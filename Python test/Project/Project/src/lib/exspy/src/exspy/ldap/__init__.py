#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
ExSpy LDAP Package

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

# LDAP
import ldap
import ldap.modlist as modlist

# ExSpy
from exspy import AbstractExSpy, EXSPY
from exspy.resource.iniresource import ExSpyINIFileResourceBundle

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## ExSpy LDAP Constant
class EXSPY_LDAP(EXSPY):
	pass

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
def connect_ldap(url, user, password):
	ldap.set_option(ldap.OPT_X_TLS_REQUIRE_CERT, ldap.OPT_X_TLS_ALLOW)
	ldap.set_option(ldap.OPT_REFERRALS, 0)

	l = ldap.initialize(url)
	l.protocol_version = ldap.VERSION3

	l.set_option(ldap.OPT_REFERRALS, 0)
	l.set_option(ldap.OPT_PROTOCOL_VERSION, 3)
	l.set_option(ldap.OPT_X_TLS,ldap.OPT_X_TLS_DEMAND)
	l.set_option(ldap.OPT_X_TLS_DEMAND, True)
	l.set_option(ldap.OPT_DEBUG_LEVEL, 255)

	l.simple_bind_s(user, password)

	return l

# ------------------------------------------------------------
def connect_ad(url, user, password):
	return connect_ldap(url, user, password)

# ------------------------------------------------------------
def users_ad(url, basedn, user, password, userid="*"):
	return users_ldap(url, user, password, "CN=Users", userid)

# ------------------------------------------------------------
def users_ldap(url, basedn, user, password, cn="CN=Users", userid="*"):
	l = connect_ldap(url, user, password)

	filters = "(sAMAccountName=%s)" % userid
	results = l.search_s(cn + ',' + basedn, ldap.SCOPE_SUBTREE, filters)
#	l.unbind_s()
	return results

# ------------------------------------------------------------
def user_ldap_dn(url, basedn, user, password, cn="CN=Users", userid="*"):
	results = users_ldap(url, basedn, user, password, cn, userid)
	for dn,entry in results:
		return entry

# ------------------------------------------------------------
def user_ad_dn(url, basedn, user, password, userid="*"):
	results = users_ad(url, basedn, user, password, userid)
	for dn,entry in results:
		return entry

# ------------------------------------------------------------
def user_ldap(url, basedn, user, password, attr="cn", cn="CN=Users", userid="*"):
	entry = user_ldap_dn(url, basedn, user, password, cn, userid)
	try:
		return entry[attr]
	except:
		return None

# ------------------------------------------------------------
def user_ad(url, basedn, user, password, attr="cn", userid="*"):
	entry = user_ad_dn(url, basedn, user, password, userid)
	try:
		return entry[attr]
	except:
		return None

# ------------------------------------------------------------
def unicode_ldap_password(plainpasswd):
	return ('"%s"' % plainpasswd).encode("utf-16le")

# ------------------------------------------------------------
def unicode_ad_password(plainpasswd):
	return ('"%s"' % plainpasswd).encode("utf-16le")

# ------------------------------------------------------------
def password_ad(url, basedn, user, password, userdn, newpassword):
	unipass = unicode_ldap_password(newpassword)

	l = connect_ldap(url, user, password)

	try:
		mod_attrs = [(ldap.MOD_REPLACE, 'unicodePwd', unipass)]
		l.modify_s(userdn, mod_attrs)
	finally:
		l.unbind_s()

# ------------------------------------------------------------
def modify_ad(url, basedn, user, password, cname, attr, value):
	l = connect_ldap(url, user, password)

	try:
		mod_attrs = [(ldap.MOD_REPLACE, attr, value)]
		l.modify_s(("CN=%s,CN=Users," + basedn)  % cname, mod_attrs)
	finally:
		l.unbind_s()

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
