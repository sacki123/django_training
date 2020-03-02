#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

マスターエクスポート処理

2019/04/23 J.Toba@ExS 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/04/23'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
import datetime

# django
from django.contrib.auth.decorators import login_required

# exs_main
from exs_main.util.file.csv import exportCSV
from exs_main.util.file.excel import exportExcel

#zm
from zm.page.abstract_search_export import XMLSearchExport
from zm.page.abstract_page import AbstractPage
from .views import InsurerJsonSearchView
from zm.page.insurer.logic.download_logic import DownloadLogic
# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
DEF_HEAD_FILE_NAME = 'table_data_%s'
USER_INPUTS = {'opening_class_tcd': '', 'insurance_category_tcd': ''}
TITTLE_SHEET = 'INSURER'
FILE_NAME = 'INSURER_保険者マスタ台帳'
NOT_FOUND_DATA = '該当データがありません'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
# @login_required
# def masterXMLCSVExportView(request, uri):
#     export = DownloadLogic(request)
#     exportdata = export.exportCSV()
#     fileresponse = ''
#     dt_now = datetime.datetime.now()
#     nowstr = dt_now.strftime('%Y%m%d')
#     fileresponse = exportCSV(DEF_HEAD_FILE_NAME % nowstr,exportdata)

#     return fileresponse

# @login_required
   
#------------------------------------------------------------
## Class Section
#------------------------------------------------------------
# class InsurerCSVExportView(InsurerJsonSearchView):
    
#     def exportCSV(self):
#         request = self.getRequest()
#         insurer_name = INSURER_000
#         user_inputs = self.get_input_users(request)
#         data_result = DownloadLogic.data_output(user_inputs)
#         return data_result
        
#     def get_input_users(self, request):
#         form_data = request.POST
#         user_inputs = {
#             'opening_class_tcd': form_data.getlist('opening_class_tcd',''),
#             'insurance_category_tcd': form_data.getlist('insurance_category_tcd','')
#         }
#         return user_inputs
