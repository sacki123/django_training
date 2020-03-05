

# class BaseClass1:
#     pass
# class BaseClass2:
#     pass
# class BaseClass3:
#     pass

# class SubClass(BaseClass1, BaseClass2, BaseClass3):
#     pass

# class SubClass2(SubClass):
#     pass

class Animal:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def display(self):
        print("Class Animal")
        print("Name : %s - age : %s" %(self.name, self.age))

    def speak(self):
        print("I'm Animal")

class Dog(Animal):
    def __init__(self, type_of_dog):
        # super().__init__(self, name, age)
        self.type_of_dog = type_of_dog

    def display(self):
        print("Name : %s - age : %s" %(self.name, self.age))

    def speak(self):
        print("GAU GAU")

class Cat(Animal):
    def __init__(self, type_of_cat):
        # super().__init__(self, name, age)
        self.type_of_cat = type_of_cat

    def display(self):
        print("Name : %s - age : %s" %(self.name, self.age))

    def speak(self):
        print("Meo Meo")


dog_01 = Dog("Bull")
dog_01.speak()

cat_01 = Cat("A")
cat_01.speak()