import os
import tempfile
import uuid
import json
from django.db import connection
from zm.common.model import getClass
from openpyxl import Workbook, load_workbook

INSURER = 'INSURER_TEST'
class SqlLogic:

    def sql_execute(self, sql, sql_param):
        with connection.cursor() as con:
            con.execute(sql, sql_param)
            row = con.fetchall()
        return row

    def sqlquery_execute(self, sql, sql_param):
        with connection.cursor() as con:
            con.execute(sql, sql_param)
            row = self.dictfetchall(con)
        return row

    @staticmethod     
    def dictfetchall(cussor):
        columns = [col[0].lower() for col in cussor.description]
        return [
            dict(zip(columns, row)) for row in cussor.fetchall()
        ]

    def delete_execute(self, request, inputs, json):
        obj = getClass(INSURER)
        try:
            item = obj.objects.get(rid = inputs['rid'])
            item.delete()
        except Exception as e:
            json['message'] = e
            return json
        json['message'] = 'Delete success'    
        return json
        
    def edit_execute(self, request, inputs, json):
        obj = getClass(INSURER)
        try:
            item = obj.objects.get(rid=inputs['rid'])
            for key, value in inputs.items():
                setattr(item, key, value)
            item.save()
        except Exception as e:
            json['error'] = e
            json['status'] = 500
            return json
        json['message'] = "Edit success" 
        return json

    def excel_execute(self, request, inputs, _json):
        set_json = {}
        tempdir = tempfile.gettempdir()
        file_id = str(uuid.uuid4())
        json_path = os.path.join(tempdir, file_id + '.json')
        data_excel_header = []
        for key in inputs.keys():
            if key == 'choice':
                set_json['type'] = inputs['choice']
            if key == 'rid':
                set_json['rid'] = inputs['rid']    
            data_excel_header.append(key)
        set_json['select_col'] = data_excel_header 
        with open(json_path, 'w') as f:
            json.dump(set_json, f, ensure_ascii = False)
        _json['url'] = '/takayama/export/?target=' + file_id   
        return _json 

    def get_fulldata_query(self, inputs):
        sql_full = self.create_full_sql_query(inputs)
        query_result = self.sqlquery_execute(sql_full, inputs)
        return query_result  

    def get_data_query(self, inputs):
        sql_full = self.create_full_sql_query(inputs)
        query_result = self.sql_execute(sql_full, inputs)
        return query_result

    def create_full_sql_query(self, inputs):
        sql_select = self.create_select(inputs)
        sql_from = self.create_from(INSURER)
        sql_where = self.create_where(inputs)
        sql_full = sql_select + sql_from + sql_where
        return sql_full

    def create_select(self, inputs):
        sql = """
            SELECT *
        """
        return sql

    def create_from(self, table):
        sql = f"""
            FROM {table}
        """   
        return sql

    def create_where(self, inputs):
        sql = ""  
        key = list(inputs.keys())
        str_where = f"""
            WHERE 
        """ 
        for i in range(len(key)):
            if inputs[key[i]] == "":
                continue
            elif i == 0:
                sql += key[i]+ "= %(" + key[i] +")s"
            elif i != 0 and sql == "":   
                sql += key[i]+ "= %(" + key[i] +")s"
            elif i != 0 and sql != "":   
                sql += " AND " + key[i]+ "= %(" + key[i] +")s"    
        if sql == "":
            return sql
        else:                    
            return str_where + sql
