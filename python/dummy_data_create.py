import os
import copy
from openpyxl import Workbook
import mysql.connector as mydb
from mysql.connector import Error

list_receipt_x00 = ['rid','public_expense_recipient_number','recipient_number','insured_number','injury_name','patient_last_name_kana','patient_first_name_kana','patient_last_name',
'patient_first_name','patient_birthday','injury_name_add','sickness_name','facility_zip_code','facility_address_city','facility_address_town','facility_address_street','facility_name','treatment_manager_last_name',
'treatment_manager_first_name','facility_phone_number','payment_application_name','insured_zip_code','insured_address_city','insured_address_town','insured_address_street','insured_last_name_kana',
'insured_first_name_kana','insured_last_name','insured_first_name','insured_phone_number','first_consent_doctor_last_name','first_consent_doctor_first_name','last_consent_doctor_last_name',
'last_consent_doctor_first_name','latest_consent_doctor_last_name','latest_consent_doctor_first_name','consent_doctor_zip_code','consent_doctor_address_city','consent_doctor_address_town',
'consent_doctor_address_street','consent_injury_name','display_name','create_user','update_user']
list_receipt_x10 = ['rid','patient_last_name','patient_first_name','patient_last_name_kana','patient_first_name_kana','patient_birthday','sickness_name','patient_zip_code','patient_address_city',
'patient_address_town','patient_address_street','injury_name_add','facility_name','facility_phone_number','facility_zip_code','facility_address_city','facility_address_town','facility_address_street',
'practitioner_last_name','practitioner_first_name','practitioner_last_name_kana','practitioner_first_name_kana','display_name','create_user','update_user']
def connectdb():
    conn = mydb.connect(
        host='127.0.0.1',
        port='32767',
        user='zen',
        password='zen',
        database='zen'
    )
    return conn

def get_data(table):
    sql = f'select * from {table}'
    con = connectdb()
    cur = con.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    con.close()
    cur.close()
    i = 0
    list_data = []
    for i in range(len(data)):
        list_data.append(list(data[i]))
    return list_data

def get_columns(table):
    list_columns = []
    sql = f'SHOW COLUMNS FROM {table}'
    con = connectdb()
    cur = con.cursor()
    cur.execute(sql)
    data = cur.fetchall()
    con.close()
    cur.close()
    for i in data:
        list_columns.append(i[0])
    return list_columns

def create_data(table):
    list_columns = get_columns(table)
    temp = copy.deepcopy(list_columns)
    data_receipt = get_data(table)
    data_receipt_stg = get_data(table + '_DMDATA')
    data_excel = []
    if table == 'RECEIPT_200' or table == 'RECEIPT_300':
        list_check = list_receipt_x00
    else:
        list_check = list_receipt_x10 
    for column in temp:
        if column in list_check:
            index_column = list_columns.index(column)
            list_columns.insert(index_column+1,column)
            list_columns.insert(index_column+2,'check')
            i = 0
            try:
                for i in range(len(data_receipt)):
                    data_receipt[i].insert(index_column+1,data_receipt_stg[i][temp.index(column)])
                    data_receipt[i].insert(index_column+2,'')      
            except Exception as e:
                print(e)
    data_excel.append(list_columns)            
    data_excel.extend(data_receipt)
    return data_excel   

def set_auto_col_width(sheet):
    dimensions = {}
    for row in sheet.rows:
        for cell in row:
            if cell.value:
                width = max((dimensions.get(cell.column_letter, 0), len(str(cell.value))))
                if width > 60:
                    width = 60
                elif width < 10:
                    width = 10    
                dimensions[cell.column_letter] = width
    for col, value in dimensions.items():
        sheet.column_dimensions[col].width = value

def create_excel(data, table):
    excel_name = table + 'エビデンス'
    wb = Workbook()
    ws = wb.active
    ws.title = table
    excel_path = os.path.dirname(__file__) + '/' + excel_name + '.xlsx'
    for row_value in data:
        ws.append(row_value)
    set_auto_col_width(ws)
    wb.save(excel_path)        
    
inp = input("テープルの名前(200,300,210,310)を入力してください：")
inp_table = "RECEIPT_" + str(inp)
#inp_table = inp.upper()
data = create_data(inp_table)
create_excel(data, inp_table)
print('SUCCESS')