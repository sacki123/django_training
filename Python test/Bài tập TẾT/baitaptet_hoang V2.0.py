import os
import re
import copy
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


def main_show():
    """
    Hàm chính của chương trình đưa ra các lựa chọn cho người dùng
    :return: giá trị trả về của hàm là giá trị mà người dùng nhập vào từ bàn phím
    """
    string1 = "Chọn 1 Nếu bạn là người bán hàng: "
    string2 = "Chọn 2 Nếu bạn là người mua hàng: "
    print(string1.rjust(len(string1) + 10))
    print(string2.rjust(len(string2) + 10))
    ip = input("\t  Chọn 1 hoặc 2 để hiển thị chức năng: ")
    return ip


def buyer_view():
    """
    Hàm giao diện form Buyer
    """
    # Xóa màn hình
    os.system('cls')
    print("\tXin chào BUYER")
    print("\tDưới đây là các chức năng của bạn")
    print("-----" * 13)
    print("1. \tTìm kiếm sản phẩm theo tên sản phẩm")
    print("2. \tHiển thị tất cả các sản phẩm")
    print("3. \tHiển thị các sản phẩm theo thứ tự có giá từ thấp đến cao")
    print("4. \tHiển thị các sản phẩm theo tên")
    print("5. \tHiển thị các sản phẩm theo nhóm các Categogy")
    print("6. \tThoát")
    ip_buyer = input("Chọn 1 đến 6 để hiển thị chức năng: ")
    check_ip_buyer(ip_buyer)


def saler_view():
    """
    Hàm giao diện form saler
    """
    os.system('cls')
    # Xóa màn hình
    print("\tXin chào SALER")
    print("\tDưới đây là các chức năng của bạn")
    print("-----" * 13)
    print("1. \tHiển thị tất cả các sản phẩm")
    print("2. \tHiển thị các sản phẩm theo thứ tự có giá từ thấp đến cao")
    print("3. \tHiển thị các sản phẩm theo tên")
    print("4. \tHiển thị các sản phẩm trong nhóm Clothes")
    print("5. \tHiển thị các sản phẩm trong nhóm Electronics")
    print("6. \tHiển thị các sản phẩm trong nhóm Office Products")
    print("7. \tTìm kiếm sản phẩm theo tên sản phẩm")
    print("8. \tThêm sản phẩm vào danh sách bán hàng")
    print("9. \tSửa thông tin sản phẩm")
    print("10. \tXóa thông tin sản phẩm")
    print("11. \tThoát")
    ip_saler = input("Chọn 1 đến 11 để hiển thị chức năng: ")
    check_ip_saler(ip_saler)


def show_all_products():
    """
    HÀM HIỂN THỊ TẤT CẢ THÔNG TIN SẢN PHẨM
    """
    for index in range(len(lst_product)):
        for value in lst_product[index].get("Product").values():
            print("{}".format(value), end='    ', )
        print()


def show_sort_price():
    """
    HÀM HIỂN THỊ THÔNG TIN SẢN PHẨM CÓ THỨ TỰ TỪ THẤP ĐẾN CAO
    """
    lst_tg = lst_product.copy()
    for index in range(len(lst_tg) - 1):
        for index2 in range(index + 1, len(lst_tg)):
            if int(lst_tg[index].get("Product").get("Price")) > int(lst_tg[index2].get("Product").get("Price")):
                tg = lst_tg[index]
                lst_tg[index] = lst_tg[index2]
                lst_tg[index2] = tg
    for index in range(len(lst_tg)):
        for value in lst_tg[index].get("Product").values():
            print("{}".format(value), end='    ', )
        print()


def show_sort_name():
    """
    HÀM HIỂN THỊ THÔNG TIN SẢN PHẨM THEO TÊN
    """
    lst_tg = lst_product.copy()
    for index in range(len(lst_tg) - 1):
        for index2 in range(index + 1, len(lst_tg)):
            if lst_tg[index].get("Product").get("Name") < lst_tg[index2].get("Product").get("Name"):
                tg = lst_tg[index]
                lst_tg[index] = lst_tg[index2]
                lst_tg[index2] = tg
    for index in range(len(lst_tg)):
        for value in lst_tg[index].get("Product").values():
            print("{}".format(value), end='    ', )
        print()


def show_sort_category():
    """
    HÀM HIỂN THỊ THÔNG TIN SẢN PHẨM THEO CATEGORY
    """
    lst_tg = lst_product.copy()
    for index in range(len(lst_tg) - 1):
        for index2 in range(index + 1, len(lst_tg)):
            if lst_tg[index].get("Product").get("Category") > lst_tg[index2].get("Product").get("Category"):
                tg = lst_tg[index]
                lst_tg[index] = lst_tg[index2]
                lst_tg[index2] = tg
    for index in range(len(lst_tg)):
        for value in lst_tg[index].get("Product").values():
            print("{}".format(value), end='    ', )
        print()


