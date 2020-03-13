
from django.db import connection
from zm.common.model import getClass

INSURER = 'INSURER_TEST'
class SqlLogic:

    def sql_execute(self, sql, sql_param):
        with connection.cursor() as con:
            con.execute(sql, sql_param)
            # row = self.dictfetchall(con)
            row = con.fetchall()
        return row

    @staticmethod     
    def dictfetchall(cussor):
        columns = [col[0].lower() for col in cussor.description]
        return [
            dict(zip(columns, row)) for row in cussor.fetchall()
        ]
        
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
        # keys = list(inputs.keys())
        # for i in range(len(keys)-1):
        #     sql += keys[i] + ","
        # sql += keys[-1]
        return sql

    def create_from(self, table):
        sql = f"""
            FROM {table}
        """   
        return sql

    def create_where(self, inputs):
        sql = ""
        str_sql = ""
        if not inputs:
            return sql
        else:    
            key = list(inputs.keys())
            str_where = f"""
                WHERE 
            """ 
            for i in range(len(key)-1):
                if inputs[key[i]] == "":
                    continue
                str_sql += key[i]+ "= %(" + key[i] +")s AND "
            if inputs[key[-1]] != "":   
                str_sql += key[-1] + "=%(" + key[-1] + ")s"
            if str_sql:
                sql = str_where + str_sql    
        return sql
