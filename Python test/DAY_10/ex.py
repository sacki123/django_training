class Car():
    def __init__(self, name, color, max_speed):
        self.name = name
        self.color = color
        self.max_speed = max_speed

    def display(self):
        print("Name : %s - Color : %s - Max speed : %s" % (self.name, self.color, self.max_speed))


car_01 = Car("Toyota", "Red", 150)
car_02 = Car("Huyndai", "Yellow", 90)
car_03 = Car("Honda", "White", 100)
car_04 = Car("Civic", "Red", 200)
car_05 = Car("Porche", "Red", 250)

lst_car = [car_01, car_02, car_03, car_04, car_05]

for car in lst_car:
    if car.name == "Toyota":
        car.display()
