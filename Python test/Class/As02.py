import csv, re

class Category:
    category_ID = ""
    category_Name = ""
    def __init__(self, id_category, name_category):
        self.category_Id = id_category
        self.category_Name = name_category
    def check_value(self):
        if not re.search("[A-Z]{1}[0-9]{3}", self.category_Id):
            print("Category ID không chính xác")
        if len(self.category_Name) > 30:
            print("Category_Name không được lớn hơn 30 ký tự")    
    def category_display(self):
        print("Category_ID: %s - Category_Name: %s" %(self.category_Id, self.category_Name))  


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
        print("Category_ID: %s - Category_Name: %s - Product Code: %s - Product Name %s - Product Price %0.2f" %(self.category_Id, self.category_Name, self.product_code, self.product_name, float(self.product_price)))        


def create_lst_product():
    lst_product = []
    with open ('order_detail.csv', encoding = 'utf-8') as file_csv:
        csv_reader = csv.reader(file_csv)
        for index , value in enumerate(csv_reader):
            if index == 0:
                pass
            else:
                tem_product = Product(value[0], value[1], value[2], value[3], value[4])
                lst_product.append(tem_product)
    return lst_product

lst = create_lst_product()
for obj in lst:
    obj.product_display()
