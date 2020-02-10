from zm.common.services.raw_sql_services import RawSqlService
from zm.common.utils.date_utils import get_last_day_of_month
from datetime import datetime
INSURER_000 = 'INSURER_000'

class QueryData:
    def get_data_export(self, user_input, insurer_name, is_print = False):
        query_result = []

        sql_full, sql_params = self.get_full_sql_query(insurer_name, user_input, is_print)
        query_result = RawSqlService().query_to_db(sql_full, sql_params)

        return query_result

    def get_full_sql_query(self, insurer_name, user_input, is_print = False):
        params = {}
        sql_query = """
            SELECT
        """
        sql_query += self.get_sel_select(insurer_name, is_print)
        sql_query += f"""
        FROM 
            {insurer_name}
        """
        sql_query += self.get_sql_join_table(insurer_name)
        sql_query += f"""
            WHERE 
        """
        sql_query += self.get_sql_where(insurer_name, user_input, params)
        sql_query += """
            ORDER BY
        """
        sql_query += self.get_sql_order_by(insurer_name)

        return sql_query, params

    def get_sel_select(self, insurer_name, is_print = False):
        sql_select = f"""
        INSURER_001.opening_class_tcd,
        {insurer_name}.apply_start_date,
        {insurer_name}.apply_end_date,
        {insurer_name}.insurance_category_tcd,
        {insurer_name}.insurer_law_number,
        {insurer_name}.insurer_jurisdiction_tcd,
        {insurer_name}.insurer_number,
        {insurer_name}.insurer_name,
        {insurer_name}.department_name,
        INSURER_001.insurer_payment_class_tcd,
        INSURER_001.joining_review_board_class_tcd,
        INSURER_001.receipt_summary_report_1_output_class_flag,
        INSURER_001.receipt_summary_report_2_output_class_flag,
        INSURER_001.billing_statement_output_class_tcd,
        INSURER_001.billing_statement_split_class_tcd,
        INSURER_001.billing_document_attach_class_tcd,
        {insurer_name}.rid as insurer_000_rid
        """
        if is_print:
            # datetime_str = datetime.now().date()
            # datetime_str = str(datetime_str).replace('-','/')
            # sql_select += f""",'{datetime_str}' as 作成日付
            sql_select += f""",DATE(NOW()) as 作成日付
            """
            
        return sql_select

    def get_sql_join_table(self, insurer_name):    
        sql_join = f"""
            INNER JOIN INSURER_001 ON INSURER_001.insurer_000_d_id = {insurer_name}.did
        """
        return sql_join

    def get_sql_where(self, insurer_name, user_inputs, sql_params):
        sql_params['delete_flag'] = 0

        #Default
        sql_where = f"""
            {insurer_name}.delete_flag = %(delete_flag)s
            AND INSURER_001.delete_flag = %(delete_flag)s 
        """
        #Input
        for key, value in user_inputs.items():
            if value == "":
                continue
            if key == "action":
                continue
            if key == 'opening_class_tcd':
                sql_where += f""" AND 
                    INSURER_001."""+ key + "= %(" +key+ ")s"
            else:
                sql_where += f""" AND 
                    {insurer_name}."""+ key + "= %(" +key+ ")s"        
        sql_params.update(user_inputs)        
        return sql_where

    def get_sql_order_by(self, insurer_name):
        sql_oder_by = f"""
            INSURER_001.opening_class_tcd,
            {insurer_name}.apply_start_date,
            {insurer_name}.apply_end_date,
            {insurer_name}.revision,
            {insurer_name}.insurance_category_tcd,
            {insurer_name}.insurer_number
        """        
        return sql_oder_by






