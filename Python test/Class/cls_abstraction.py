from abc import ABC, abstractclassmethod
# Khai báo
class ClassName(ABC):
    def __init__(self, name, age, city):
        self.name = name
        self.age = age
        self.city = city

    @abstractclassmethod
    def abstraction_name(self):
        pass

        
class Person(ClassName):
    def __init__(self, name, age, city):
        super().__init__(name, age, city)  

    def abstraction_name(self):
        print("%s - %s - %s" %(self.name, self.age, self.city))         
person_01 = Person("Hoàng", 32, "Hà Nội")
person_01.abstraction_name()