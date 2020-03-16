class Cup:
    color = "No color"
    _material = "No infor"
    __price = 0.0 # private variable
    def __init__(self):
        self.color = None
        self._material = None # protected variable
        self.__price = 0.0 # private variable

    def fill(self, material):
        self._material = material

    def empty(self):
        self._content = None

print(Cup.color)
print(Cup._material)
print(Cup.__price)
