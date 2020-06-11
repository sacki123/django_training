#pip install mysql-connector
import mysql.connector as mydb
from mysql.connector import Error
import jaconv

def dictfetchall(cussor):
    columns = [col[0].lower() for col in cussor.description]
    return [dict(zip(columns, row)) for row in cussor.fetchall()]

# コネクションの作成
def connectdb():
    conn = mydb.connect(
        host='127.0.0.1',
        port='32767',
        user='zen',
        password='zen',
        database='zen'
    )
    return conn

def convert_h2z(value):
    if value != None:
        value = jaconv.h2z(value)
    else:
        value = ''
    return value

def execute(params, table):
    try:    
        conn = connectdb()
        cur = conn.cursor()
        sql = f"""update {table} set {table}.patient_last_name_kana = %s,{table}.patient_first_name_kana = %s, \
            {table}.insured_last_name_kana = %s,{table}.insured_first_name_kana = %s where {table}.rid = %s"""

        # SQLの実行
        cur.executemany(sql,params)
        conn.commit()   
    except Error as error:
        print("Failed to update records to database: {}".format(error))
    finally:
        cur.close()
        conn.close()
    
def edit_data(rows):
    patient_last_name_kana = convert_h2z(rows['patient_last_name_kana'])  
    patient_first_name_kana = convert_h2z(rows['patient_first_name_kana'])
    insured_last_name_kana = convert_h2z(rows['insured_last_name_kana'])
    insured_first_name_kana = convert_h2z(rows['insured_first_name_kana'])
    param = [patient_last_name_kana,patient_first_name_kana,insured_last_name_kana,insured_first_name_kana,rows['rid']]
    return param

# DB操作用にカーソルを作成]
list_table = ['RECEIPT_200','RECEIPT_300']
for table in list_table:
    target_table = {}
    conn = connectdb()
    cur = conn.cursor()

    # 全てのデータを取得
    sql = f"SELECT rid,patient_last_name_kana,patient_first_name_kana,insured_last_name_kana,insured_first_name_kana FROM {table}"
    cur.execute(sql)
    target_table = dictfetchall(cur)

    # DB操作が終わったらカーソルとコネクションを閉じる
    cur.close()
    conn.close()
    loop = len(target_table)
    count =  1000
    d = loop // count
    f = loop % count
    if loop <= count:
        params = []
        try:
            for rows in target_table: 
                param = edit_data(rows)
                params.append(tuple(param))
        except Exception as e:
            pass
        execute(params, table)
        print("%s %s 件が変換されました" %(table,loop))
        # DB操作用にカーソルを作成  
    elif loop > count:
        total = 0
        for i in range(d):
            params = []
            try:
                for rows in (target_table[i*count:count+i*count]): 
                    param = edit_data(rows)
                    params.append(tuple(param))
            except Exception as e:
                pass
            execute(params, table)  
            total += count   
            print("%s Success %s"%(table,i))   
        params = []
        try:
            for rows in (target_table[d*count:f+d*count]): 
                param = edit_data(rows)
                params.append(tuple(param))
        except Exception as e:
            pass
        execute(params, table)
        total += f
        print("Success All")
        print("%s %s 件が変換されました" %(table,total))