def show_clothes():
    """
    HÀM HIỂN THỊ THÔNG TIN SẢN PHẨM TRONG NHÓM CLOTHES
    """
    lst_tg = list()
    for index in range(len(lst_product)):
        if lst_product[index].get("Product").get("Category") == 'Clothes':
            lst_tg.append(lst_product[index])
    for index2 in range(len(lst_tg)):
        for value in lst_tg[index2].get("Product").values():
            print("{}".format(value), end='    ', )
        print()


def show_electronics():
    """
    HÀM HIỂN THỊ THÔNG TIN SẢN PHẨM TRONG NHÓM Electronics
    """
    lst_tg = list()
    for index in range(len(lst_product)):
        if lst_product[index].get("Product").get("Category") == 'Electronics':
            lst_tg.append(lst_product[index])
    for index2 in range(len(lst_tg)):
        for value in lst_tg[index2].get("Product").values():
            print("{}".format(value), end='    ', )
        print()


def show_office_products():
    """
    HÀM HIỂN THỊ THÔNG TIN SẢN PHẨM TRONG NHÓM Office Products
    """
    lst_tg = list()
    for index in range(len(lst_product)):
        if lst_product[index].get("Product").get("Category") == 'Office Products':
            lst_tg.append(lst_product[index])
    for index2 in range(len(lst_tg)):
        for value in lst_tg[index2].get("Product").values():
            print("{}".format(value), end='    ', )
        print()     


def find_for_name():
    """
    HÀM TÌM KIẾM SẢN PHẨM THEO TÊN SẢN PHẨM
    """
    os.system('cls')
    lst_tg = list()
    print("-----" * 13)
    print("Tìm kiếm sản phẩm theo tên")
    print("-----" * 13)
    ip_find = input("Enter Product Name: ")
    ip_find = ip_find.lower()
    check_find = True
    for index in range(len(lst_product)):
        if re.search( r''+str(ip_find)+'',str(lst_product[index].get("Product").get("Name").lower())):
            lst_tg.append(lst_product[index])
            check_find = False
    if check_find:
        print("Không tìm thấy kết quả")
    else:
        for index2 in range(len(lst_tg)):
            for value in lst_tg[index2].get("Product").values():
                print("{}".format(value), end='    ', )
            print()


def increat_product():
    """
    HÀM THÊM SẢN PHẨM MỚI
    """
    check_ippri = True
    os.system('cls')
    print("-----" * 13)
    print("\tThêm sản phẩm vào danh sách bán hàng")
    print("-----" * 13)
    ip_pro = input("Enter Product Name: ")
    ip_cat = input("Enter Category: ")
    while check_ippri:
        try:
            ip_pri = input("Enter Price: ")
            ip_pri = float(ip_pri)
            if isinstance(ip_pri, float):
                dic_increat = copy.deepcopy(product06)
                # dic_increat["Product"] = product06["Product"].copy()
                dic_increat["ID"] = len(lst_product) + 1
                dic_increat.get("Product")["Name"] = ip_pro
                dic_increat.get("Product")["Category"] = ip_cat
                dic_increat.get("Product")["Price"] = ip_pri
                lst_product.append(dic_increat)
                print("Thêm thành công")
                print("DANH SÁCH SẢN PHẨM SAU KHI THAY ĐỔI:")
                check_ippri = False
                show_all_products()
        except :
            os.system('cls')
            print("Bạn phải nhập giá theo kiểu số thực")    


def edit_product():
    """
    HÀM SỬA THÔNG TIN SẢN PHẨM THEO TÊN SẢN PHẨM
    """
    os.system('cls')
    print("-----" * 13)
    print("\tSửa thông tin sản phẩm")
    print("-----" * 13)
    ip_edit = input("Nhập tên sản phẩm muốn sửa: ")
    ip_edit = ip_edit.lower()
    check_edit = True
    check_ippri = True
    for index in range(len(lst_product)):
        if re.search( r''+str(ip_edit)+'',str(lst_product[index].get("Product").get("Name").lower())):
            print("Sản phẩm bạn muốn sửa là: ", end='')
            for value in lst_product[index].get("Product").values():
                print("{}".format(value), end='    ')
            print()
            ip_edit_name = input("Enter Name: ")
            ip_edit_cat = input("Enter Category: ")
            while check_ippri:
                try:
                    ip_edit_pri = input("Enter Price: ")
                    ip_edit_pri = float(ip_edit_pri)
                    if isinstance(ip_edit_pri, float):
                        lst_product[index]["Product"]["Name"] = ip_edit_name
                        lst_product[index]["Product"]["Category"] = ip_edit_cat
                        lst_product[index]["Product"]["Price"] = ip_edit_pri
                        check_edit = False
                        print("DANH SÁCH SẢN PHẨM SAU KHI THAY ĐỔI:")
                        check_ippri = False
                        show_all_products()
                except ValueError:
                    os.system('cls')
                    print("Bạn phải nhập giá theo kiểu số thực")  
    if check_edit:
        print("Không tìm thấy tên sản phẩm trùng khớp")


