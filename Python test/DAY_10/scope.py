
# public
class Employee:
    name = "Tên mặc định"
    _position = "Staff" # Biến protected
    __salary = 0.0 #Biến private

    def __init__(self, age):
        # self.name = name
        # self.position = position
        # self.salary = salary
        self.age = age
        self.__salary = 1000

    def show_salary(self):
        print("Salary of %s is : %.03f " % (self.name, self.__salary))

print(Employee.name)
print(Employee._position)
print(Employee.__salary)
#
# # hoang = Employee(32)
# # hoang.name = "Hoàng"
# # hoang.show_salary()
#
# import re
# class Product:
#
#     def __init__(self, code, name, price):
#         self.code = code
#         self.check_code()
#
#         self.name = name
#         self.check_name()
#
#         self.price = price
#         self.check_price()
#         # self.check_infor()
#
#     def check_code(self):
#         if len(self.code) == 6:
#             if self.code[0].isupper() and self.code[1].isupper():
#                 for i in self.code[2:6]:
#                     if i.isnumeric():
#                         pass
#                     else:
#                         print("Please check format of Product Code")
#             else:
#                 print("Please check format of Product Code")
#         else:
#             print("Please check format of Product Code")
#
#     def check_name(self):
#         # CODE HERE
#         pass
#
#     def check_price(self):
#         # CODE HERE
#         pass
#
#     def check_infor(self):
#         regex_code = "^(?=.*[A-Z].*[A-Z])(?=.*[0-9].*[0-9].*[0-9].*[0-9]).{6}$"
#         if not re.match(regex_code, self.code):
#             print("Please check format of Product Code")
#         else:
#             if not len(self.name) <= 30:
#                 print("Please check format of Product Name")
#             else:
#                 try:
#                     temp = float(self.price)
#                     if not temp >= 0 and temp <= 1000000:
#                         print("Please check format of Product Price")
#                     else:
#                         print("Product object create success")
#                 except ValueError:
#                         print("Please check format of Product Price")
#
#
# product_01 = Product("AB00a1", "Toshiba Projector", 12.5)


# str_a = "ABad1234"

# for letter in str_a:
#     if letter.isupper():
#         print("%s là kí tự in hoa" %letter)
#     elif letter.islower():
#         print("%s là kí tự thường" %letter)
#     elif letter.isnumeric():
#         print("%s là kí tự số" %letter)