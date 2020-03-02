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

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
import tempfile
import os
import traceback
import sys
import uuid
import json
import datetime
import pytz
from xml.dom import minidom

# django
from django.http import Http404
from django.db import transaction
from django.utils import timezone

# exs_main
from exs_main.util.message import getEXSMessage
from exs_main.util.log import EXSLogger
from exs_main.db.data.zipcode import searchAddressForZipcode
from exs_main.util.file.csv import exportCSV
from exs_main.util.file.excel import exportExcel
from exs_main.util.file.json import exportJSON

# zen
from zm import config
from zm.common import const
from zm.common.file.s3 import delete_file
from zm.common.exception import BusinessException
from zm.common.model import getClass
from zm.common.model import getHistoryClass
from zm.common.modelmanager import ModelManager
from zm.page.abstract_page import AbstractPage
from zm.exception.E00_001 import E00001Exception

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

VIEW_ARG = 'uri'
URL_BASE = 'master'
DEFAULT_REVISION_VALUE = '0'
DEF_HEAD_FILE_NAME = 'table_data_%s'

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
class MasterView(AbstractPage):
    """
    マスターメンテ処理クラス

    Attributes
    ----------
    viewaction : str
        アクション名
    
    modelclassname : str
        対象モデル名
    
    viewurl : str
        表示URL
    
    testFlag : bool
        テスト表示モードフラグ
    """

    viewaction = ''

    modelclassname = ''

    viewurl = ''

    testFlag = False
    
    def __init__(self):
        super().__init__()
        self.default_css = [
            '/css/jquery-ui.min.css'
            ,'/css/zm.css']
        
        self.default_js =[
            '/js/jquery-ui.min.js',
            '/js/common/utils.js',
            '/js/common/format.js',
            '/js/common/request.js',
            '/js/common/ui.js',
            "/js/common/jquery.customInput.js",
            '/js/common/start.js',
            '/js/zm.js',
            ]

    def getActionEvent(self):
        """
        アクションイベント情報取得
        
        Returns
        -------
        action : dict
            アクションイベント情報
        """
        action = {}
        action['remove'] = 'removeJson'
        action['removefile'] = 'removeFileEvent'
        action['form'] = 'getFormJSON'
        action['list'] = 'getListJSON'
        action['create'] = 'createEvent'
        action['edittab'] = 'getTabJSON'
        action['detail'] = 'detailEvent'
        action['edit'] = 'editEvent'
        action['revup'] = 'revupEvent'
        action['copy'] = 'copyEvent'
        action['export'] = 'exportEvent'
        action['upload'] = 'uploadEvent'
        action['loadfile'] = 'loadFileEvent'
        action['createtabform'] = 'createTabEvent'
        action['tabform'] = 'getTabFormJSON'
        action['tabfileform'] = 'getTabFileFormJSON'
        action['autosg'] = 'getAutoSgJSON'
        action['loadpage'] = 'getLoadJSON'
        action['zipcode'] = 'getZipcodeData'
        action['test'] = 'testEvent'


        return action
    
    def setRequest(self, request_data):
        self.request = request_data

    def getSiteJson(self):
        """
        JSON初期値情報取得
        
        Returns
        -------
        json : dict
            Json初期情報
        """
        json = {}
        json["title"] = ""
        json["status"] = 200

        json["buttons"] = {}
        json["buttons"]["submit"] = {}
        json["buttons"]["submit"]["caption"] = ""
        json["tools"] = []
        json["items"] = {}

        return json

    def doPostEvent(self, json):
        """
        POSTイベント実行

        Parameters
        ----------
        json : dict
            処理JSON情報
        
        Returns
        -------
        json : dict
            JSONオブジェクト
        """
        self.initMaster()
        json["title"] = self.modelmanager.getModelName()

        actiondata = self.getActionEvent()
        if self.viewaction in actiondata:
            getattr(self, actiondata[self.viewaction])(json)
        
        return json

    def doPageHtml(self):
        """
        ページ表示実行処理
        
        Returns
        -------
        str : str
            空文字
        """
        self.initMaster()
        if self.viewaction == 'test':
            self.config['search_id'] = 'test_col'
            self.testFlag = True
        else:
            self.config['search_id'] = 'search'
        self.config['model_title'] = self.modelmanager.getModelName()
        self.config['site_title'] = self.modelmanager.getModelName()
        return ''
    
    def createTabEvent(self, json):
        """
        タブ新規作成イベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        json['tab'] = 'tab'
        self.createEvent(json)

    def createEvent(self, json):
        """
        新規作成イベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "create_submit":
            if not 'tab' in json:
                json["simple"] = True
            self.setItem(json, False, getEXSMessage('C00_001'))
        else:
            self.jsonItem(json, False, getEXSMessage('C00_001'), "create_submit")
    
    def testEvent(self, json):
        """
        テスト表示イベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        self.jsonItem(json, False, "作成", "create_submit")
    
    def getZipcodeData(self, json):
        """
        郵便番号情報取得

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        mzipcode_value = self.getPOSTInputParam(None, 'zipcode', '')
        zipdata = searchAddressForZipcode(mzipcode_value)

        if zipdata:
            json['zipdata'] = zipdata
        else:
            json["status"] = 404
    
    def detailEvent(self, json):
        """
        詳細イベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        p_dialog_id = self.getPOSTInputParam(None, 'dialog_id', '')

        self.jsonItem(json, True, getEXSMessage('C00_004'))
        tools = {}
        tools["edit"] = {}
        tools["edit"]["caption"] = getEXSMessage('C00_012')
        tools["edit"]["select"] = "not"
        tools["edit"]["url"] = '../' + self.modelmanager.getTableName() + '/edit'
        tools["edit"]["is_native_link"] = True
        tools["edit"]["dialog_tab_form"] = True
        tools["edit"]["id"] = self.getPOSTInputParam(None, 'id', '')
        tools["edit"]["dialog_id"] = p_dialog_id
        tools["edit"]["action_type"] = 'edit'
        json["tools"].append(tools)
    
    def editEvent(self, json):
        """
        編集イベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "edit_submit":
            self.setItem(json, True, getEXSMessage('C00_012'))
        else:
            self.jsonItem(json, True, getEXSMessage('C00_012'), 'edit_submit')
    
    def revupEvent(self, json):
        """
        リビジョンアップイベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "revup_submit":
            self.setItem(json, False, getEXSMessage('C00_002'), True)
        else:
            self.jsonItem(json, True, getEXSMessage('C00_002'), 'revup_submit', True)
    
    def copyEvent(self, json):
        """
        コピーイベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "copy_submit":
            self.setItem(json, False, getEXSMessage('C00_003'))
        else:
            self.jsonItem(json, True, getEXSMessage('C00_003'), 'copy_submit', False)

    def loadFileEvent(self, json):
        """
        ファイルアップロードイベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        obj = self.modelmanager.getModel()
        id = self.getPOSTInputParam(None, 'id', '')
        if id is not None:
            paramjson = {}
            paramjson['name'] = 'id'
            paramjson['type'] = 'hidden'
            paramjson['value'] = id
            paramjson['sort'] = 1
            json["items"].append(paramjson)

        table_name = self.modelmanager.getTableName()
        if table_name is not None:
            paramjson = {}
            paramjson['name'] = 'table_name'
            paramjson['type'] = 'hidden'
            paramjson['value'] = table_name
            paramjson['sort'] = 1
            json["items"].append(paramjson)
        self.jsonMode(json, "", "loadfile")

    def uploadEvent(self, json):
        """
        ファイルアップロードイベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "upload_submit":
            type_value = self.getPOSTInputParam(None, 'type', '')
            #json["url"] = '/' + URL_BASE + '/' + self.modelmanager.getTableName() + '/' + type_value + '/' + self.createExportArg()

        else:
            json["items"] = []
            exportjson = {}
            exportjson['name'] = 'uploadlabel'
            exportjson['sort'] = 1
            exportjson['caption'] = getEXSMessage('C00_011')
            exportjson['type'] = 'label'
            exportjson['label'] = 12
            exportjson['class'] = 'text-left'
            json["items"].append(exportjson)
            exportjson = {}
            exportjson['name'] = 'files'
            exportjson['sort'] = 1
            exportjson['caption'] = '<strong>ファイルを選択</strong>　または, ここにファイルをドロップ'
            exportjson['type'] = 'file'
            exportjson['label'] = 12
            exportjson['width'] = 12
            exportjson['multiple'] = True
            exportjson['class'] = "mikan-upload-drag"
            json["items"].append(exportjson)
            self.set_upload_param(json)
            self.jsonMode(json, getEXSMessage('C00_011'), "upload_submit")

    def set_upload_param(self, json):
        """
        エクスポート情報設定

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        id = self.getPOSTInputParam(None, 'tab_parent_id', '')
        if id is not None:
            paramjson = {}
            paramjson['name'] = 'id'
            paramjson['type'] = 'hidden'
            paramjson['value'] = id
            paramjson['sort'] = 1
            json["items"].append(paramjson)

        table_name = self.modelmanager.getTableName()
        if table_name is not None:
            paramjson = {}
            paramjson['name'] = 'table_name'
            paramjson['type'] = 'hidden'
            paramjson['value'] = table_name
            paramjson['sort'] = 1
            json["items"].append(paramjson)

        p_model = self.getPOSTInputParam(None, 'p_model', '')
        if p_model is not None:
            paramjson = {}
            paramjson['name'] = 'p_model'
            paramjson['type'] = 'hidden'
            paramjson['value'] = p_model
            paramjson['sort'] = 1
            json["items"].append(paramjson)

    def exportEvent(self, json):
        """
        エクスポートイベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "export_submit":
            target_id = self.createExportJsonFile()
            json["url"] = '/' + URL_BASE + '/' + self.modelmanager.getTableName() + '/file_export/?target=' + target_id
        else:
            json["items"] = []
            exportjson = {}
            exportjson['name'] = 'type'
            exportjson['sort'] = 1
            exportjson['caption'] = getEXSMessage('C00_009')
            exportjson['type'] = 'select'
            exportjson['label'] = 2
            exportjson['width'] = 8
            exportjson['required'] = True
            exportjson['value'] = 'excel'
            exportjson['select'] = {}
            exportjson['select']['excel'] = 'Excel'
            exportjson['select']['json'] = 'JSON'
            json["items"].append(exportjson)

            obj = self.modelmanager.getModel()
            exportjson = {}
            exportjson['name'] = 'col_select'
            exportjson['sort'] = 1
            exportjson['caption'] = "カラム選択"
            exportjson['type'] = 'multiple'
            exportjson['label'] = 2
            exportjson['width'] = 8
            exportjson['required'] = False
            exportjson['value'] = 'col_select'
            exportjson['select'] = {}
            for key, value in obj.MikanJsonData.items():
                if value["type"] != "hidden":
                    exportjson['select'][key] = value['caption']
            
            json["items"].append(exportjson)

            self.setExportParam(json)
            self.jsonMode(json, getEXSMessage('C00_006'), "export_submit")
    
    def createExportArgJson(self):
        """
        エクスポート引数作成

        Returns
        -------
        argstr : str
            エクスポート実行引数
        """
        argjson = {}
        obj = self.modelmanager.getModel()
        columns = self.jsonFormItems(obj.MikanJsonData, False, True)

        for value in columns:
            inp_val = self.getInputParam(value['name'], None)
            if inp_val is not None:
                argjson[value['name']] = inp_val[0]
        
        p_id = self.getInputParam('tab_parent_id', None)
        if p_id is not None:
            argjson['tab_parent_id'] = p_id[0]
        
        tab_name = self.getInputParam('tab_name', None)
        if tab_name is not None:
            argjson['tab_name'] = tab_name[0]
        
        isallview = self.getInputParam('isallview', None)
        if isallview is not None:
            argjson['isallview'] = isallview[0]

        return argjson
    
    def setExportParam(self, json):
        """
        エクスポート情報設定

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        obj = self.modelmanager.getModel()
        columns = self.jsonFormItems(obj.MikanJsonData, False, True)

        for value in columns:
            inp_val = self.getInputParam(value['name'], None)
            if inp_val is not None:
                paramjson = {}
                paramjson['name'] = value['name']
                paramjson['type'] = 'hidden'
                paramjson['value'] = inp_val[0]
                paramjson['sort'] = 1
                json["items"].append(paramjson)
        
        p_id = self.getInputParam('tab_parent_id', None)
        if p_id is not None:
            paramjson = {}
            paramjson['name'] = 'tab_parent_id'
            paramjson['type'] = 'hidden'
            paramjson['value'] = p_id[0]
            paramjson['sort'] = 1
            json["items"].append(paramjson)
        
        tab_name = self.getInputParam('tab_name', None)
        if tab_name is not None:
            paramjson = {}
            paramjson['name'] = 'tab_name'
            paramjson['type'] = 'hidden'
            paramjson['value'] = tab_name[0]
            paramjson['sort'] = 1
            json["items"].append(paramjson)
        
        isallview = self.getInputParam('isallview', None)
        if isallview is not None:
            paramjson = {}
            paramjson['name'] = 'isallview'
            paramjson['type'] = 'hidden'
            paramjson['value'] = isallview[0]
            paramjson['sort'] = 1
            json["items"].append(paramjson)
    
    def removeJson(self, json):
        """
        削除処理

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "remove_submit":
            obj = self.modelmanager.getTargetData(self.getPOSTInputParam(None, 'rid', ''))
            obj.delete(self.getRequest())

            json["status"]=200
            json["messages"]=[
                {
                    'text': getEXSMessage('I00_001'),
                    'type': "success",
                }
            ]
        else:
            self.jsonItem(json, True, getEXSMessage('C00_005'), "remove_submit")

    @transaction.atomic
    def removeFileEvent(self, json):
        """
        ファイル削除イベント

        Parameters
        ----------
        json : dict
            処理JSONデータ
        """
        m_value = self.getPOSTInputParam(None, 'm', '')
        if m_value == "remove_submit":
            index_value = self.getPOSTInputParam(None, 'index', '')
            if not index_value:
                obj = self.modelmanager.getTargetData(self.getPOSTInputParam(None, 'rid', ''))
                file_name = obj.file_name
                obj.delete()
                delete_file(file_name)
                json["status"] = 200
                json["messages"] = [
                    {
                        'text': getEXSMessage('I00_001'),
                        'type': "success",
                    }
                ]
            else:
                for x in range(0, int(index_value)):
                    rid_value = "rid{0}".format(str(x))
                    obj = self.modelmanager.getTargetData(self.getPOSTInputParam(None, rid_value, ''))
                    file_name = obj.file_name
                    obj.delete()
                    delete_file(file_name)
                json["status"] = 200
                json["messages"] = [
                        {
                                'text': getEXSMessage('I00_001'),
                                'type': "success",
                        }
                ]
        else:
            self.jsonItem(json, True, getEXSMessage('C00_005'), "remove_submit")
    
    def setItem(self, json, id, submit, is_revup = False):
        """
        フィールド変数作成

        Parameters
        ----------
        json : dict
            処理JSON情報
        
        id : str
            処理対象ID
        
        submit : str
            処理名
        
        Returns
        -------
        json : dict
            処理結果JSON情報
        """
        json["messages"] = []
        try:
            i = None
            model = self.modelmanager.getModel()
            if id:
                i = self.modelmanager.getTargetData(self.getPOSTInputParam(None, 'rid', ''))

            setvalue = {}
            is_id_attr = False
            is_rev = False
            for key, value in model.MikanJsonData.items():
                if 'did' == key:
                    is_id_attr = True
                if value["type"] != "hidden":
                    if not value["readonly"]:
                        p = self.getPOSTInputParam(None, key, '')
                        if p != '':
                            if value["type"] == "datetime":
                                p = p.replace('/', '-')
                                
                            if value["type"] == "date":
                                p = p.replace('/', '-')
                                month_str = '年月'
                                if value["caption"].rfind(month_str) == len(value["caption"]) - len(month_str):
                                    tdatetime = datetime.datetime.strptime(p, '%Y-%m')
                                    p = tdatetime.strftime('%Y-%m-%d')
                            if value['type'] == 'checkbox':
                                if p == 'true':
                                    p = '1'
                                else:
                                    p = '0'
                            
                            if value['type'] == 'select' or value['type'] == 'auto_suggest':
                                if 'rel_col' in value['select'] and value['select']['rel_col'] !=  const.MODEL_ATTR_RID_NAME:
                                    targetname = value['select']['orm']
                                    if targetname:
                                        select_obj = getClass(targetname)
                                        s_value = select_obj.objects.values(value['select']['rel_col']).filter(rid=p)
                                        if len(s_value) > 0:
                                            p = s_value[0][value['select']['rel_col']]
                        else:
                            p = None
                        
                        # Value set
                        if i == None:
                            if p:
                                setvalue[key] = p
                        else:
                            setvalue[key] = p


            if is_id_attr:
                setvalue['did'] = self.getPOSTInputParam(None, 'did', '')
                if setvalue['did'] == '':
                    setvalue['did'] = str(uuid.uuid4())
            if i == None:
                if model.is_revision:
                    if not 'revision' in setvalue:
                        setvalue['revision'] = DEFAULT_REVISION_VALUE

                i = model(**setvalue)
            else:
                for key, value in setvalue.items():
                    setattr(i, key, value)
            
            if model.is_revision:
                is_rev = True

            # revup 
            if is_rev and is_revup:
                condition_list = []
                param_list = []
                condition_list.append('did = %s')
                param_list.append(setvalue['did'])
                condition_list.append('revision = %s')
                param_list.append(setvalue['revision'])
                condition_list.append('delete_flag = %s')
                param_list.append('0')

                count = self.modelmanager.getModel().objects.extra(
                    where=condition_list,
                    params=param_list).count()
                
                if count > 0:
                    raise E00001Exception()

            i.save(self.getRequest())
            rel_id = self.getPOSTInputParam(None, 'rel_pid', '')
            rel_model = self.getPOSTInputParam(None, 'rel_pmodel', '')

            if rel_id != '' and rel_model != '':
                relmodel = getClass(rel_model)
                relmanager = ModelManager(relmodel)

                rel_target = relmanager.getTargetData(rel_id)
                rel_setvalue = {}
                for relkey, relvalue in relmodel.MikanJsonData.items():
                    if relvalue["type"] != "hidden":
                        if not relvalue["readonly"]:
                            p = str(getattr(rel_target, relkey))
                            if p != '':
                                if relvalue["type"] == "date":
                                    p = p.replace('/', '-')
                                    month_str = '年月'
                                    if value["caption"].rfind(month_str) == len(value["caption"]) - len(month_str):
                                        tdatetime = datetime.datetime.strptime(p, '%Y-%m')
                                        p = tdatetime.strftime('%Y-%m-%d')
                                
                                if relvalue['type'] == 'select':
                                    if relvalue['select']['orm'] == self.modelmanager.getTableName():
                                        p = getattr(i, relvalue['select']['rel_col'])
                                
                                if relvalue['type'] == 'checkbox':
                                    if p == 'true':
                                        p = '1'
                                    else:
                                        p = '0'
                                rel_setvalue[relkey] = p

                newrel = relmodel(**rel_setvalue)
                newrel.save()
        except:
            ex, ms, tb = sys.exc_info()
            json["messages"].append(str(ms))
            json["status"] = 500
        return self.jsonMode(json, submit)
    
    def getTabJSON(self, json):
        """
        タブ表示情報取得

        Parameters
        ----------
        json : dict
            処理JSON情報
        """
        m_name = self.modelmanager.getTableName()
        dialog_id = self.getPOSTInputParam(None, 'dialog_id', '')
        p_dialog_id = self.getPOSTInputParam(None, 'pid', '')
        ids = []
        if p_dialog_id != '':
            ids = p_dialog_id.split('__')

        contentid = p_dialog_id
        if contentid != '':
            contentid += '__'
        contentid += m_name + '_basic'

        json["tabs"] = []
        tools = {}
        # 基本情報
        tools["title"] = getEXSMessage('C00_008')
        tools["id"] = contentid
        tools["class"] = 'tab-base-class'
        tools["icon"] = 'fa-file-text-o'
        tools["active"] = True
        tools["basic"] = True
        tools["url"] = 'form'
        tools["script"] = {}
        tools["script"]["function"] = 'mikan.tab.create_table'

        tools["script"]["arg"] = '\'mikan_tab_content__' + contentid + '\', \'../' + m_name + '/detail\' , \'' + self.getPOSTInputParam(None, 'id', '') + '\''
        json["tabs"].append(tools)

        filelist = self.modelmanager.getFileObjList()
        for rel in filelist:
            relmodel = filelist[rel]['model']
            tools = {}
            tools["title"] = relmodel._meta.verbose_name
            tools["id"] = contentid + '_file'
            tools["icon"] = 'fa-file-text-o'
            tools["basic"] = True
            tools["url"] = 'form'
            tools["script"] = {}
            tools["script"]["function"] = 'mikan.tab.create_list'
            tools["script"]["arg"] = '\'mikan_tab_content__' + contentid + '_file' + '\', \'/master/' + rel + '/tabfileform/\', \'/master/' + rel + '/list/\''
            json["tabs"].append(tools)

        reldata = None
        if len(ids) != 0:
            pmodel = getClass(ids[len(ids) - 1])
            for relitem in pmodel.RelationList:
                if self.modelmanager.getTableName() == relitem['name']:
                    reldata = relitem

        rellist = self.modelmanager.getRelObjList()
        tab_contentid = p_dialog_id
        if tab_contentid != '':
            tab_contentid += '__'
        tab_contentid += dialog_id
        for rel in rellist:
            is_skip = False
            if rellist[rel]['middle']:
                for pitem in ids:
                    if rel == pitem:
                        is_skip = True
                        break

            if not is_skip:
                relmodel = rellist[rel]['model']
                tools = {}
                tools["title"] = relmodel._meta.verbose_name
                tools["id"] = rel
                tools["icon"] = 'fa-file-text-o'
                tools["url"] = 'form'
                tools["script"] = {}
                tools["script"]["function"] = 'mikan.tab.create_list'
                tools["script"]["arg"] = '\'mikan_tab_content__' + tab_contentid + '__' + rel + '\', \'/master/' + rel + '/tabform/\', \'/master/' + rel + '/list/\''
                json["tabs"].append(tools)
        
        if reldata != None:
            if reldata['middle']:
                tab_contentid = p_dialog_id
                if tab_contentid != '':
                    tab_contentid += '__'
                tab_contentid += dialog_id
                for jsonitem in self.modelmanager.getModel().MikanJsonData.values():
                    if jsonitem['type'] == 'select':
                        if jsonitem['select']['orm'] != ids[len(ids) - 1]:
                            tools = {}
                            modelname = jsonitem['select']['orm']
                            selectmodel = getClass(modelname)
                            tools["title"] = selectmodel._meta.verbose_name
                            tools["id"] = modelname
                            tools["icon"] = 'fa-file-text-o'
                            tools["url"] = 'form'
                            tools["script"] = {}
                            tools["script"]["function"] = 'mikan.tab.create_list'
                            tools["script"]["arg"] = '\'mikan_tab_content__' + tab_contentid + '__' + modelname + '\', \'/master/' + modelname + '/tabform/\', \'/master/' + modelname + '/list/\''
                            json["tabs"].append(tools)
    
    def getMiddleTableData(self, reldata):
        """
        中間テーブル情報取得

        Parameters
        ----------
        reldata : dict
            リレーション情報
        
        Returns
        -------
        resultdata : dict
            中間テーブル情報
        """
        resultdata = []
        middlemodel = reldata['middle_model']
        for rel in middlemodel:
            if middlemodel[rel]['middle']:
                resultdata.extend(self.getMiddleTableData(middlemodel[rel]))
            else:
                resultdata.append(middlemodel[rel])
        return resultdata

    def getFormJSON(self, json):
        """
        フォーム表示情報取得

        Parameters
        ----------
        json : dict
            処理JSON情報
        """
        obj = self.modelmanager.getModel()

        tools = {}
        tools["create"] = {}
        # 新規作成
        tools["create"]["caption"] = getEXSMessage('C00_001')
        tools["create"]["select"] = "not"
        tools["create"]["url"] = 'create'
        json["tools"].append(tools)

        if obj.is_revision:
            tools = {}
            tools["revup"] = {}
            # 改定
            tools["revup"]["caption"] = getEXSMessage('C00_002')
            tools["revup"]["select"] = "single"
            tools["revup"]["url"] = 'revup'
            json["tools"].append(tools)
        else:
            tools = {}
            tools["copy"] = {}
            # コピーして新規作成
            tools["copy"]["caption"] = getEXSMessage('C00_003')
            tools["copy"]["select"] = "single"
            tools["copy"]["url"] = 'copy'
            json["tools"].append(tools)
        tools = {}
        tools["edit"] = {}
        # 詳細
        tools["edit"]["caption"] = getEXSMessage('C00_004')
        tools["edit"]["select"] = "single"
        tools["edit"]["url"] = 'edittab'
        tools["edit"]["dialog_tab"] = True
        tools["edit"]["dialog_id"] = self.modelmanager.getTableName()
        json["tools"].append(tools)
        tools = {}
        tools["remove"] = {}
        # 削除
        tools["remove"]["caption"] = getEXSMessage('C00_005')
        tools["remove"]["select"] = "single"
        tools["remove"]["url"] = 'remove'
        tools["remove"]["delete"] = True
        json["tools"].append(tools)
        tools = {}
        tools["export"] = {}
        # エクスポート
        tools["export"]["caption"] = getEXSMessage('C00_006')
        tools["export"]["select"] = "not"
        tools["export"]["url"] = 'export'
        tools["export"]["search"] = True
        json["tools"].append(tools)

        json["notsearch"] = True

        obj = self.modelmanager.getModel()
        json["items"] = self.jsonFormItems(obj.MikanJsonData, True)
        # 検索
        self.jsonMode(json, getEXSMessage('C00_010'), 'list')
    
    def getTabFormJSON(self, json):
        """
        タブフォーム表示情報取得

        Parameters
        ----------
        json : dict
            処理JSON情報
        """

        m_name = self.modelmanager.getTableName()

        p_dialog_id = self.getPOSTInputParam(None, 'dialog_id', '')
        tools = {}
        tools["create"] = {}
        # 新規追加
        tools["create"]["caption"] = getEXSMessage('C00_007')
        tools["create"]["select"] = "not"
        tools["create"]["url"] = '../' + m_name + '/createtabform'
        tools["create"]["dialog_tab_form"] = True
        tools["create"]["action_type"] = 'new'
        tools["create"]["dialog_id"] = p_dialog_id
        json["tools"].append(tools)
        tools = {}
        tools["edit"] = {}
        # 詳細
        tools["edit"]["caption"] = getEXSMessage('C00_004')
        tools["edit"]["select"] = "single"
        tools["edit"]["url"] = '../' + m_name + '/edittab'
        tools["edit"]["dialog_tab_detail"] = True
        tools["edit"]["dialog_id"] = self.modelmanager.getTableName()
        tools["edit"]["parent_dialog_id"] = p_dialog_id
        json["tools"].append(tools)
        tools = {}
        tools["remove"] = {}
        # 削除
        tools["remove"]["caption"] = getEXSMessage('C00_005')
        tools["remove"]["select"] = "single"
        tools["remove"]["url"] = '../' + m_name + '/remove'
        tools["remove"]["delete"] = True
        tools["remove"]["dialog_tab_form"] = True
        tools["remove"]["action_type"] = 'delete'
        tools["remove"]["dialog_id"] = p_dialog_id
        json["tools"].append(tools)
        tools = {}
        tools["export"] = {}
        # エクスポート
        tools["export"]["caption"] = getEXSMessage('C00_006')
        tools["export"]["select"] = "not"
        tools["export"]["url"] = '../' + m_name + '/export'
        tools["export"]["search"] = True
        tools["export"]["dialog_tab_form"] = True
        tools["export"]["action_type"] = 'export'
        tools["export"]["dialog_id"] = p_dialog_id
        json["tools"].append(tools)

        isallview = self.getPOSTInputParam(None, 'isallview', 'false')

        if isallview == 'true':
            json["isall"] = True
        else:
            json["isall"] = False
    
    def getTabFileFormJSON(self, json):
        """
        タブファイルフォーム表示情報取得

        Parameters
        ----------
        json : dict
            処理JSON情報
        """
        m_name = self.modelmanager.getTableName()

        p_dialog_id = self.getPOSTInputParam(None, 'dialog_id', '')
        id = self.getPOSTInputParam(None, 'id', '')
        tools = {}
        tools["upload"] = {}
        # ファイルアップロード
        tools["upload"]["caption"] = getEXSMessage('C00_011')
        tools["upload"]["select"] = "not"
        tools["upload"]["url"] = '../' + m_name + '/upload'
        tools["upload"]["dialog_tab_form"] = True
        tools["upload"]["action_type"] = 'upload'
        tools["upload"]["dialog_id"] = p_dialog_id
        tools["upload"]["id"] = id
        json["tools"].append(tools)

        tools = {}
        tools["remove"] = {}
        # 削除
        tools["remove"]["caption"] = getEXSMessage('C00_005')
        tools["remove"]["select"] = "both"
        tools["remove"]["url"] = '../' + m_name + '/removefile'
        tools["remove"]["delete"] = True
        tools["remove"]["dialog_tab_form"] = True
        tools["remove"]["action_type"] = 'delete'
        tools["remove"]["dialog_id"] = p_dialog_id
        json["tools"].append(tools)

        json["isall"] = False
        json["isallview"] = False

    def getListJSON(self, json):
        """
        テーブル情報取得

        Parameters
        ----------
        json : dict
            処理JSON情報
        """
        obj = self.modelmanager.getModel()

        name="search"

        if self.request.POST.get("tab_name", False):
            name = self.request.POST.get("tab_name", False)

        json["name"] = name
        json["header"] = {}
        json["header"]["row"] = 1
        json["header"]["select"] = True
        json["header"]["columns"] = self.jsonFormItems(obj.MikanJsonData, False, True, False, False, True)
        json["columns"] = {}
        json["columns"]["multiselect"] = False
        json["status"] = 200
        json["serverdata"] = {}
        json["serverdata"]["url"] = '/' + URL_BASE + '/' + obj._meta.db_table + '/loadpage'
        json["serverdata"]["type"] = 'POST'
        json['lengthNoMenu'] = True
    
    def getLoadJSON(self, json):
        """
        テーブルデータ情報取得

        Parameters
        ----------
        json : dict
            処理JSON情報
        """
        json.clear()
        json['draw'] = int(self.getInputParam('draw', None)[0])
        startstr = self.getInputParam('start', None)
        limitstr = self.getInputParam('length', None)
        order_no = self.getInputParam('order[0][column]', None)
        order_dir = self.getInputParam('order[0][dir]', None)
        search_value = self.getInputParam('search[value]', None)
        mikan_start = self.getInputParam('mikan_start', None)

        order_by = {}
        order_by['column'] = order_no
        order_by['dir'] = order_dir
        start = None

        if not search_value is None and search_value[0] != '':
            if mikan_start != None:
                start = int(mikan_start[0])
        else:
            if startstr != None:
                start = int(startstr[0])
        
        limit = None
        if limitstr != None:
            if int(limitstr[0]) != -1:
                limit = int(limitstr[0])
        count = []
        tabledata = self.getListItems(start=start, limit=limit, order=order_by, count=count)

        json['recordsTotal'] = count[0]

        tablevalues = []
        ridlist = []
        self.convertLoadValue(search_value, tabledata, tablevalues, ridlist, count=count)
        json['recordsFiltered'] = count[0]

        if json['recordsTotal'] != json['recordsFiltered']:
            json['recordsTotal'] = len(tabledata)

        json['riddata'] = ridlist
        json['data'] = tablevalues

    def convertLoadValue(self, search_value, targetlist, tablevalues, ridlist, count=[]):
        """
        テーブル情報を表示用に変換

        Parameters
        ----------
        search_value : dict
            検索条件情報
        
        targetlist : dict
            処理対象情報
        
        tablevalues : list
            データカラム情報リスト
        
        ridlist : list
            データIDリスト
        
        count : list
            データ件数リスト
        """
        obj = self.modelmanager.getModel()
        columns = self.jsonFormItems(obj.MikanJsonData, False, True, isTopCreatedate=True)

        for item in targetlist:
            vals = []
            colindex = 0
            for val in item:
                colval = columns[colindex]
                if colval["type"] != "hidden":
                    vals.append(str(val['v']))
                colindex += 1
            
            isadd = True
            if not search_value is None and search_value[0] != '':
                count.clear()
                isadd = False
                for s in vals:
                    if search_value[0] in str(s):
                        isadd = True
                        break
            if not isadd:
                continue
            
            tablevalues.append(vals)
            ridlist.append(item[0]['v'])
        
        if len(count) == 0:
            count.append(len(tablevalues))



    def getListItems(self, start=None, limit=None, order=None, count=[]):
        """
        検索データ取得

        Parameters
        ----------
        start : int or None, default None
            検索スタート数
        
        limit : int or None, default None
            最大検索数
        
        order : dict or None, default None
            ソート情報
        
        count : list
            検索データ数
        
        Returns
        -------
        result : list
            取得データリスト
        """
        records = []
        obj = self.modelmanager.getModel()
        columns = self.jsonFormItems(obj.MikanJsonData, True, True, False, False, True)
        condition_list = []
        param_list = []
        order_no = -1
        order_str = ''
        if (order) :
            order_no = int(order['column'][0])
            if order['dir'][0] != 'asc':
                order_str = '-'
        
        column_index = 0
        is_company_col = False
        for value in columns:
            if value['name'] == const.MODEL_ATTR_ORGANIZATION_ID:
                is_company_col = True
                continue
            
            if value["type"] != "hidden":
                if order_no != -1:
                    if order_no == column_index + 1:
                        order_str += value['name']
                inp_val = self.getInputParam(value['name'], None)
                if inp_val is not None:
                    if 'range' in value and value["range"] == True:
                        range_value = inp_val[0]
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
                
                column_index += 1
        
        # 組合カラムが存在する場合は検索条件に含める
        if is_company_col:
            condition_list.append(const.MODEL_ATTR_ORGANIZATION_ID + ' = %s')
            param_list.append(self.company_id())
        
        p_id = self.getInputParam('tab_parent_id', None)
        if p_id is not None:
            isallview = self.getInputParam('isallview', None)
            if isallview is not None and isallview[0] == 'false':
                tab_name = self.getInputParam('tab_name', None)
                tab_names = tab_name[0].split('__')
                p_name = tab_names[len(tab_names) - 2]
                for key, jsonitem in self.modelmanager.getModel().MikanJsonData.items():
                    if jsonitem['type'] == 'select' or jsonitem['type'] == 'auto_suggest':
                        if jsonitem['select']['orm'] == p_name:
                            p_model = getClass(p_name)
                            p_manager = ModelManager(p_model)
                            targetdata = p_manager.getTargetData(p_id[0])
                            rel_val = getattr(targetdata, jsonitem['select']['rel_col'])
                            condition_list.append(key + ' = %s')
                            param_list.append(rel_val)

        order_list = None
        if order_str != '':
            order_list = [order_str]

        records = self.modelmanager.searchModel(condition_list=condition_list, param_list=param_list, order_list=order_list, start=start, limit=limit)
        if not records.exists():
            records = []
        count.append(self.modelmanager.countModel(condition_list=condition_list, param_list=param_list))
        return self.modelmanager.convertListItems(records, columns)

    def getTargetModel(self):
        """
        対象モデル取得

        Returns
        -------
        obj : MikanModel
            モデルデータ
        """
        uri = self.kwargs[VIEW_ARG]
        names = uri.split('/')
        if len(names) > 0:
            obj = None
            if names[0] == '':
                obj = getClass(names[1])
                if not obj:
                    obj = getHistoryClass(names[1])
            else:
                obj = getClass(names[0])
                if not obj:
                    obj = getHistoryClass(names[0])
            return obj
        return None

    def getAction(self):
        """
        アクション名取得

        Returns
        -------
        obj : str
            アクション名
        """
        uri = self.kwargs[VIEW_ARG]
        names = uri.split('/')
        if len(names) > 1:
            obj = None
            if names[0] == '':
                obj = names[2]
            else:
                obj = names[1]
            return obj
        return None

    def initMaster(self):
        """
        マスター初期化実行
        """
        modelobj = self.getTargetModel()
        if modelobj == None:
            raise Http404
        self.viewaction = self.getAction()
        self.modelmanager = ModelManager(modelobj)
        
    #########
    # self.getConfigJsonQR(self) - 機能：configのQRコード読込機能
    # Input: File config xml 
    # (<?xml version="1.0" encoding="UTF-8"?><config><input><label>{data}</label><regex>{regex}</regex></input><input>...</input></config>)
    # Output json: {"listPos": ["{data}",...]}
    #########
    def getConfigJsonQR(self):
        config_name = self.modelmanager.getTableName()
        config_file = os.path.abspath(os.path.dirname(config.__file__)) + '/xml/qr_reader/' + config_name + '.xml'
        data_list = []
        data_regex = []

        try:
            if(os.path.exists(config_file)):
                xmldoc = minidom.parse(config_file)
                inputLabel = xmldoc.getElementsByTagName('label')
                inputRegex = xmldoc.getElementsByTagName('regex')
                for s in inputLabel:
                    if( hasattr(s.firstChild, 'nodeValue') ):
                        data_list.append(s.firstChild.nodeValue)
                    else:
                        data_list.append('null')
                for x in inputRegex:
                    if( hasattr(x.firstChild, 'nodeValue') ):
                        regex = x.firstChild.nodeValue
                        if( regex.isdigit() ):
                            data_regex.append(regex)
                        else:
                            data_regex = regex
                            break
                    else:
                        data_list.append('null')
        except:
            data_list = "Have an error in config file!"

        json_QR = {
            "listPos": data_list,
            "regexData": data_regex
        }
        return json.dumps(json_QR, ensure_ascii=False)

    def getTemplate(self):
        """
        使用テンプレートパス取得
        
        Returns
        -------
        str : str
            テンプレートパス
        """
        return 'master/master.html'

    def doJS(self):
        """
        JS定義
        
        Returns
        -------
        list : list
            使用JSパス
        """
        js_list = super(MasterView, self).doJS()
        js_list.extend(['/js/master/mikan_custom.tab.js', '/js/master/mikan_custom.html.js', '/js/plugins/jquery.autoKana.js'])
        return js_list

    def doCSS(self):
        """
        CSS定義
        
        Returns
        -------
        list : list
            使用CSSパス
        """
        css_list = super(MasterView, self).doCSS()
        css_list.extend(['/css/mikan_custom.tab.css'])
        return css_list

    def doFootJSCode(self):
        """
        FooterのJSコード定義

        """
        if self.testFlag:
            return ['mikan.tab.test.dialog_form("test_col", "' + self.viewurl + 'test");']
        else :
            return ['mikan.html.table.create_form_list("search", "' + self.viewurl + 'form", "' + self.viewurl + 'list");','var ConfigPos='+self.getConfigJsonQR()]

    def jsonItem(self, json=None, id=False, submit=None, mode=None, rev=False):
        """
        対象データ情報取得

        Parameters
        ----------
        json : dict
            処理情報JSON
        """
        if mode == None:
            json["edit"] = False
        obj = self.modelmanager.getModel()
        json["title"] = self.modelmanager.getModelName() + " "  + submit
        json["items"] = self.jsonFormItems(obj.MikanJsonData, False, False, mode != None)

        if id:
            self.modelmanager.setTargetModelDataJson(json, self.getPOSTInputParam(None, 'id', ''), rev)

        p_id = self.getPOSTInputParam(None, 'tab_parent_id', '')
        d_id = self.getPOSTInputParam(None, 'dialog_id', '')
        ids = []
        if d_id:
            ids = d_id.split('__')
        reldata = None
        middledata = None
        if len(ids) >= 1:
            pmodel = None
            if len(ids) == 1:
                pmodel = getClass(ids[len(ids) - 1])
            else:
                pmodel = getClass(ids[len(ids) - 1])
            for relitem in pmodel.RelationList:
                if self.modelmanager.getTableName() == relitem['name']:
                    reldata = relitem
            
            for middleitem in obj.RelationList:
                if ids[len(ids) - 1] == middleitem['name']:
                    middledata = middleitem
                    break
        if p_id != '':
            if reldata != None:
                pmanager = ModelManager(pmodel)
                pmodeldata = pmanager.getTargetData(p_id)
                for item in json["items"]:
                    if reldata['key'] == item['name']:
                        item['edit'] = False
                        item['value'] = getattr(pmodeldata, reldata['pkey'])
        
        if middledata != None:
            if middledata['middle']:
                middlejson = {}
                middlejson['caption'] = 'rel_parent_id'
                middlejson['label'] = '2'
                middlejson['name'] = 'rel_pid'
                middlejson['sort'] = '0'
                middlejson['type'] = 'hidden'
                middlejson['value'] = p_id
                json["items"].append(middlejson)

                middlejson = {}
                middlejson['caption'] = 'rel_parent_model'
                middlejson['label'] = '2'
                middlejson['name'] = 'rel_pmodel'
                middlejson['sort'] = '0'
                middlejson['type'] = 'hidden'
                middlejson['value'] = middledata['name']
                json["items"].append(middlejson)

        self.jsonMode(json, submit, mode)

    def getAutoSgJSON(self, json):
        """
        自動補完情報取得

        Parameters
        ----------
        json : dict
            処理情報JSON
        """
        input_str  = self.request.POST.get("v", False)

        obj = self.modelmanager.getModel()
        json["items"] = self.jsonFormItems(obj.MikanJsonData, True)

        res_list=[]
        id_name = 'rid'
        if 'did' in obj.MikanJsonData:
            id_name = 'did'
        
        where_list = []
        where_list.append('delete_flag = 0')
        is_rev = False
        if 'revision' in obj.MikanJsonData:
            is_rev = True
            nowdate = datetime.datetime.now().strftime("%Y/%m/%d")
            where_list.append('apply_start_date <= \'%s\'' % nowdate)
            where_list.append('apply_end_date >= \'%s\'' % nowdate)
        
        if const.MODEL_ATTR_ORGANIZATION_ID in obj.MikanJsonData:
            where_list.append('%s = \'%s\'' % (const.MODEL_ATTR_ORGANIZATION_ID, self.company_id(),))
        
        select_list = [id_name, 'display_name']

        if input_str == '*' or input_str == ' ' or input_str == '　':
            targetdatas = []
            if is_rev:
                targetdatas = self.modelmanager.getTargetRevMergeData(where_list, select_list)
            else:
                targetdatas = self.modelmanager.executeSQLData(where_list, select_list=select_list)
            for rowdata in targetdatas:
                jsonvalue = {}
                jsonvalue['value'] = str(rowdata[id_name])
                jsonvalue['caption'] = rowdata['display_name']
                if not jsonvalue['caption']:
                    jsonvalue['caption'] = str(rowdata[id_name])

                res_list.append(jsonvalue)
        else:
            where_list.append('(rid LIKE \'%%%s%%\' OR display_name LIKE \'%%%s%%\')' % (input_str,input_str,))
            if is_rev:
                targetdatas = self.modelmanager.getTargetRevMergeData(where_list, select_list)
            else:
                targetdatas = self.modelmanager.executeSQLData(where_list, select_list=select_list)
            for rowdata in targetdatas:
                jsonvalue = {}
                viewstr = rowdata['display_name']
                if not viewstr:
                    viewstr = str(rowdata[id_name])

                if input_str == viewstr:
                    jsonvalue['value'] = str(rowdata[id_name])
                    jsonvalue['caption'] = viewstr
                    res_list.append(jsonvalue)
                elif (input_str) in (viewstr) :
                    jsonvalue['value'] = str(rowdata[id_name])
                    jsonvalue['caption'] = viewstr
                    res_list.append(jsonvalue)

        json["items"] = res_list
    
    def createExportJsonFile(self):
        type_value = self.getInputParam('type', '')
        col_select = self.getInputParam('col_select', None)
        arg_json = self.createExportArgJson()

        # request file create
        tmpdir = tempfile.gettempdir()
        file_id = str(uuid.uuid4())
        json_path = os.path.join(tmpdir, file_id + '.json')

        set_json = {}
        set_json['type'] = type_value[0]
        set_json['arg'] = arg_json

        if col_select:
            if col_select[0]:
                select_list = col_select[0].split(',')
                set_json['select_col'] = select_list

        with open(json_path, 'w') as f:
            json.dump(set_json, f, ensure_ascii=False)
        
        return file_id
