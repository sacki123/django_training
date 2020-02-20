#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

Django URL設定
https://docs.djangoproject.com/en/2.0/topics/http/urls/

2018/06/01 K.Sonohara@ExS 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__     = '2018/06/01'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# django
from django.urls import path, re_path
from django.conf.urls import url,include
from django.conf import settings
from django.conf.urls.static import static
from django.contrib.auth.views import LogoutView

# zen

#from zm.page import master
from zm.page import login
from zm.page import company
from zm.page import system_setting
from zm.page.menu import urls
from zm.page.example.view import Example
from .Takayama_view import Takayama_view

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
 
urlpatterns = [
    re_path(r'^(?P<uri>.*)', Takayama_view.as_view()),
]

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
