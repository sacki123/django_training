import re
from os import system, name


# Khai báo cấu trúc Class
class Product:
    regexCode = "^(?=.*[A-Z].*[A-Z])(?=.*[0-9].*[0-9].*[0-9].*[0-9]).{6}$"
    ProductCode = "AA0000"
    ProductName = "Noname"
    ProductPrice = 0.00

# Phương thức khởi tại
    def __init__(self, PC, PN, PP):
        self.ProductCode = PC
        self.ProductName = PN
        self.ProductPrice = PP

# Kiểm tra điều kiện format của object theo yêu cầu bài ra
    def check(self):
        if not self.checkProductCode():
            print("Product Code chỉ có thể là dạng 'AA0123'")
            return False
        elif not self.checkProductName():
            print("Bạn nhập sai quy định về Product Name, vượt quá 30 ký tự")
            return False
        elif not self.checkProductPrice():
            print("Giá sản phẩm phải lớn hơn 0 và nhỏ hơn 1000000")
            return False
        else:
            return True

# Kiểm tra điều kiện của Product Code
    def checkProductCode(self):
        return re.match(self.regexCode, self.ProductCode)

# Kiểm tra điều kiện của Product Name
    def checkProductName(self):
        if len(self.ProductName) < 30:
            return True
        else:
            return False

# Kiểm tra điều kiện về Price và làm tròn đối tượng theo format
    def checkProductPrice(self):
        self.ProductPrice = float("{0:.2f}".format(float(self.ProductPrice)))
        if self.ProductPrice > 0 and self.ProductPrice < 1000000:
            return True
        else:
            return False


# Add data from File to List
def loadFromFile(file_name):
    file_temp = open(file_name, "r")
    for line in file_temp:
        line.replace("\n", "")
        stringline = line.split(" ")
        product = Product(stringline[0], stringline[1], stringline[2])
        lst.append(product)
    file_temp.close()


# Tạo file với tên theo yêu cầu
def createFile():
    print("Mời nhập tên file cần tạo: ")
    filename = input()
    file_destination = open(filename + ".txt", "w")
    file_sample = open("File Sample.txt", "r")
    for line in file_sample:
        file_destination.write(line)
    print(file_destination.name + " Đã được tạo cùng với data mặc định \n\n")
    file_destination.close()
    file_sample.close()
    loadFromFile(file_destination.name)
    print("-------------------")
    return file_destination.name


# Tạo sản phẩm với các tham số
def createProduct():
    print("Mời nhập thông tin sản phẩm:")
    print("Mã sản phẩm:")
    pCode = input()
    print("Tên sản phẩm:")
    pName = input()
    print("Giá sản phẩm:")
    pPrice = input()
    new_product = Product(pCode, pName, pPrice)
    check_exist_product = True
    for obj in lst:
        if obj.ProductCode == new_product.ProductCode:
            print("Sản phẩm bị trùng lặp")
            check_exist_product = False
    if new_product.check() and check_exist_product:
        lst.append(new_product)
        print("Sản phẩm đã được thêm vào thành công")
        print("-------------------")
    else:
        print("Vui lòng kiểm tra lại thông tin cần nhập")
        print("-------------------")


# Tìm sản phẩm theo Product Code
def findProductByCode():
    print("Vui lòng nhập vào Product Code muốn tìm:")
    pcode_to_find = input()
    print("Kết quả cần tìm là:")
    for obj in lst:
        if obj.ProductCode.find(pcode_to_find) != -1:
            print(obj.ProductCode, " ", obj.ProductName, " ", obj.ProductPrice)
    print("-------------------")


# Hiển thị toàn bộ sản phẩm
def displayAllProduct():
    print("Tất cả sản phẩm trong file và bộ nhớ tạm thời:")
    for obj in lst:
            print(obj.ProductCode, " ", obj.ProductName, " ", obj.ProductPrice)
    print("-------------------")


# Hiển thị toàn bộ sản phẩm được sắp xếp theo thứ tự bởi Product Code
def displayAllProductByCode():
    def sortByCode(obj):
        return obj.ProductCode

    lst2 = sorted(lst, key=sortByCode)
    print("Tất cả sản phẩm trong file và bộ nhớ đã sort:")
    for obj in lst2:
            print(obj.ProductCode, " ", obj.ProductName, " ", obj.ProductPrice)
    print("-------------------")


# Lưu toàn bộ sản phẩm vào file
def saveAllProduct():
    f = open(filename + ".txt", "r+")
    f.seek(0)
    f.truncate()
    for obj in lst:
        f.write(obj.ProductCode
                + " " + obj.ProductName
                + " " + str(obj.ProductPrice) + "\n\n")
    f.close()


# Main body của application
def MainBody():
    print("App Product Control v1.0")
    global lst
    global filename
    filename = ""
    lst = []
    while True:
        print("Vui lòng chọn theo hướng dẫn sau:")
        print("1- Gõ '1' khi cần tạo file lưu dữ liệu")
        print("2- Gõ '2' để nhập thêm Product vào danh sách tạm")
        print("3- Gõ '3' để tìm sản phẩm theo Product Code")
        print("4- Gõ '4' để hiển thị toàn bộ sản phẩm đã nhập")
        print("5- Gõ '5' hiển thị toàn bộ sản phẩm và sort theo Product Code")
        print("6- Gõ '6' lưu toàn bộ dữ liệu từ ds tạm vào file")
        print("7- Gõ '0' kết thúc ứng dụng")
        options = str(input())
        if options == "1":
            system("cls")
            createFile()
            
        if options == "2":
            system("cls")
            createProduct()

        if options == "3":
            system("cls")
            findProductByCode()

        if options == "4":
            system("cls")
            displayAllProduct()

        if options == "5":
            system("cls")
            displayAllProductByCode()

        if options == "6":
            system("cls")
            saveAllProduct()

        if options == "0":
            break

    print("Hẹn gặp lại bài sau ^_^")

MainBody()
