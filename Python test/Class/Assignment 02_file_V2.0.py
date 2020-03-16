import os
import re
import os.path
import xlrd
ip_name = ''


def check_file():
    check = True
    while check:
        global ip_name, fileopen
        ip_name1 = input("Hãy nhập tên file kết thúc = '.txt': ")
        ip_name = ip_name1
        try:
            fileopen = open(ip_name)
        except FileNotFoundError:
            print("File không tồn tại hãy nhập lại tên File")
        else:
            check = False
    lstfile = list(fileopen)
    fileopen.close()
    if len(lstfile) == 0:
        os.system('cls')
        print("File không có thông tin sản phẩm. Hãy nhập lại tên file")
        check_file()
    else:
        fileopen = open(ip_name)
        sread = fileopen.read()
        fileopen.close()
        print("Thông tin sản phẩm File bạn vừa nhập là")
        print(sread)
    comback_file()


def showall_product():
    fileopen = open(ip_name)
    sread = fileopen.read()
    fileopen.close()
    print(sread)


def check_error_products(code, name, price):
    check_product = True
    if not re.fullmatch('[A-Z]{2}[0-9]{4}', str(code)):
        print("Product Code không chính xác")
        check_product = False
    if len(name) > 3000 or len(name) == 0:
        print("Product Name không chính xác")
        check_product = False
    try:
        price = float(price)
        if isinstance(price, float) or isinstance(price, int):
            price = round(price, 2)
            if price <= 0 or price > 1000000:
                print("Product Price không chính xác")
                check_product = False
        else:
            print("Product Price không chính xác")
            check_product = False
    except ValueError as e:
        print("Product Price không chính xác", e)
        check_product = False
    fileopen = open(ip_name)
    lst = list(fileopen)
    fileopen.close()
    for index in lst:
        if index[0:6] == str(code):
            print("Product Code đã tồn tại")
            check_product = False
    return check_product


def increat_product():
    os.system('cls')
    check_increat = True
    while check_increat:
        print("Hãy nhập thông tin sản phẩm mà bạn muốn thêm")
        product_code = input("Enter Product Code: ")
        product_name = input("Enter Product Name: ")
        product_price = input("Enter Product Price: ")
        if check_error_products(product_code, product_name, product_price):
            fileopen = open(ip_name, 'a')
            fileopen.write("\n"+product_code + " " + product_name + " " + product_price)
            fileopen.close()
        ip_inscreat = input("Bạn có muốn thêm sản phẩm nữa không? (Có = 'y' Không = 'n'): ")
        if str(ip_inscreat) == 'y':
            check_increat = True
        elif str(ip_inscreat) == 'n':
            check_increat = False
            break
    showall_product()


def find_productcode():
    ip_findpro = input("Hẫy nhập Product code của sản phẩm mà bạn muốn tìm: ")
    fileopen = open(ip_name)
    lst = list(fileopen.readlines())
    fileopen.close()
    count = 0
    for value in lst:
        if re.search(ip_findpro, value[0:6], re.I):
            print(value, end="")
            count += 1
    if count == 0:
        print("Không có sản phẩm mà bạn muốn tìm")


def sort_product():
    fileopen = open(ip_name)
    lst = list(fileopen)
    fileopen.close()
    if lst[-1][-1] is not "\n":
        lst[-1] = lst[-1] + "\n"
    for index in range(len(lst) - 1):
        for index2 in range(index + 1, len(lst)):
            if lst[index][0:6] > lst[index2][0:6]:
                tg = lst[index]
                lst[index] = lst[index2]
                lst[index2] = tg
    lst[-1] = lst[-1][0:-1]          
    print("Sản phẩm trong file sau khi đã sắp xếp là:")
    fileopen = open(ip_name, 'w+')
    for value in lst:
        fileopen.write(value)
    fileopen.seek(0)
    s = fileopen.read()
    print(s)


def file_form():
    """
    Hàm giao diện form File
    """
    # Xóa màn hình
    os.system('cls')
    print("\t\t(^-^) XIN CHÀO (*-*)")
    print("\t Dưới đây là các chức năng của bạn")
    print("-----" * 13)
    print("1. \tThêm 1 sản phẩm mới")
    print("2. \tTìm sản phẩm theo Product Code")
    print("3. \tHiển thị toàn bộ sản phẩm")
    print("4. \tHiển thị toàn bộ sản phẩm sắp xếp theo  Product Code")
    print("5. \tThoát chương trình")
    ip_file = input("Chọn 1 đến 4 để hiển thị chức năng: ")
    check_ip_file(ip_file)


def comback_file():
    """
    HÀM ĐƯA RA LỰA CHỌN CÓ TRỞ VỀ FORM FILE ĐỂ THỰC HIỆN CÁC CÔNG VIỆC KHÁC NỮA KHÔNG
    """
    check_comeback = True
    while check_comeback:
        ip_comeback = input("\nChọn 'y' để  quay lại màn hình form File, chọn 'n' để thoát chương trình: ")
        if ip_comeback == 'y':
            check_comeback = False
            file_form()
        elif ip_comeback == 'n':
            exit()
        else:
            check_comeback = True


def check_ip_file(ip_file):
    """
    HÀM KIỂM TRA THÔNG TIN NHẬP VÀO
    """
    checkfile = True
    while checkfile:
        if str(ip_file) == '1':
            increat_product()
            checkfile = False
            comback_file()
        elif str(ip_file) == '2':
            find_productcode()
            comback_file()
            checkfile = False
        elif str(ip_file) == '3':
            showall_product()
            comback_file()
            checkfile = False
        elif str(ip_file) == '4':
            sort_product()
            comback_file()
            checkfile = False
        elif str(ip_file) == '5':
            exit()
            checkfile = False
        else:
            print("Xin Mời bạn nhập lại. Bạn chỉ được chọn 1 đến 5")
            checkfile = False


check_file()
file_form()
