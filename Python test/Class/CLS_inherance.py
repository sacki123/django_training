class Animal:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def display(self):
        print("Class Animal")
        print("Name : %s - age : %s" %(self.name,self.age))
class Dog(Animal):
    def __init__(self, type_of_dog):
        self.type = type_of_dog
    def display(self):
        print("Class Dog")
        print("Name : %s - age : %s" %(self.name,self.age))   
dog_01 = Dog("Bull")
dog_01.name = "Rex"
dog_01.age = 5
print(dog_01.__class__.__bases__[0].display(dog_01.__class__.__bases__[0]))