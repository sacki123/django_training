
#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

マスターエクスポート処理

2019/01/15 J.Toba@ExS 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/01/15'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
import tempfile
import os
import json
import uuid
import datetime
import pytz

# dhango
from django.contrib.auth.decorators import login_required
from django.core import serializers

# exs_main
from exs_main.util.file.csv import exportCSV
from exs_main.util.file.excel import exportExcel
from exs_main.util.file.json import exportJSON

#zm
from zm.common import const
from zm.common.model import getClass
from zm.common.modelmanager import ModelManager
from zm.page.master.masterview import MasterView

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
DEF_HEAD_FILE_NAME = 'table_data_%s'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------
def getInputParam(requestdata, name, default_val):
    inputvalue = default_val
    if name in requestdata.GET:
        inputvalue = requestdata.GET.getlist(name)
    
    return inputvalue

@login_required
def masterFileExportView(request, uri):
    names = uri.split('/')
    obj = None
    type_name = 'excel'
    if len(names) > 0:
        if names[0] == '':
            obj = getClass(names[1])
        else:
            obj = getClass(names[0])
    
    if obj != None:
        target_id = getInputParam(request, 'target', None)

        # request file create
        tmpdir = tempfile.gettempdir()
        json_path = os.path.join(tmpdir, target_id[0] + '.json')

        modelmanager = ModelManager(obj)
        export = MasterExport(request, modelmanager)

        fileresponse = None
        try:
            json_data = None
            with open(json_path, 'r') as f:
                json_data = json.load(f)

            if json_data:
                type_name = json_data['type']
                arg_list = {}
                select_list = []
                arg_list = json_data['arg']
                if 'select_col' in json_data:
                    select_list = json_data['select_col']
                if type_name == 'csv':
                    exportdata = export.getExportData(arg_list, select_list)
                    fileresponse = exportCSV(DEF_HEAD_FILE_NAME % modelmanager.getModelName(),exportdata)
                elif type_name == 'excel':
                    exportdata = export.getExportData(arg_list, select_list)
                    fileresponse = exportExcel(DEF_HEAD_FILE_NAME % modelmanager.getModelName(),exportdata)
                elif type_name == 'json':
                    exportdata = export.getExportData(arg_list, select_list, True)
                    fileresponse = exportJSON(DEF_HEAD_FILE_NAME % modelmanager.getModelName(),exportdata)
        finally:
            os.remove(json_path)

        return fileresponse

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
class MasterExport():

    def __init__(self, request, manager):
        """
        コンストラクタ

        Parameters
        ----------
        model : MikanModel
            モデルオブジェクト
        """
        self.modelmanager = manager
        self.requestdata = request

    def getExportData(self, arg_value, select_col, is_json = False):
        obj = self.modelmanager.getModel()
        view = MasterView()
        view.setRequest(self.requestdata)
        columns = view.jsonFormItems(obj.MikanJsonData, True, True, False, False, True)
        condition_list = []
        param_list = []
        
        column_index = 0
        is_company_col = False
        for value in columns:
            if value['name'] == const.MODEL_ATTR_ORGANIZATION_ID:
                is_company_col = True
                continue
            
            inp_val = None
            if value['name'] in arg_value:
                inp_val = arg_value[value['name']]
            if inp_val is not None:
                if 'range' in value and value["range"] == True:
                    range_value = inp_val
                    range_list = range_value.split("}:{")
                    from_val = range_list[0][1:]
                    to_val = range_list[1][0:len(range_list[1]) - 1]
                    if from_val:
                        if value['type'] == 'datetime':
                            tdatetime = datetime.datetime.strptime(from_val, '%Y/%m/%d %H:%M')
                            tdatetime = tdatetime.astimezone(pytz.utc)
                            from_val = tdatetime.strftime('%Y/%m/%d %H:%M')
                        condition_list.append(value['name'] + ' >= %s')
                        param_list.append(from_val)
                    if to_val:
                        if value['type'] == 'datetime':
                            tdatetime = datetime.datetime.strptime(to_val, '%Y/%m/%d %H:%M')
                            tdatetime = tdatetime.astimezone(pytz.utc)
                            to_val = tdatetime.strftime('%Y/%m/%d %H:%M')
                        condition_list.append(value['name'] + ' <= %s')
                        param_list.append(to_val)
                else:
                    if value['type'] == 'select':
                        condition_list.append(value['name'] + ' = %s')
                        param_list.append(inp_val[0])
                    elif value['type'] == 'number':
                        condition_list.append(value['name'] + ' = %s')
                        param_list.append(inp_val[0])
                    elif value['type'] == 'date':
                        condition_list.append(value['name'] + ' = %s')
                        param_list.append(inp_val[0])
                    elif value['type'] == 'radio':
                        condition_list.append(value['name'] + ' like %s')
                        if inp_val[0] == 'false':
                            param_list.append('0')
                        elif inp_val[0] == 'true':
                            param_list.append('1')
                        else:
                            param_list.append('%' + inp_val[0] + '%')
                    else:
                        condition_list.append(value['name'] + ' like %s')
                        param_list.append('%' + inp_val[0] + '%')
        
        # 組合カラムが存在する場合は検索条件に含める
        if is_company_col:
            condition_list.append(const.MODEL_ATTR_ORGANIZATION_ID + ' = %s')
            param_list.append(self.requestdata.session[const.SESSION_COMPANY])
    
        p_id = None
        if 'tab_parent_id' in arg_value:
            p_id = arg_value['tab_parent_id']
        if p_id is not None:
            isallview = None
            if 'isallview' in arg_value:
                isallview = arg_value['isallview']
            if isallview is not None and isallview == 'false':
                tab_name = None
                if 'tab_name' in arg_value:
                    tab_name = arg_value['tab_name']
                if tab_name:
                    tab_names = tab_name.split('__')
                    p_name = tab_names[len(tab_names) - 2]
                    for key, jsonitem in obj.MikanJsonData.items():
                        if jsonitem['type'] == 'select' or jsonitem['type'] == 'auto_suggest':
                            if jsonitem['select']['orm'] == p_name:
                                p_model = getClass(p_name)
                                p_manager = ModelManager(p_model)
                                targetdata = p_manager.getTargetData(p_id)
                                rel_val = getattr(targetdata, jsonitem['select']['rel_col'])
                                condition_list.append(key + ' = %s')
                                param_list.append(rel_val)

        records = self.modelmanager.searchModel(condition_list=condition_list, param_list=param_list)
        if not records.exists():
            records = []
        column_list = []
        col_json_data = []
        for colval in columns:
            if select_col:
                if not colval["name"] in select_col:
                    continue
            if colval["type"] != "hidden":
                col_json_data.append(colval)
                column_list.append(colval['caption'])
        tabledata = self.modelmanager.convertListItems(records, columns)
        export_list = []
        values_list = []

        if is_json:
            list_result = []
            for entry in records:
                dict_data = {}
                for item, val in entry.items():
                    if isinstance(val, str):
                        dict_data[item] = val
                    else:
                        if val == None:
                            dict_data[item] = ''
                        else:
                            dict_data[item] = str(val)
                list_result.append(dict_data)
            return list_result
        
        for data in tabledata:
            val_list = []
            colindex = 0
            for val in data:
                colval = columns[colindex]
                if select_col:
                    if not colval["name"] in select_col:
                        colindex += 1
                        continue
                
                if colval["type"] != "hidden":
                    setval = val['v']
                    if type(val['v']) is not str:
                        setval = str(val['v'])
                    val_list.append(setval)
                colindex += 1
            values_list.append(val_list)
        
        export_list.extend([column_list])
        export_list.extend(values_list)

        return export_list
