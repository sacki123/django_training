import re
import os
import xlrd
import numpy
import csv

temp = []
class Category:
    category_ID = ""
    category_Name = ""
    def __init__(self, id_category, name_category):
        self.category_ID = id_category
        self.category_Name = name_category

    def check_value(self):
        if not re.search("[A-Z]{1}[0-9]{3}", self.category_ID):
            print("Category ID không chính xác")
        if len(self.category_Name) > 30:
            print("Category_Name không được lớn hơn 30 ký tự")    

    def category_display(self):
        print("Category_ID: %s - Category_Name: %s" %(self.category_ID, self.category_Name))  


class Product(Category):
    product_code = ""
    product_name = ""
    product_price = 0.0
    def __init__(self, category_id, category_name, code, name, price):
        super().__init__(category_id,category_name)
        self.product_code = code
        self.product_name = name
        self.product_price = price 


    def check_product(self):
        super().check_value()
        check_ip = True
        if not re.fullmatch('[A-Z]{2}[0-9]{4}', str(self.product_code)):
            print("Product Code không chính xác")
            check_ip = False
        if len(self.product_name) > 30 or len(self.product_name) == 0:
            print("Product Name không chính xác") 
            check_ip = False
        try:
            price = float(self.product_price)
            if isinstance(price,float) or isinstance(price,int):
                price = round(price,2)
                if price <= 0 or price > 1000000:
                    print("Product Price không chính xác") 
                    check_ip = False
            else:
                print("Product Price không chính xác")      
                check_ip = False    
        except ValueError as e:
            print("Product Price không chính xác ", e)   
            check_ip = False 
        return check_ip     

    def product_display(self):
        print("Category_ID: %s - Category_Name: %s - Product Code: %s - Product Name: %s - Product Price: %0.2f" %(self.category_ID, self.category_Name, self.product_code, self.product_name, float(self.product_price)))       


def creat_list_product():
    global temp
    path = os.path.dirname(__file__)+"/order_detail.csv"
    with open (path, encoding = 'utf-8') as file_csv:
        csv_reader = csv.reader(file_csv)
        for index, value in enumerate(csv_reader):
            if index == 0:
                pass
            else:
                temp_product = Product(value[0], value[1], value[2], value[3], value[4])
                temp.append(temp_product)       
                

def show_product():   
    # global temp              
    for value in temp:
        value.product_display()


def creat_list(category_id, category_name, produc_code, produc_name, produc_price):
    lst = []
    lst.append(category_id)
    lst.append(category_name)
    lst.append(produc_code)
    lst.append(produc_name)
    lst.append(produc_price)
    return lst


def inscreat():
    global temp
    ip_category_id = input("Enter Category_ID: ")
    ip_category_name = input("Enter Category_Name: ")
    ip_produc_code = input("Enter Product_Code: ")
    ip_produc_name = input("Enter Product_Name: ")
    ip_produc_price = input("Enter Product_Price: ")
    add = Product(ip_category_id, ip_category_name, ip_produc_code, ip_produc_name, ip_produc_price)
    if not add.check_product():
        print("Thêm Sản Phẩm Không Thành Công")
    else:
        temp.append(add)
        print("Thêm Sản Phẩm Thành Công")
        print("DANH SÁCH SAU KHI THÊM:")   
        show_product()    


def edit_csv():
    # global temp
    os.system('cls')
    check_edit = True
    ip_edit = input("Hãy nhập tên sản phẩm bạn muốn sửa: ")
    i = 1
    dic = dict()
    for index, value in enumerate(temp):
        if re.search(ip_edit, value.product_name, re.I):
            check_edit = False
            print("%s - " %i, end = '')
            value.product_display()
            dic[i] = index
            i += 1
    ip_choice = int(input("Chọn sản phẩm bạn muốn sửa 1 - %d: " % (i - 1)))
    print("--------"*10)
    print("Nhập thông tin bạn muốn sửa:")
    ip_category_id = input("Enter Category_ID: ")
    ip_category_name = input("Enter Category_Name: ")
    ip_produc_code = input("Enter Product_Code: ")
    ip_produc_name = input("Enter Product_Name: ")
    ip_produc_price = input("Enter Product_Price: ")    
    add = Product(ip_category_id, ip_category_name, ip_produc_code, ip_produc_name, float(ip_produc_price))
    if not add.check_product():
        print("Sửa Thông Tin Sản Phẩm Không Thành Công") 
    else:
        index2 = dic.get(ip_choice)
        temp[index2].category_ID = ip_category_id
        temp[index2].category_Name = ip_category_name
        temp[index2].product_code = ip_produc_code
        temp[index2].product_name = ip_produc_name   
        temp[index2].product_price = ip_produc_price   
        print("DANH SÁCH SẢN PHẨM SAU KHI SỬA:")
        show_product()
    if check_edit:
        print("Không có sản phẩm mà bạn muốn sửa")  
            
                        

def del_product():
    os.system('cls')
    check_edit = True
    ip_edit = input("Hãy nhập tên sản phẩm bạn muốn xóa: ")
    i = 1
    dic = dict()
    for index, value in enumerate(temp):
        if re.search(ip_edit, value.product_name, re.I):
            check_edit = False
            print("%s - " %i, end = '')
            value.product_display()
            dic[i] = index
            i += 1
    if not check_edit:
        ip_choice = int(input("Chọn sản phẩm bạn muốn xóa 1 - %d: " % (i - 1)))
        print("--------"*10)   
        index2 = dic.get(ip_choice)
        del temp[index2]
        print("DANH SÁCH SẢN PHẨM SAU KHI XÓA:")
        show_product()
    else:
        print("Không có sản phẩm mà bạn muốn xóa")  


def main():
    # Xóa màn hình
    os.system('cls')
    print("\tDưới đây là các chức năng của bạn")
    print("-----" * 13)
    print("1. \tTạo list các phần tử Product")
    print("2. \tHiển thị tất cả các sản phẩm")    
    print("3. \tThêm một sản phẩm")
    print("4. \tSửa thông tin sản phẩm")
    print("5. \tXóa một sản phẩm bất kỳ")
    print("6. \tThoát")
    ip_main = input("Chọn 1 đến 6 để hiển thị chức năng: ")
    check_main(ip_main)   


def comback_file():
    """
    HÀM ĐƯA RA LỰA CHỌN CÓ TRỞ VỀ FORM FILE ĐỂ THỰC HIỆN CÁC CÔNG VIỆC KHÁC NỮA KHÔNG
    """
    check_comeback = True
    while check_comeback:
        ip_comeback = input("\nChọn 'y' để  quay lại màn hình form File, chọn 'n' để thoát chương trình: ")
        if ip_comeback == 'y':
            check_comeback = False
            main()
        elif ip_comeback == 'n':
            exit()
        else:
            check_comeback = True



def check_main(ip_main):
    check_buy = True
    while check_buy:
        if str(ip_main) == '1':
            creat_list_product()
            show_product()
            comback_file()
            check_buy = False
        elif str(ip_main) == '2':
            show_product()
            comback_file()
            check_buy = False
        elif str(ip_main) == '3':
            inscreat()
            comback_file()
            check_buy = False
        elif str(ip_main) == '4':
            edit_csv()
            check_buy = False
            comback_file()
        elif str(ip_main) == '5':
            del_product()
            check_buy = False
            comback_file()    
        else:
            print("Xin Mời bạn nhập lại. Bạn chỉ được chọn 1 đến 6")
            check_buy = False 
main()   
# temp = creat_list_product()                       
# show_product()
