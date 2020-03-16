import mysql.connector
from mysql.connector import Error
from mysql.connector import pooling
import MySQLdb
import datetime
def getconnection():
    con = mysql.connector.connect(host='localhost ', database = 'test', user = 'root', password = '')
    return con


def insertdata():
    try:
        con = mysql.connector.connect(host = 'localhost', database = 'test', user = 'root', password = '')
        cursor = con.cursor()
        stringinsert = 'insert into nhanvien values(4, Hoangdaica, hoang, 1)'
        cursor.execute(stringinsert)
        stringselect = ('select * from thanhvien')
        cursor.execute(stringselect)
        con.commit()
        record = cursor.fetchall()
        for index in record:
            print(index)
    except Error as e:    
        print('Có lỗi phát sinh %s' %e)  
    finally:
        cursor.close()
        con.close()


def display():
    con =getconnection()
    
    cursor = con.cursor()
    cursor.execute('select * from nhanvien')    
    record = cursor.fetchall()
    for index in record:
        print(index)
    # cursor.close()
    con.close()


def update():
    con = getconnection()
    cursor = con.cursor()
    strupdate = 'update nhanvien set manv = %s, tennv = %s, ngaysinh = %s where manv = %s'
    # ngaysinh = datetime.datetime.now()
    # ngaysinh = ngaysinh.strftime('%Y-%m-%d')
    ngaysinh = '1987-03-23'
    strinput = [('nv0010','Hoàng Phi Hùng',ngaysinh,'M001'), ('nv0011','Ỷ Thiên Đồ Long Ký', ngaysinh, 'M002')]
    cursor.executemany(strupdate, strinput)
    con.commit()
    # cursor.close()
    con.close()

def edit():
    con = getconnection()
    cursor = con.cursor()
    ipedit = ('nv0011',)
    cursor.callproc('edit',ipedit)
    record = cursor.stored_results()
    print(record)
    for index in cursor.stored_results():
        print(index.fetchall())


def insertmany():
    try:
        # stringcon = "host = 'localhost', database = 'member', user = 'root', password = ''"
        strin = 'insert into nhanvien values(%s,%s,%s)'
        ngaysinh = datetime.datetime.now()
        ngaysinh = ngaysinh.strftime('%Y-%m-%d')
        insert_tuple = [('M001','Yamada',ngaysinh),('M002','Morioka',ngaysinh),('M003','ToBA',ngaysinh)]   
        con = getconnection()
        if con.is_connected():
            print('Đã kết nối đến CSDL')
            cursor = con.cursor()
            record = cursor.executemany(strin,insert_tuple)
            con.commit()
    except Error as e:
        print("Xảy ra lỗi {}".format(e))
    finally:
        cursor.close()
        con.close()


def dell():
    con = getconnection()
    cursor = con.cursor()
    strdelete = 'Delete from nhanvien where manv = %s'
    ipdelete = [('nv0010',),('nv0011',)]
    dele = cursor.executemany(strdelete,ipdelete)
    con.commit()
    con.close()

display()  
# insertmany()
# update()
# edit()
# dell()  
# display()

# display()
# insertdata()
mysql.connector.pooling.MySQLConnectionPool()