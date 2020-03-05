#!/Commonusr/bin/python
# -*- coding: utf-8 -*-
"""
DB パッケージ

※原則としてdjangoのデータベースの仕組みを使う事
"""

__title__   = 'DB パッケージ'
__author__  = "ExpertSoftware Inc."
__status__  = "develop"
__version__ = "0.0.0_0"
__date__    = "2018/12/06"
__license__ = ''
__desc__    = '%s Ver%s (%s)' % (__title__, __version__, __date__)
# ------------------------------------------------------------
# Import Section
# ------------------------------------------------------------
# Python
import os
import pymongo
from pymongo import MongoClient
from bson.objectid import ObjectId

# Log
import sys
import traceback
import configparser
from logging import getLogger

# Debug
import pdb

# ------------------------------------------------------------
# Variable Section
# ------------------------------------------------------------

DIR_NAME = os.path.dirname(__file__)
ETC_INI_FILE = os.path.join(DIR_NAME, '../../../etc/my.ini')

log = getLogger(__name__)
config = configparser.ConfigParser()
config.read(ETC_INI_FILE)


# ------------------------------------------------------------
# Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
# Class Section
# ------------------------------------------------------------
class ZenMongoDB:

    def __init__(self):
        """
        コンストラクタ
        """
        self.db = config['mongo']['database']
        self.collection = config['mongo']['COLLECTION']
        self.mongo_config = config['mongo']

        if self.mongo_config == False:
            return None

        self.user = self.mongo_config.get('user', '')
        self.password = self.mongo_config.get('password', '')
        self.host =  self.mongo_config.get('host', '127.0.0.1')
        self.port =  self.mongo_config.get('port', '27017')

        if len(self.user) == 0:
            self.user_password = ''
        elif len(self.password) == 0:
            self.user_password = self.user
        else:
            self.user_password = '%s:%s' % (self.user, self.password)

        if len(self.user_password) == 0:
            self.connection_path = 'mongodb://%s:%s' % (self.host, self.port)
        else:
            self.connection_path = 'mongodb://%s@%s:%s' % (self.user_password, self.host, self.port)
        self.conn = self.connect_db()

    def connect_db(self):
        """
        モンゴブ接続機能
        """
        # ログ
        log.debug(self)
        try:
            if self.connection_path:
                client = MongoClient(self.connection_path)
            else:
                client = MongoClient(
                    config['mongo']['url']
                )
            return client
        except:
            log.error(traceback.format_exc())

    def insert_data(self, data, collection):
        """
        Insert data into Collection
        :param data :(dictionary) format {"field_key": "field_value"}
        :param collection(string) name of Collection to use in DB
        """
        # ログ
        log.debug(self)
        try:
            if data:
                records = self.conn[self.db][collection]
                records.insert_one(data)
        except:
            log.error(traceback.format_exc())

    def find_data(self, _id, collection):
        """
        Find data in Collection by query
        :param _id : (string) ObjectId string
        :param collection(string) name of Collection to use in DB
        :return report_lst
        """
        # ログ
        log.debug(self)
        try:
            if _id and ObjectId.is_valid(_id):
                query = {"_id": ObjectId(_id)}
                records = self.conn[self.db][collection]
                results = records.find_one(query)
                report_lst = results.get("REPORT_LIST")
                return report_lst
        except:
            log.error(traceback.format_exc())

    def find_report_number(self, _id, collection):
        """
        Find report number in Collection by query
        :param _id : (string) ObjectId string
        :param collection(string) name of Collection to use in DB
        :return report_number
        """
        if _id and ObjectId.is_valid(_id):
            query = {"_id": ObjectId(_id)}
            records = self.conn[self.db][collection]
            results = records.find_one(query)
            report_number = []
            report_lst = results.get('REPORT_LIST')
            for i in report_lst:
                if i.get("REPORT_NUMBER") is not None:
                    unit = i.get("REPORT_NUMBER")
                    report_number.append(unit)
            return report_number
