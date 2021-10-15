#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

Django Display Name 設定

2019/04/23 J.Toba@ExS 新規作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__     = '2019/04/23'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
import logging

# django
from django.core.management.base import BaseCommand, CommandError
from django.db import connection,transaction
from django.contrib.auth.models import User

# zm
from zm.common import const
from zm.common.model import getClass
from zm.models.AUTHORIZE_000 import AUTHORIZE_000
from exs_main.util.log import EXSLogger
from gimei import Gimei
from faker import Faker,Factory
import datetime
fake = Faker('ja_JP')
f = Factory.create('ja_JP')

# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
class Command(BaseCommand):
    def handle(self, *args, **options):
        triggers_name = self.get_triggers()
        self.drop_trigger(triggers_name)
        table_list,system_user_tables,history_tables = self.get_tables()
        self.error_list = []
        
        columns_be_replaced = {}
        # print(len(table_list))
        # lower_case_table_name  = [table_name.lower() for table_name in table_list]
        # havent_execute_tables = table_list[lower_case_table_name.index("receipt_100"):]
        # print(len(havent_execute_tables))
        # print(havent_execute_tables)
        for table_name in table_list:
            be_replaced = {
                'name':[],
                'name_kana':[],
                'first_name':[],
                'last_name':[],
                'first_name_kana':[],
                'last_name_kana':[],
                'address_pref_tcd':[],
                'address_city':[],
                'address_town':[],
                'address_street':[],
                'zip_code':[],
                'phone_number':[],
                'fax_number':[],
                'mail':[],
                'my_number':[],
                'birth_date':[],
                'birthday':[],
                'insured_number':[],
                'recipient_number':[],
                'introducer_information':[],
                'create_user':[],
                'update_user':[]
            }
            with connection.cursor() as cursor:
                cursor.execute('DESC `%s`' % table_name)
                table_colums = cursor.fetchall()
            
                for col_des in table_colums:
                    origin_col_name = col_des[0]
                    col_name = origin_col_name.lower()

                    if "first_name_kana" in col_name:
                        be_replaced["first_name_kana"].append(origin_col_name)
                    elif "last_name_kana" in col_name:
                        be_replaced["last_name_kana"].append(origin_col_name)
                    elif "last_name" in col_name:
                        be_replaced["last_name"].append(origin_col_name)
                    elif "first_name" in col_name:
                        be_replaced["first_name"].append(origin_col_name)
                    elif "name_kana" in col_name:
                        be_replaced["name_kana"].append(origin_col_name)
                    elif "name" in col_name:
                        be_replaced["name"].append(origin_col_name)
                    elif "address_pref_tcd" in col_name:
                        be_replaced["address_pref_tcd"].append(origin_col_name)
                    elif "address_city" in col_name:
                        be_replaced["address_city"].append(origin_col_name)
                    elif "address_town" in col_name:
                        be_replaced["address_town"].append(origin_col_name)
                    elif "address_street" in col_name:
                        be_replaced["address_street"].append(origin_col_name)
                    elif "zip_code" in col_name:
                        be_replaced["zip_code"].append(origin_col_name)
                    elif "phone_number" in col_name:
                        be_replaced["phone_number"].append(origin_col_name)
                    elif "fax_number" in col_name:
                        be_replaced["fax_number"].append(origin_col_name)
                    elif "mail" in col_name:
                        be_replaced["mail"].append(origin_col_name)
                    elif "my_number" in col_name:
                        be_replaced["my_number"].append(origin_col_name)
                    elif "birth_date" in col_name:
                        be_replaced["birth_date"].append(origin_col_name)
                    elif "birthday" in col_name:
                        be_replaced["birthday"].append(origin_col_name)    
                    elif "insured_number" in col_name:
                        be_replaced["insured_number"].append(origin_col_name)
                    elif "recipient_number" in col_name:
                        be_replaced["recipient_number"].append(origin_col_name) 
                    elif "introducer_information" in col_name:
                        be_replaced["introducer_information"].append(origin_col_name) 
                    elif "create_user" in col_name:
                        be_replaced["create_user"].append(origin_col_name)   
                    elif "update_user" in col_name:
                        be_replaced["update_user"].append(origin_col_name)     


            columns_be_replaced[table_name] = be_replaced
        
        print("------------------------RECPLACING SENSITIVE DATA---------")
        self.replace(columns_be_replaced)
        print("------------------------REPLACING DONE---------------------")
        print("------------------------TRUNCATING SYSTEM USER---------------")
        self.truncate(system_user_tables)
        User.objects.all().delete()
        print("------------------------TRUNCATING DONE----------------------")
        print("------------------------TRUNCATING HISTORY TABLE---------------")
        self.truncate(history_tables)
        print("------------------------TRUNCATING DONE----------------------")
    
    @transaction.atomic  
    def replace(self,columns_be_replaced):
        for table_name in columns_be_replaced.keys():
            print("--> " + table_name)
            be_replaced = columns_be_replaced.get(table_name, {})
            model = getClass(table_name.upper())
            if not model:
                continue
            counts = model.objects.count()
            count =  10000
            div = counts // count
            mod = counts % count
            print(table_name + " --> count: %s - div: %s  - mod: %s"%(counts, div, mod))
            if counts <= count:
                records = model.objects.all()
                self.replace_data(records, be_replaced)
                print(table_name + " SUCCESS")
            else:
                for i in range(div):
                    try:
                        records = model.objects.all()[count*i:count+count*i]
                        print(table_name + ": " + str(count*i) + "-->%s"%(str(count+count*i)))
                        self.replace_data(records, be_replaced)
                    except Exception as e:
                        pass
                print(table_name + ": " + str(count*div) + "-->%s"%(str(mod+count*div)))    
                records = model.objects.all()[count*div:mod+count*div]   
                self.replace_data(records, be_replaced)
                print(table_name + " SUCCESS")

    def truncate(self, tables_name):
        with connection.cursor() as cursor:
            for table_name in tables_name:
                print("Truncate table: "+table_name)
                cursor.execute("TRUNCATE TABLE "+table_name)

    def get_tables(self):
        tables = []
        system_user_tables = []
        history_tables=[]
        try:
            with connection.cursor() as cursor:
                cursor.execute('SHOW TABLES')
                row = cursor.fetchall()
            for tdata in row:
                if (self.is_target_table(tdata[0])):
                    if (tdata[0].lower().startswith('auth')):
                        system_user_tables.append(tdata[0])
                    elif (tdata[0].lower().find('_h') != -1):
                        history_tables.append(tdata[0])
                    else:
                        tables.append(tdata[0])
        finally:
            return tables,system_user_tables,history_tables

    def is_target_table(self, table_name):
        excluding_table_name= ["organization_000","insurer_000","insurer_001"]
        lower_table_name  = table_name.lower()
        if (lower_table_name.startswith('django')):
            return False
        if (lower_table_name.startswith("zm_filemodel")):
            return False
        if lower_table_name in excluding_table_name:
            return False
        
        return True
    
    def get_triggers(self):
        triggers_name = list()
        try:
            with connection.cursor() as cursor:
                cursor.execute("SHOW TRIGGERS")
                rows = cursor.fetchall()
            for row in rows:
                triggers_name.append(row[0])
        finally:
            return triggers_name
    
    def drop_trigger(self, triggers_name):
        with connection.cursor() as cursor:
            for trigger_name in triggers_name:
                print("DROP TRIGGER: " + trigger_name)
                cursor.execute("DROP TRIGGER " + trigger_name)
    
    # def check_data_string(self, data):
    #     if (data == None):
    #         return None
    #     else:
    #         while True:
    #             fake_str = fake.name.first.kanji
    #             if fake_str != data:
    #                 break
    #         return fake_str    
            

    # @transaction.atomic
    def replace_data(self, records, be_replaced):
        for record in records:
            fake = Gimei()
            
            if be_replaced.get("first_name"):
                for table_col_name in be_replaced.get("first_name"):
                    while True:
                        first_name = record.__dict__.get(table_col_name.lower())
                        if first_name == None or first_name == "":
                            break
                        first_name = fake.name.first.kanji
                        if first_name != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),first_name)
            if be_replaced.get("last_name"):
                for table_col_name in be_replaced.get("last_name"):
                    while True:
                        last_name = record.__dict__.get(table_col_name.lower())
                        if last_name == None or last_name == "":
                            break
                        last_name = fake.name.last.kanji
                        if last_name != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),last_name)
            if be_replaced.get("first_name_kana"):
                for table_col_name in be_replaced.get("first_name_kana"):
                    while True:
                        first_name_kana = record.__dict__.get(table_col_name.lower())
                        if first_name_kana == None or first_name_kana == "":
                            break
                        first_name_kana = fake.name.first.katakana
                        if first_name_kana != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),first_name_kana)
            if be_replaced.get("last_name_kana"):
                for table_col_name in be_replaced.get("last_name_kana"):
                    while True:
                        last_name_kana = record.__dict__.get(table_col_name.lower())
                        if last_name_kana == None or last_name_kana == "":
                            break
                        last_name_kana = fake.name.last.katakana
                        if last_name_kana != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),last_name_kana)
            # if be_replaced.get("address_pref_tcd"):
            #     for table_col_name in be_replaced.get("address_pref_tcd"):
            #         setattr(record,table_col_name.lower(),'')
            if be_replaced.get("address_city"):
                for table_col_name in be_replaced.get("address_city"):
                    while True:
                        address_city = record.__dict__.get(table_col_name.lower())
                        if address_city == None or address_city == "":
                            break
                        address_city = f.city()
                        if address_city != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),address_city)
            if be_replaced.get("address_town"):
                for table_col_name in be_replaced.get("address_town"):
                    while True:
                        address_town = record.__dict__.get(table_col_name.lower())
                        if address_town == None or address_town == "":
                            break
                        address_town = f.town()
                        if address_town != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),address_town)
            if be_replaced.get("address_street"):
                for table_col_name in be_replaced.get("address_street"):
                    while True:
                        address_street = record.__dict__.get(table_col_name.lower())
                        if address_street == None or address_street == "":
                            break
                        address_street = f.chome()
                        if address_street != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),address_street)
            if be_replaced.get("zip_code"):
                for table_col_name in be_replaced.get("zip_code"):
                    while True:
                        zip_code = record.__dict__.get(table_col_name.lower())
                        if zip_code == None or zip_code  == "":
                            break
                        zip_code = f.zipcode()
                        if zip_code != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),zip_code)
            if be_replaced.get("phone_number"):
                for table_col_name in be_replaced.get("phone_number"):
                    while True:
                        phone_number = record.__dict__.get(table_col_name.lower())
                        if phone_number == None or phone_number  == "":
                            break
                        phone_number = '000-0000-0000'
                        break
                    setattr(record,table_col_name.lower(),phone_number)
            if be_replaced.get("fax_number"):
                for table_col_name in be_replaced.get("fax_number"):
                    setattr(record,table_col_name.lower(),'')
            if be_replaced.get("name"):
                for table_col_name in be_replaced.get("name"):
                    while True:
                        name = record.__dict__.get(table_col_name.lower())
                        if name == None or name  == "":
                            break
                        name = Gimei().name.hiragana
                        if name != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),name)
            if be_replaced.get("name_kana"):
                for table_col_name in be_replaced.get("name_kana"):
                    while True:
                        name_kana = record.__dict__.get(table_col_name.lower())
                        if name_kana == None or name_kana  == "":
                            break
                        name_kana = Gimei().name.katakana
                        if name_kana != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),name_kana)
            if be_replaced.get("mail"):
                for table_col_name in be_replaced.get("mail"):
                    setattr(record,table_col_name.lower(),'exs@gmail.com')
            if be_replaced.get("my_number"):
                for table_col_name in be_replaced.get("my_number"):
                    setattr(record,table_col_name.lower(),'')
            if be_replaced.get("birth_date"):
                for table_col_name in be_replaced.get("birth_date"):
                    while True:
                        birth_date = record.__dict__.get(table_col_name.lower())
                        if birth_date == None or birth_date  == "":
                            break
                        birth_date = datetime.datetime.now()
                        break
                    setattr(record,table_col_name.lower(),birth_date)
            if be_replaced.get("birthday"):
                for table_col_name in be_replaced.get("birthday"):
                    while True:
                        birth_day = record.__dict__.get(table_col_name.lower())
                        if birth_day == None or birth_day  == "":
                            break
                        birth_day = datetime.datetime.now()
                        break
                    setattr(record,table_col_name.lower(),birth_day)         
            if be_replaced.get("insured_number"):
                for table_col_name in be_replaced.get("insured_number"):
                    while True:
                        insured_number = record.__dict__.get(table_col_name.lower())
                        if insured_number == None or insured_number  == "":
                            break
                        insured_number = f.random_int(12345678, 87654321)
                        if insured_number != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),insured_number)      
            if be_replaced.get("recipient_number"):
                for table_col_name in be_replaced.get("recipient_number"):
                    while True:
                        recipient_number = record.__dict__.get(table_col_name.lower())
                        if recipient_number == None or recipient_number  == "":
                            break
                        recipient_number = f.random_int(12345678, 87654321)
                        if recipient_number != record.__dict__.get(table_col_name.lower()):
                            break
                    setattr(record,table_col_name.lower(),recipient_number)    
            if be_replaced.get("introducer_information"):
                for table_col_name in be_replaced.get("introducer_information"):
                    while True:
                        introducer_information = record.__dict__.get(table_col_name.lower())
                        if introducer_information == None or introducer_information  == "":
                            break
                        introducer_information = fake.name.last.kanji + fake.name.first.kanji
                        break
                    setattr(record,table_col_name.lower(),introducer_information)
            if be_replaced.get("create_user"):
                for table_col_name in be_replaced.get("create_user"):
                    while True:
                        create_user = record.__dict__.get(table_col_name.lower())
                        if create_user == None or create_user  == "":
                            break
                        create_user = fake.name.last.kanji + fake.name.first.kanji
                        break
                    setattr(record,table_col_name.lower(),create_user)
            if be_replaced.get("update_user"):
                for table_col_name in be_replaced.get("update_user"):
                    while True:
                        update_user = record.__dict__.get(table_col_name.lower())
                        if update_user == None or update_user  == "":
                            break
                        update_user = fake.name.last.kanji + fake.name.first.kanji
                        break
                    setattr(record,table_col_name.lower(),update_user)            
            record.save()                    