MESSAGE = {
    'Phone' : 'Iphone',
    'Price' : 15
}

def _show_me():
    print("Hàm trong modules")

class Employee():
    """
    # doc string:Mô tả chung về
    # đặc điểm chưc năng của đối tương
    """
    company = "EXS"
    __salary = 0.0
    # print("Inside", id(__salary))
    # Ham khoi tao __init__
    def __init__(self, ten, tuoi, vitri):
        self.name = ten
        self.age = tuoi
        self.position = vitri