def del_product():
    """
    HÀM XÓA THÔNG TIN SẢN PHẨM THEO TÊN SẢN PHẨM
    """
    os.system('cls')
    print("-----" * 13)
    print("\tXóa thông tin sản phẩm")
    print("-----" * 13)
    ip_del = input("Nhập tên sản phẩm muốn xóa: ")
    ip_del = ip_del.lower()
    check_del = True
    for index in range(len(lst_product)):
        if re.search( r''+str(ip_del)+'',str(lst_product[index].get("Product").get("Name").lower())):
            check_del = False
            print("Sản phẩm bạn muốn xóa là: ", end='')
            for value in lst_product[index].get("Product").values():
                print("{}".format(value), end='    ')
            print()
            ip_yn = input("Bạn có chắc chắn muốn xóa không ?(Có = y, Không = n): ")
            if ip_yn.lower() == 'y':
                del lst_product[index]
                print("DANH SÁCH SẢN PHẨM SAU KHI XÓA:")
                show_all_products()
            elif ip_yn.lower() == 'n':
                print("KHÔNG CÓ SẢN PHẨM NÀO BỊ XÓA")    
            break        
    if check_del:
        print("Không có tên sản phẩm mà bạn muốn xóa")


def comback_saler():
    """
    HÀM ĐƯA RA LỰA CHỌN CÓ TRỞ VỀ FORM SALER ĐỂ THỰC HIỆN CÁC CÔNG VIỆC KHÁC NỮA KHÔNG
    """
    check_comeback = True
    while check_comeback:    
        ip_comeback = input("Chọn 'y' để  quay lại màn hình SALER, chọn 'n' để thoát chương trình: ")
        if ip_comeback == 'y':
            check_comeback = False
            saler_view()
        elif ip_comeback == 'n':
            exit()
        else:
            check_comeback = True  


def comback_buyer():
    """
    HÀM ĐƯA RA LỰA CHỌN CÓ TRỞ VỀ FORM BUYER ĐỂ THỰC HIỆN CÁC CÔNG VIỆC KHÁC NỮA KHÔNG
    """
    check_comeback = True
    while check_comeback:    
        ip_comeback = input("Chọn 'y' để  quay lại màn hình BUYER, chọn 'n' để thoát chương trình: ")
        if ip_comeback == 'y':
            check_comeback = False
            buyer_view()
        elif ip_comeback == 'n':
            exit()
        else:
            check_comeback = True  


def check_ip_saler(ip_saler):
    """
    HÀM KIỂM TRA THÔNG TIN NHẬP VÀO CỦA SALER
    """
    check_sal = True
    while check_sal:
        if str(ip_saler) == '1':
            show_all_products()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '2':
            show_sort_price()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '3':
            show_sort_name()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '4':
            show_clothes()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '5':
            show_electronics()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '6':
            show_office_products()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '7':
            find_for_name()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '8':
            increat_product()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '9':
            edit_product()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '10':
            del_product()
            comback_saler()
            check_sal = False
        elif str(ip_saler) == '11':
            exit()
            check_sal = False
        else:
            print("Xin Mời bạn nhập lại. Bạn chỉ được chọn 1 đến 11")
            comback_saler()
            check_sal = False


def check_ip_buyer(ip_buyer):
    """
    HÀM KIỂM TRA THÔNG TIN NHẬP VÀO CỦA BUYER
    """
    check_buy = True
    while check_buy:
        if str(ip_buyer) == '1':
            find_for_name()
            comback_buyer()
            check_buy = False
        elif str(ip_buyer) == '2':
            show_all_products()
            comback_buyer()
            check_buy = False
        elif str(ip_buyer) == '3':
            show_sort_price()
            comback_buyer()
            check_buy = False
        elif str(ip_buyer) == '4':
            show_sort_name()
            comback_buyer()
            check_buy = False
        elif str(ip_buyer) == '5':
            show_sort_category()
            comback_buyer()
            check_buy = False
        elif str(ip_buyer) == '6':
            exit()
            check_buy = False
        else:
            print("Xin Mời bạn nhập lại. Bạn chỉ được chọn 1 đến 6")
            comback_buyer()
            check_buy = False


def check_input_main(ip):
    """
    Hàm kiểm tra dữ liệu người dùng nhập vào có đúng theo quy định hay không
    """
    check_ip_main = True
    while check_ip_main:
        if str(ip) != '1' and str(ip) != '2':
            os.system('cls')
            print("Xin Mời bạn nhập lại. Bạn chỉ được chọn 1 hoặc 2")
            print("-----" * 13)
            ip = main_show()
        elif str(ip) == '1':
            saler_view()
            check_ip_main = False
        elif str(ip) == '2':
            buyer_view()
            check_ip_main = False

ip_main = main_show()
check_input_main(ip_main)
