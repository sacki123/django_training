import os
import re
product01 = {
    'ID': 1, 'Product': {'Name': 'Giầy Thượng Đình', 'Category': 'Clothes', 'Price': 200}
}

product02 = {
    'ID': 2, 'Product': {'Name': 'Quần jean', 'Category': 'Clothes', 'Price': 500}
}

product03 = {
    'ID': 3, 'Product': {'Name': 'iPhoneX 256G', 'Category': 'Electronics', 'Price': 2000}
}

product04 = {
    'ID': 4, 'Product': {'Name': 'MSI Gaming Laptop', 'Category': 'Electronics', 'Price': 3000}
}

product05 = {
    'ID': 5, 'Product': {'Name': 'Máy in HP', 'Category': 'Office Products', 'Price': 2000}
}

product06 = {
    'ID': 6, 'Product': {'Name': 'Toshiba プロジェクター', 'Category': 'Office Products', 'Price': 300}
}

lst_product = [product01, product02, product03, product04, product05, product06]     


lst_tg = list()
for value in lst_product[0].get("Product").values():
            print(value, end='    ', )
# def saler_view():
#     """
#     Hàm giao diện form saler
#     """
#     os.system('cls')
#     #Xóa màn hình
    
#     print("\tXin chào SALER")  
#     print("\tDưới đây là các chức năng của bạn")      
#     print("-----"*13)
#     print("1. \tHiển thị tất cả các sản phẩm")
#     print("2. \tHiển thị các sản phẩm theo thứ tự có giá từ thấp đến cao")
#     print("3. \tHiển thị các sản phẩm theo tên")
#     print("4. \tHiển thị các sản phẩm trong nhóm Clothes")
#     print("5. \tHiển thị các sản phẩm trong nhóm Electronics")
#     print("6. \tHiển thị các sản phẩm trong nhóm Office Products")
#     print("7. \tTìm kiếm sản phẩm theo tên sản phẩm")
#     print("8. \tThêm sản phẩm vào danh sách bán hàng")
#     print("9. \tSửa thông tin sản phẩm")
#     print("10. \tXóa thông tin sản phẩm")
#     print("11. \tThoát")
#     ip_saler = input("Chọn 1 đến 11 để hiển thị chức năng: ")
#     return ip_saler

# def show_all_products():
#     """
#     HÀM HIỂN THỊ TẤT CẢ THÔNG TIN SẢN PHẨM
#     """
#     for index in range(len(lst_product)):
#         for value in lst_product[index].get("Product").values():
#             print("{}".format(value), end='    ')
#         print()

# def check_saler(ip_saler):
#     check_saler = True
#     while check_saler:
#         if str(ip_saler) == '1':
#             show_all_products()
#             check_saler = False
#         else:
#             check_saler = False
# # show_all_products()
# ip_sal = saler_view()
# check_saler(ip_sal)
# def find_for_name():
#     """
#     HÀM TÌM KIẾM SẢN PHẨM THEO TÊN SẢN PHẨM
#     """
#     os.system('cls')
#     lst_tg = list()
#     print("-----" * 13)
#     print("Tìm kiếm sản phẩm theo tên")
#     print("-----" * 13)
#     ip_find = input("Enter Product Name: ")
#     check_find = True
#     for index in range(len(lst_product)):
#         if str(ip_find) == lst_product[index].get["Product"].get["Name"]:
#             lst_tg.append(lst_product[index])
#             check_find = False
#     if check_find:
#         print("Không tìm thấy kết quả")   
#     else:           
#         for index2 in range(len(lst_tg)): 
#             for value in lst_tg[index2].get("Product").values():
#                 print("{}".format(value), end = '    ',)
#             print()   
# find_for_name()
# def increat_product():
#     """
#     HÀM THÊM SẢN PHẨM MỚI
#     """
#     # os.system('cls')
#     print("-----" * 13)
#     print("\tThêm sản phẩm vào danh sách bán hàng")
#     print("-----" * 13)
#     ip_pro = input("Enter Product Name: ")
#     ip_cat = input("Enter Category: ")
#     ip_pri = input("Enter Price: ")
#     dic_increat = dict()
#     dic_increat = product05.copy()
#     dic_increat["ID"] = len(lst_product) + 1
#     dic_increat = product06.copy()
#     dic_increat["Product"] = product06.get("Product").copy()
#     dic_increat["ID"] = len(lst_product) + 1
#     dic_increat.get("Product")["Name"] = ip_pro
#     dic_increat.get("Product")["Category"] = ip_cat
#     dic_increat.get("Product")["Price"] = ip_pri
#     print(product05)
#     print(dic_increat)
#     # lst_product.append(dic_increat)
#     # print("Thêm thành công")  
# increat_product()
# show_all_products()    
# def del_product():
#     """
#     HÀM XÓA THÔNG TIN SẢN PHẨM THEO TÊN SẢN PHẨM
#     """
#     os.system('cls')
#     print("-----" * 13)
#     print("\tXóa thông tin sản phẩm")
#     print("-----" * 13)
#     ip_del = input("Nhập tên sản phẩm muốn xóa: ")
#     ip_del = ip_del.lower()
#     check_del = True
#     for index in range(len(lst_product)):
#         if re.search( r''+str(ip_del)+'',str(lst_product[index].get("Product").get("Name").lower())):
#             check_del = False
#             print("Sản phẩm bạn muốn xóa là: ", end='')
#             for value in lst_product[index].get("Product").values():
#                 print("{}".format(value), end='    ')
#             print()
#             ip_yn = input("Bạn có chắc chắn muốn xóa không ?(Có = y, Không = n): ")
#             if ip_yn.lower() == 'y':
#                 del lst_product[index]
#                 print("DANH SÁCH SẢN PHẨM SAU KHI XÓA:")
#                 show_all_products()
#             elif ip_yn.lower() == 'n':
#                 print("KHÔNG CÓ SẢN PHẨM NÀO BỊ XÓA")  
#             break      
#     if check_del:
#         print("Không có tên sản phẩm mà bạn muốn xóa")
# del_product()        