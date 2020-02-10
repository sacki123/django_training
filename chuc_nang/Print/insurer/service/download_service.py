import sys
import os
import urllib
import csv

from openpyxl import Workbook, load_workbook
from django.http import HttpResponse
from zm.common import const as zm_const
from zm.common.file.file_manage import FileManage
from exs_main.util.file import getMimeType

DEF_UTF8 = 'UTF-8'
DEF_CSV_EXTENSION = '.csv'
DEF_CONTENT_TYPE_FORMAT = '%s; %s'
DEF_CHARA_SET = 'charset=UTF-8-sig'
DEF_CONTENT_DISPOSITION_FORMAT = 'attachment; filename*=UTF-8\'\'%s'
RES_CONTENT_DISPOSITION_STR = 'Content-Disposition'

class DownloadService:

    def create_header(self, is_print = False):
        header = []
        header.append('開設区分')
        header.append('適用開始日')
        header.append('適用終了日')
        header.append('種別')
        header.append('法制')
        header.append('県')
        header.append('保険者番号')
        header.append('保険者名')
        header.append('部署名')
        header.append('支払区分')
        header.append('審査会')
        header.append('出力Ⅰ')
        header.append('出力Ⅱ')
        header.append('出力')
        header.append('分割')
        header.append('添付')
        if is_print:
            header.append('作成日付')
        return header

    def exportCSV(self, data_list, file_name, sheet_name=None):
        manage_file = FileManage()
        file_path, path_download = manage_file.file_created(file_name)
        
        wb = Workbook()
        sheet = wb.active
        for i in data_list:
            sheet.append(i)
        wb.save(file_path)

        return path_download    


    # def exportCSV(self, data_list, file_name):
    #     mimetype = getMimeType('csv')
    #     response = HttpResponse(content_type=DEF_CONTENT_TYPE_FORMAT % (mimetype, DEF_CHARA_SET,))
    #     filename = urllib.parse.quote((file_name + DEF_CSV_EXTENSION).encode(DEF_UTF8))
    #     response[RES_CONTENT_DISPOSITION_STR] = DEF_CONTENT_DISPOSITION_FORMAT % (filename,)
    #     writer = csv.writer(response)
    #     for data in data_list:
    #         writer.writerow(data)
    #     return response    