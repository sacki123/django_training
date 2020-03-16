import inspect
# Class Example
# Cú pháp
class Employee():
    """
    # doc string:Mô tả chung về 
    # đặc điểm chưc năng của đối tương
    """
    # khai bao thuộc tính
    # là các biến ở trong class
    # thuoocj tinhs chung
    company = "EXS"
    __salary = 0.0
    # print("Inside", id(__salary))
    # Ham khoi tao __init__
    def __init__(self, ten, tuoi, vitri):
        self.name = ten
        self.age = tuoi
        self.position = vitri

    def get_salary(self):
        # self.__salary = salary
        print(self.__salary)

    def set_salary(self, salary):
        print("set salary")
        self.__salary = salary

    # Instance method
    def instance_method_01(self):
        print("Instance method")

    # Instance method
    def instance_method_02(self, Status):
        print("Instance method chứa thông tin trạng thái làm việc là %s" % Status)

    # Class method
    @classmethod
    def class_method_01(cls):
        print("Đây là CLASS method")
        cls.company = "FPT"
        print("Company change to : ", cls.company)

    @staticmethod
    def static_method_01():
        print("Đây là STATIC method")


print(id(Employee))
dep = Employee("DEP", "25", "staff")
print(id(dep))
print("--------------------")
nam = Employee("NAM", "25", "staff")
print(id(nam))
Employee.__salary = 2000
print(Employee.__salary)
nam.run = 30
Employee.abc = "ABC"
# print(dep.run)


# print("Attribute %s" % Employee.__getattribute__)
# print("NAM infor %s" % nam.abc)
# all_atts = inspect.getmembers(Employee, lambda a:not(inspect.isroutine(a)))
# for values in all_atts:
#     print(values)

# print(id(Employee.__salary))
# dep = Employee("Dep", "25", "staff")
# dep.set_salary(500)
# print("Company : %s" % Employee.company)
# print("Salary : %f" % dep.__Salary)
# Employee.class_method_01()
# Employee.static_method_01()
# hoang = Employee("Hoang", "32", "staff")

# print("Company after: %s" % hoang.company)

# dep.instance_method_02("Working")
# # Employee.instance_method_02("Tán gái")

# dep.class_method_01()
# Employee.class_method_01()

# dep.static_method_01()
# Employee.static_method_01()



# dep.depart = "IT"
# dep.instance_method_02("Đang làm việc")
# dep.company = "FPT"
# dep.name = "Rat dep"
# hoang.instance_method_02("Đang tán gái")

# print("Name %s Status %s" % (dep.name, dep.status))
# print("Status %s" % hoang.status)

# print("Company %s" % dep.company)
# print("Name %s" % dep.name)
# print("Company %s" % hoang.company)

# print("Name %s" % dep.name)
# print("AGE %d" % int(dep.age))
# print("Posstion %s" % dep.position)
# print("Department %s" % dep.depart)

# print("Name %s" % hoang.name)
# print("AGE %d" % int(hoang.age))
# print("Posstion %s" % hoang.position)
# print("Department %s" % hoang.depart)