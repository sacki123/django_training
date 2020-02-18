#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

マスターモデル表示

2018/08/24 J.Toba@ExS 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__     = '2018/06/01'

import json

from django.shortcuts import render
from django.http import HttpResponse
from django.views import View
from .Takayama_form import Takayama_form
from zm.models.TAKAYAMA_MODEL import TAKAYAMA_MODEL
from zm.models.INSURER_TEST import INSURER_TEST





class Takayama_view(View):


    def __init__(self):
        self.params = {}


    def get(self,request):

        self.params['Takayama_form'] = Takayama_form()

        f = open('/opt/services/djangoapp/src/webapp/zm/page/insurer_test//Takayama_model_fieldname_convert.json', 'r')
        json_table = json.load(f)

        meta_fields = TAKAYAMA_MODEL._meta.get_fields()
        column_list = list()
        for i,fields in enumerate(meta_fields):
            column_list.append(fields.name)

#        self.params['field_physical_name'] = column_list.copy()

        for index, name in enumerate(column_list):
            for key in json_table:
                if(name == key):
                    column_list[index] = json_table[key]                            
            self.params['field_logical_name'] = column_list

        self.params['Takayama_model'] =TAKAYAMA_MODEL.objects.all()

        return render(request,'takayama/Takayama_template.html',self.params)