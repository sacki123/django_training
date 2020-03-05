products = {
'SMART WATCH': 550,
'PHONE' : 1000,
'PLAYSTATION': 500,
'LAPTOP' : 1550,
'MUSIC PLAYER' : 600,
'TABLET' : 400
}
ip = str(input("Bạn hãy nhập vào sản phẩm mà bạn muốn tìm kiếm: "))
lst_key = list(products.keys())
ip = ip.upper()
for key, value in products.items():
    if ip == key:
        print("Thông tin sản phẩm %s mà bạn nhập vào là: %s" % (key,value))
    else:
        print("Sản Phẩm Không Tồn Tại")
        break
 
