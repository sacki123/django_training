import os
import sys
import traceback
import uuid
import json
import glob
import datetime

from zm.page.abstract_page import AbstractPage
from zm.common.file.read_files import file_tcd_to_dict
from zm.page.insurer.logic.download_logic import DownloadLogic
VIEW_FORM_ID = "search"
VIEW_SEARCH_FORM_ID = 'search_value_dev'
MIKAN_JSON_KEY_NAME = 'name'
MIKAN_JSON_KEY_TYPE = 'type'
MIKAN_JSON_KEY_CAPTION = 'caption'
MIKAN_JSON_KEY_VALUE = 'value'
MIKAN_JSON_KEY_LABEL = 'label'
MIKAN_JSON_KEY_WIDTH= 'width'
MIKAN_JSON_KEY_SELECT = 'select'
MIKAN_JSON_KEY_FORMGROUP = 'formgroup'
MIKAN_JSON_KEY_ONCHANGE = 'onchange'
MODEL_TYPE_SELECT = 'select'
MODEL_TYPE_DATE = 'date'
TCD_file = [('medical_0002_tcd',''), ('insurance_0001_tcd','')]
INSURER_000 = 'INSURER_000'
class InsurerJsonSearchView(AbstractPage):

    def getActionEvent(self):
        """
        アクションイベント情報取得
        
        Returns
        -------
        action : dict
            アクションイベント情報
        """
        action = {}
        action['form'] = 'setSelectFormItem'
        action['print'] = 'printPDF'
        action['search_form'] = 'searchformEvent'
        action['csv_export'] = 'exportCSV'

        return action

    def getSiteJson(self):
        """
        JSON初期値情報取得
        
        Returns
        -------
        json : dict
            Json初期情報
        """
        json = {}
        json['title'] = ""
        json['status'] = 200
        json['button'] = {}
        json['button']['submit'] = {}
        json['button']['submit']['caption'] = ""
        json['tools'] = []
        json['items'] = {}

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
        self.view_action = self.getAction()
        action_data = self.getActionEvent()
        if self.view_action in action_data:
            return getattr(self, action_data[self.view_action])(json)

        return json

    def doPageHtml(self):
        """
        ページ表示実行処理
        
        Returns
        -------
        str : str
            空文字
        """
        self.config['search_id'] = VIEW_FORM_ID
        self.config['search_form_id'] = VIEW_SEARCH_FORM_ID
        return ''          

    def doJS(self):
        """
        JS定義
        
        Returns
        -------
        list : list
            使用JSパス
        """
        return [
            '/js/common/file.js',
            '/js/common/jquery.fileDownload.js',
            '/js/common/message.js',
            '/js/common/utils.js',
            '/js/insurer/insurer_search.js'
            ]   

    def doFootJSCode(self):
        """
        FooterのJSコード定義

        """
        return ['master.search.select_form("search", "form");']    

    def getTemplate(self):
        """
        使用テンプレートパス取得
        
        Returns
        -------
        str : str
            テンプレートパス
        """
        return 'insurer/insurer_search.html'   

    def setSelectFormItem(self, json):
        """
        選択ItemをJsoinに設定

        Parameters
        ----------
        json : dict
            処理JSON情報
        """
        datalist = []
        datalist = self.getTCDjsonfile()

        json['items'] = []
        item = {}
        item[MIKAN_JSON_KEY_NAME] = "group_select"
        item[MIKAN_JSON_KEY_CAPTION] = "開設区分"
        item[MIKAN_JSON_KEY_TYPE] = 'select'
        item[MIKAN_JSON_KEY_VALUE] = '0'
        item[MIKAN_JSON_KEY_LABEL] = 2
        item[MIKAN_JSON_KEY_WIDTH] = 4
        item[MIKAN_JSON_KEY_SELECT] = datalist[0]
        item[MIKAN_JSON_KEY_ONCHANGE] = ""
        json['items'].append(item)
        item = {}
        item[MIKAN_JSON_KEY_NAME] = "select"
        item[MIKAN_JSON_KEY_CAPTION] = "種別"
        item[MIKAN_JSON_KEY_TYPE] = 'select'
        item[MIKAN_JSON_KEY_VALUE] = '0'
        item[MIKAN_JSON_KEY_LABEL] = 2
        item[MIKAN_JSON_KEY_WIDTH] = 4
        item[MIKAN_JSON_KEY_SELECT] = datalist[1]
        item[MIKAN_JSON_KEY_ONCHANGE] = ""
        json['items'].append(item)

        return json
        
    def getTCDjsonfile(self):
        data_list = []
        for i in TCD_file:
            data = file_tcd_to_dict(i)
            data_list.append(data)    
        return data_list

    def exportCSV(self, json):
        request = self.getRequest()
        insurer_name = INSURER_000
        user_inputs = self.get_input_users(request)
        json_result = DownloadLogic().data_output(user_inputs)
        return json_result

    def printPDF(self, json):
        request = self.getRequest()
        user_inputs = self.get_input_users(request)
        json_result = DownloadLogic().data_output(user_inputs, is_print = True)   
        final_results = DownloadLogic().generate_print_json(request, json_result)
        
    def get_input_users(self, request):
        form_data = request.POST
        user_inputs = {
            'opening_class_tcd': form_data.get('opening_class_tcd', ''),
            'insurance_category_tcd': form_data.get('insurance_category_tcd', ''),
            'action': form_data.get('action', '')
        }
        return user_inputs