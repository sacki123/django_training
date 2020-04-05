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
import urllib
from datetime import datetime, date
from zm.common.model import getClass
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views import View
from django.db import transaction
from .logic import SqlLogic
from zm.models.TAKAYAMA_MODEL import TAKAYAMA_MODEL
from zm.models.INSURER_TEST import INSURER_TEST

INSURER = 'INSURER_TEST'
class Takayama_view(View):


    def __init__(self):
        self.params = {}
        self.get_request = ''

    def get(self,request, *args, **kwargs):
        self.get_request = request
        return render(request,'takayama/Takayama_template.html')

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
            'load_page': 'load_page',
            'create': 'create_event',   
            'modal_show': 'get_data_show',
            'edit_execute': 'edit_execute',
            'delete_execute': 'delete_execute',
            'header': 'get_header_table',
            'create_table': 'create_table',
            'name_model': 'get_name_model',
            'excel': 'export_excel'
        }
        return list_action

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
        update_params = {
        'rid': str(uuid.uuid4()),
        'did': str(uuid.uuid4())
        }
        return update_params

    def load_page(self, json):
        items = []
        fields = INSURER_TEST._meta.fields
        for field in fields:
            item = {}
            if field.get_internal_type() == 'UUIDField':
                continue
            item['logic_name'] = field.verbose_name
            item['name'] = field.name
            item['type_data'] = field.get_internal_type()
            items.append(item)
        json['items'] = items
        return json

    def create_event(self, json):
        inputs = self.get_inputs()
        inputs = self.validate_inputs(inputs)
        inputs.update(self.create_uuid())
        json['message'] = 'Success'
        try:
            record = INSURER_TEST(**inputs)
            record.save()
        except Exception as e:
            json['error'] = e[0]
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

    #get verbose name
    def get_name_model(self, json):
        obj = getClass(INSURER)
        fields = obj._meta.fields
        verbose_names = {}
        for key in fields:
            if key.verbose_name == 'RID' or key.verbose_name == 'DID':
                continue
            verbose_names[key.name] = key.verbose_name
        json['name'] = verbose_names 
        param = self.get_inputs()
        inputs = self.validate_inputs(param) 
        json['rid'] = inputs['rid']
        return json

    def get_datatable(self, inputs):
        filter_inputs = {}
        data_input = []
        if 'data_table' in inputs and inputs['data_table']:
            data_table = inputs.get('data_table','')
            data_table = data_table.split('&')
            for value in data_table:
                if value == "":
                    continue
                data_input.clear()
                data_input = value.split('=')
                data_input[1] = urllib.parse.unquote(data_input[1])
                filter_inputs.update({data_input[0]:data_input[1]})
        return filter_inputs       

    def format_data_table(self, results, params, json, inputs):
        datatable = []
        riddata = []
        data_list = []
        sql = ""
        order_by = {}
        start = params['start']
        search_value = params['search[value]']
        limit_value = params['length']
        order_no = params['order[0][column]']
        order_dir = params['order[0][dir]']
       
        #Check page length with the number of records 
        if (len(results) < (int(start) + int(limit_value))):
            end = len(results)
        else:
            end = int(start) + int(limit_value)    
      
        #when page length by all     
        if int(limit_value) == -1 or search_value != '':
            end = len(results)
       
        #when event is sort_by    
        if order_no != '0' or order_dir != 'asc':
            field_list = INSURER_TEST._meta.fields
            for field in range(2,len(field_list)):
                if (int(order_no) + 2) == field:
                    order_by[field_list[field].name] = order_dir
                    break 
            sql = SqlLogic().create_full_sql_query(inputs) + SqlLogic().create_order(order_by)
            results = SqlLogic().sql_execute(sql, inputs)
        for index in range(int(start), end):
            data_list.append(results[index])
        for item in data_list:
            row = []
            if search_value == "":
                row = list(item[2:len(item)]) 
                datatable.append(row)
                riddata.append(item[0])
            else:
                row = list(item[2:len(item)]) 
                for i in row:        
                    if search_value in str(i):        
                        datatable.append(row)
                        riddata.append(item[0])
                        break
        json.clear()
        json['draw'] = self.get_request.POST.get('draw', 1)
        json['recordsTotal'] = len(results)
        if search_value == "":
            json['recordsFiltered'] = len(results)
        else:
            json['recordsFiltered'] = len(datatable)   
        if json['recordsTotal'] != json['recordsFiltered']:
            json['recordsTotal'] = len(data_list)    
        json['data'] = datatable
        json['riddata'] = riddata                
        return json
    
    def create_table(self, json):
        params = self.get_inputs()
        filter_params = self.get_datatable(params)
        inputs = self.validate_inputs(filter_params)
        results = SqlLogic().get_data_query(inputs)
        json = self.format_data_table(results, params, json, inputs)
        return json

    #get data for create modal
    def get_data_show(self, json):
        param = self.get_inputs()
        inputs = self.validate_inputs(param)
        result = SqlLogic().get_fulldata_query(inputs)
        json['items'] = result[0]
        json['rid'] = inputs['rid']
        return json

    def edit_execute(self, json):
        param = self.get_inputs()
        inputs = self.validate_inputs(param)
        request = self.get_request
        json = SqlLogic().edit_execute(request, inputs, json)
        return json

    def delete_execute(self, json):
        param = self.get_inputs()
        inputs = self.validate_inputs(param)
        request = self.get_request
        json = SqlLogic().delete_execute(request, inputs, json)
        return json

    def export_excel(self, json):
        param = self.get_inputs()
        inputs = self.validate_inputs(param)
        request = self.get_request
        json = SqlLogic().excel_execute(request, inputs, json)
        return json
