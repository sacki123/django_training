#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
帳票(PDF) パッケージ


"""

__title__ = '帳票(PDF) パッケージ'
__author__ = "ExpertSoftware Inc."
__status__ = "develop"
__version__ = "0.0.0_0"
__date__ = "2018/07/27"
__license__ = ''
__desc__ = '%s Ver%s (%s)' % (__title__, __version__, __date__)

# ------------------------------------------------------------
# Import Section
# ------------------------------------------------------------
# Python
import os
import io
import re
import json
import traceback
from abc import ABC, abstractmethod
from logging import getLogger

import requests
from selenium import webdriver
from pandas.io.html import read_html
from webdriver_manager.chrome import ChromeDriverManager

# zen
from zen.pdf import AbstractCommand
from zen.db.mongo import ZenMongoDB
from zen.pdf import constant

# Pypdf2
from PyPDF2 import PdfFileMerger
from bson.objectid import ObjectId

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------
log = getLogger(__name__)
SUCCESS_CODE = "0" 
ERROR_CODE = "9"
HTTP_SUCCESS = 200

# ------------------------------------------------------------
# Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
# Class Section
# ------------------------------------------------------------
class PrintsCommand(AbstractCommand):
    """
    PDF印刷クラス
    """

    def __init__(self, config, unit, command="Prints"):
        """
        コンストラクタ
        """
        super().__init__(config, unit, command)

    def onExecute(self):
        """
        処理実行

        @return 終了コード
        """
        # ログ
        log.debug(self)

        # メイン処理
        # exit_code = self.func.execute(self)
        if self.sub_command == "print":
            exit_code = self.printer_request.print_request(self.printer_request.print_mongodb.get("FILE_PATH")).get("exit_code")

        elif self.sub_command == "progressing":
            exit_code = self.printer_request.get_job_request().get("exit_code")
        elif self.sub_command == "history":
            exit_code = self.printer_request.get_history_request().get("exit_code")
        elif self.sub_command == "error":
            exit_code = self.printer_request.get_error_request().get("exit_code")
        else:
            exit_code = 0
        return exit_code

    def onPrepare(self):
        """
        処理前準備
        @return 終了コード
        """
        # ログ
        log.debug(self)
        try:
            self.printer_request = RequestPrinter(self.mongo_id, self.ip_address)
        except:
            # 例外処理
            log.error(traceback.format_exc())
        return 1


class CommonFiles(ABC):
    """
    Include common attributes and function of printed files
    """

    def __init__(self, module, category, kinoubango, template_dir=False):
        """
        Initial common object
        :param module: Module name is imported to implement
        :param category: category name
        :param kinoubango: function number
        """
        self.module = module
        self.category = category
        self.kinoubango = kinoubango
        self.template_dir = template_dir

    @abstractmethod
    def setup_files_print(self, directory, template_dir=False):
        raise NotImplementedError()

    @abstractmethod
    def print_files(self):
        raise NotImplementedError()


class PDFPrint(CommonFiles):
    """
    PDF printed files objects
    """

    def __init__(self, module, category, kinoubango, template_dir=False):
        """
        Initial object
        :param module: Module name is imported to implement
        :param category: category name
        :param kinoubango: function number
        """
        super().__init__(module, category, kinoubango, template_dir)

    def merger_files_pdf(self, directory):
        """
        Getting all pdf files then merging documents page by page
        :param directory: Template directory or output directory
        :return: Single pdf file
        """
        # ログ
        log.debug(self)
        try:
            files_list = list()
            objs = os.listdir(directory)
            for obj in objs:
                full_path = os.path.join(directory, obj)
                if os.path.isfile(full_path) and re.match(r'^(%s_)\d{3}(.pdf)$' % self.module, str(obj)):
                    files_list.append(full_path)
            if len(files_list) == 0:
                log.error("There no output pdf file in module %s" % self.module)
            else:
                merger = PdfFileMerger()
                for pdf in files_list:
                    merger.append(pdf)
                out_pdf = constant.OUTPUT_PDF_FILE_DIRECTORY + "/%s/%s.pdf" % (self.category, self.module)
                merger.write(out_pdf)
        except:
            # 例外処理
            log.error(traceback.format_exc())
            raise

    def setup_files_print(self, directory, template_dir=False):
        """
        setup file path to print
        :return: Single pdf file path to print
        """
        if self.template_dir:
            return constant.TEMPLATE_FILE_DIRECTORY + "/%s/%s.pdf" % (self.category, self.module)
        else:
            self.merger_files_pdf(directory)
            return constant.OUTPUT_PDF_FILE_DIRECTORY + "/%s/%s.pdf" % (self.category, self.module)

    def setup_page_print(self):
        pass

    def print_files(self):
        # TODO : do printing
        pass


class PrintFiles(PDFPrint):
    """
    Files object to print
    """

    def __init__(self, module, category, kinoubango, template_dir=False):
        """
        Initial object
        :param module: Module name is imported to implement
        :param category: category name
        :param kinoubango: function number
        """
        super().__init__(module, category, kinoubango, template_dir)


class RequestPrinter(object):
    """

    """

    def __init__(self, mongo_id, printer_ip):
        """
        Initial object
        :param mongo_id: _id object
        :param printer_ip: ip of webserver
        """
        self.mongo_id = mongo_id
        self.printer_ip = printer_ip
        self.print_mongodb = self.get_mogodb()
        self.print_option = self.set_print_option()
        self.res = {
            "result": "",
        }

    def on_requests(self, url):
        """
        Check status code
        :param url: url of website
        """
        r = requests.get(url)
        # 文字化け防止
        r.encoding = r.apparent_encoding
        # Status code of response Headers
        status = r.status_code
        return status

    def get_mogodb(self):
        """
        Get print option from mongo db by _id
        """
        # Initial MongoDB object
        db_obj = ZenMongoDB()
        # Making query by object id
        query = {"_id": ObjectId(self.mongo_id)}
        # Get collection data by collection at config file
        collection_data = db_obj.conn[db_obj.db][db_obj.collection]
        # Get data by object id
        results = collection_data.find_one(query)
        return results

    def set_print_option(self):
        """
        Set print option 
        """
        results = self.get_mogodb()
        param = results.get("OPTIONS")
        option = {}
        # CPN      
        if int(param.get("CPN")) < 1000:
            option["CPN"] = param.get("CPN")
        else:
            pass
        # COLT       
        option["COLT"] = param.get("COLT")
        # DUP
        option["DUP"] = param.get("DUP")
        # STPL
        option["STPL"] = param.get("STPL")
        # PNCH
        option["PNCH"] = param.get("PNCH")
        # OT
        option["OT"] = param.get("OT")
        # IT
        option["IT"] = param.get("IT")
        # SIZ
        option["SIZ"] = param.get("SIZ")
        # MED
        option["MED"] = param.get("MED")
        # DEL
        if param.get("DEL") == "IMP":
            option["DEL"] = param.get("DEL")
            option["PPUSR"] = ""
            option["HOUR"] = ""
            option["MIN"] = ""
            option["SPUSR"] = ""
            option["SPID"] = ""
            option["RSPID"] = ""
            option["ESPID"] = ""
        elif param.get("DEL") == "PRP":
            option["DEL"] = param.get("DEL")
            if len(param.get("PPUSR")) <= 8:
                option["PPUSR"] = param.get("PPUSR")
            else:
                pass
            option["HOUR"] = ""
            option["MIN"] = ""
            option["SPUSR"] = ""
            option["SPID"] = ""
            option["RSPID"] = ""
            option["ESPID"] = ""
        elif param.get("DEL") == "DLY":
            option["DEL"] = param.get("DEL")
            option["PPUSR"] = ""
            if len(param.get("HOUR")) <= 2 and (0 < int(param.get("HOUR")) <= 23):
                option["HOUR"] = param.get("HOUR")
            else:
                pass
            if len(param["HOUR"]) <= 2 and (0 < int(param["HOUR"]) <= 59):
                option["MIN"] = param.get("MIN")
            else:
                pass
            option["SPUSR"] = ""
            option["SPID"] = ""
            option["RSPID"] = ""
            option["ESPID"] = ""
        elif param.get("DEL") == "SECP":
            option["DEL"] = param.get("DEL")
            option["PPUSR"] = ""
            option["HOUR"] = ""
            option["MIN"] = ""
            option["SPUSR"] = ""
            if len(param["SPID"]) <= 8:
                option["SPID"] = param.get("SPID")
            else:
                pass
            if len(param.get("RSPID")) <= 12 and (param.get("RSPID") == param.get("ESPID")):
                option["RSPID"] = param.get("RSPID")
            else:
                pass
            if len(param.get("ESPID")) <= 12 and (param.get("RSPID") == param.get("ESPID")):
                option["ESPID"] = param.get("ESPID")
            else:
                pass
        return option

    def print_request(self, file_path):
        """
        post request to webserver
        :param file_path: file path of template
        """
        url = "http://%s/UPLPRT.cmd" % self.printer_ip
        file = {
            'FILE': (
                file_path.split("/")[-1],
                open(file_path, 'rb'),
                'application/pdf'
            )
        }
        r = requests.post(url, headers={"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"}, files=file, data=self.print_option)
        r.encoding = r.apparent_encoding
        if r.status_code == HTTP_SUCCESS:
            self.res["result"] = SUCCESS_CODE
        else:
            # Error
            self.res["result"] = ERROR_CODE
        return {
            "exit_code": 1,
            "result":SUCCESS_CODE
        }
    def get_job_request(self):
        """
        pythonから、ジョブ一覧の内容をスクレイピングし、値を返す。
        :return:
        """
        # ログ
        log.debug(self)
        try:
            url = "http://%s/jblist.htm" % self.printer_ip
            driver = webdriver.Chrome(ChromeDriverManager().install())
            status = self.on_requests(url)
            if status == HTTP_SUCCESS:
                list_data = []
                lst = ["job_name", "owner", "status", "type", "number_of_copies"]
                driver.get(url)
                # Locating by XPath
                table = driver.find_element_by_xpath('//p/table[2]/tbody/tr/td/table/tbody/tr/..')
                table_html = table.get_attribute('innerHTML')
                rh = read_html(table_html)[0]
                for i in range(3, len(rh)):
                    tmp_dict = {}
                    for j in range(1, 6):
                        if isinstance(rh[j][i], str):
                            tmp_dict[lst[j - 1]] = rh[j][i]
                    if len(tmp_dict) != 0:
                        list_data.append(tmp_dict)
                self.res["result"] = "0"
                self.res["content"] = list_data
            else:
                # Error
                self.res["result"] = "9"
        except Exception as ex:
            # 例外処理
            log.exception(ex)
            log.error(traceback.format_exc())
            raise
        else:
            # ログ.
            log.info(self)
            driver.close()
            if self.res["result"] == SUCCESS_CODE:
                return {
                    "exit_code": 1,
                    "result": {
                        "result_code": self.res["result"],
                        "content": self.res["content"],
                        }
                }
            else:
                return {
                    "result_code": self.res["result"],
                    "content": ""
                         }

    def get_history_request(self):
        """
        pythonから、ジョブ履歴の内容をスクレイピングし、値を返す。
        """
        log.debug(self)
        try:
            url = "http://%s/jbhist.htm" % self.printer_ip
            driver = webdriver.Chrome(ChromeDriverManager().install())
            status = self.on_requests(url)
            if status == HTTP_SUCCESS:
                list_data = []
                lst = [
                    "job_name", "owner", "result", "type", "number_of_pages",
                    "discharge_destination", "host_if", "complete_datetime"
                ]
                driver.get(url)
                # Locating by XPath
                table = driver.find_element_by_xpath('//p/table/tbody/tr/td/table/tbody/tr/..')
                table_html = table.get_attribute('innerHTML')
                rh = read_html(table_html)[0]
                for i in range(3, len(rh)):
                    tmp_dict = {}
                    for j in range(8):
                        if isinstance(rh[j][i], str):
                            tmp_dict[lst[j]] = rh[j][i]
                    if len(tmp_dict) != 0:
                        list_data.append(tmp_dict)
                self.res["result"] = "0"
                self.res["content"] = list_data
            else:
                # Error
                self.res["result"] = "9"
        except Exception as ex:
            # 例外処理
            log.exception(ex)
            log.error(traceback.format_exc())
            raise
        else:
            # ログ.
            log.info(self)
            driver.close()
            if self.res["result"] == SUCCESS_CODE:
                return {
                    "exit_code": 1,
                    "result": {
                        "result_code": self.res["result"],
                        "content": self.res["content"]
                    }
            }
            else:
                return {
                    "result_code": self.res["result"],
                    "content": ""
                }

    def get_error_request(self):
        """
        pythonから、ジョブエラーの内容をスクレイピングし、値を返す。
        """
        log.debug(self)
        try:
            url = "http://%s/sperr.htm" % self.printer_ip
            driver = webdriver.Chrome(ChromeDriverManager().install())
            status = self.on_requests(url)
            if status == HTTP_SUCCESS:
                list_data = []
                lst = ["datetime", "error_code"]
                driver.get(url)
                # Locating by XPath
                table = driver.find_element_by_xpath('//table/tbody/tr/td/table/tbody/tr/..')
                table_html = table.get_attribute('innerHTML')
                rh = read_html(table_html)[0]
                for i in range(3, len(rh)):
                    tmp_dict = {}
                    for j in range(2):
                        if isinstance(rh[j][i], str):
                            tmp_dict[lst[j]] = rh[j][i]
                    if len(tmp_dict) != 0:
                        list_data.append(tmp_dict)
                self.res["result"] = "0"
                self.res["content"] = list_data
            else:
                # Error
                self.res["result"] = "9"
        except Exception as ex:
            # 例外処理
            log.exception(ex)
            log.error(traceback.format_exc())
            raise
        else:
            # ログ.
            log.info(self)
            driver.close()
            if self.res["result"] == SUCCESS_CODE:
                return {
                    "exit_code": 1,
                    "result": {
                        "result_code": self.res["result"],
                        "content": self.res["content"]
                    }        
                }
            else:
                return {
                    "result_code": self.res["result"],
                    "error_code": "Error"
                }
# -------------------- --------------------------------------------
