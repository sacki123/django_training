class test:
    """
    # doc string: Mô tả chung cho chính đối tượng đấy về đặc điểm chức năng của đối tượng
    """
    s = "ABC"
    def __init__(self,name,age):
        self.name = name
        self.age = age
    pass
    # Instance method
    def instance_method(self, status):   
        print("Instance method có chứa thông tin trạng thái làm việc là: %s" %status)
    @classmethod
    def class_method(cls):   
        cls.s = "HHHH"
        print("Change: ", cls.s)
    @staticmethod
    def static_method(status):   
        print("Đây là Static Method" %status)
sv = test("Hoàng",32)
print(sv.s)
sv.s = "BBB"
print(sv.s)
test.class_method()
sv1 = test("Huy", 19)
print(sv1.s)
print(sv.s)
# print(sv.name)  
# print(sv.age)   
# sv.instance_method("Đang tán gái")