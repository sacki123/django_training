import re
class Product():
    product_code = ""
    product_name = ""
    product_price = 0.0
    def __init__(self, code, name, price):
        self.product_code = code
        self.product_name = name
        self.product_price = price
    def check_productcode(self, code):
        if not re.fullmatch('[A-Z]{2}[0-9]{4}', str(code)):
            print("Product Code không chính xác")
    def check_productname(self, name):
        if len(name) > 30 or len(name) == 0:
            print("Product Name không chính xác") 
    def check_productprice(self, price):   
        try:
            price = float(price)
            if isinstance(price,float) or isinstance(price,int):
                price = round(price,2)
                if price <= 0 or price > 1000000:
                    print("Product Price không chính xác") 
            else:
                print("Product Price không chính xác")          
        except ValueError as e:
            print(e)            
pd = Product("AB1247", "Nokia", 5)    
pd.check_productcode(pd.product_code)
pd.check_productname(pd.product_name)
pd.check_productprice(pd.product_price)     
