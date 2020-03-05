import re
import csv

# class Employee():
#     # name = "Tên mặc định"
#     # position = "Staff"
#     # __salary = 1000.0
#     name ="H"
#     name1 = "T"
#     def __init__(self, age, name1, position, salary):
#         self.name = "hung"
#         self.position = position
#         self.salary = salary
#         self.age = age   
#     def show_salary(self):
#         print(self.name, Employee.name)            
# hoang = Employee(32,"Hoàng", "Staff", 8)
# print(Employee.name1)
# print(hoang.name1)
# Employee.__init__(5,"a","t",5)
# # print(hoang.name)
# hoang.show_salary()
# # print(Employee.name)
# # Employee.__salary = 1
# # Employee.position = "H"
# # print(hoang.position)
# # print(Employee.__doc__)
# # hoang.show_salary()
with open('order_detail.csv', encoding = 'utf-8') as file_test:
    reader = csv.reader(file_test)
    for row in reader:
        print(row)
        

