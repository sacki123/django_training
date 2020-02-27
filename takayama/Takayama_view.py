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
import uuid
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views import View
from django.db import transaction
from .Takayama_form import Takayama_form
from zm.models.TAKAYAMA_MODEL import TAKAYAMA_MODEL
from zm.models.INSURER_TEST import INSURER_TEST
from django.db import connection
from zm.common.model import getClass

INSURER = 'INSURER_TEST'
class Takayama_view(View):


    def __init__(self):
        self.params = {}
        self.get_request = ''

    def get(self,request, *args, **kwargs):
        self.get_request = request
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

    def post(self, request, *args, **kwargs):
        self.get_request = request
        json = self.json_response()
        json = self.do_post_event(request, json)
        return JsonResponse(json)
    @transaction.atomic
    def do_post_event(self, request, json):
        action = self.get_action()
        list_action = self.get_list_action()
        if action in list_action:
            return getattr(self,list_action[action])(json)
        json['status'] = 202
        return json

    def json_response(self):
        json = {
            'message': '',
            'status': 200
        }
        return json

    def get_action(self):
        action = self.kwargs['uri']
        action = action.split('/')
        if len(action) > 0:
            url = action[-1]
            return url
        return None    

    def get_list_action(self):
        list_action = {
            'create': 'create_event',   
            'edit': 'edit_event',
            'delete': 'delete_event',
            'header': 'get_header_table',
            'create_table': 'create_table'
        }
        return list_action

    def run_sql(self, sql, sqlparam):
        with connection.cursor() as con:
            con.excecute(sql, sqlparam)
            results = con.fetchall()
            return results
    
    def get_inputs(self):
        request = self.get_request
        inputs = {}
        for key, value in request.POST.items():
            inputs[key] = value
        return inputs

    def validate_inputs(self, inputs):
        for key, value in inputs.items():
            value = value.replace('年','-')
            value = value.replace('月','-')
            value = value.replace('日','')
            inputs[key] = value
        return inputs   
        
    def create_uuid(self):
        update_param = {
        'rid': uuid.uuid4(),
        'did': uuid.uuid4()
        }
        return update_param

    def create_event(self, json):
        inputs = self.get_inputs()
        inputs = self.validate_inputs(inputs)
        inputs.update(self.create_uuid())
        json['message'] = 'Success'
        try:
            record = INSURER_TEST(**inputs)
            record.save()
        except Exception as e:
            json['error'] = e
            json['status'] = 202
        return json

    def get_header_table(self, json):
        obj = getClass(INSURER)
        fields = obj._meta.fields
        verbose_names = []
        for key in fields:
            if key.verbose_name == 'RID' or key.verbose_name == 'DID':
                continue
            verbose_names.append({'title': key.verbose_name})
        json['header'] = verbose_names   
        return json

    def create_table(self, json):
        inputs = self.get_inputs()
        inputs = self.validate_inputs(inputs)

