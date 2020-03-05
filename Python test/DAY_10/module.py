import subfolder.employee as nhan_vien

# from subfolder.employee import _show_me
# from subfolder.employee import *
# from subfolder.employee import MESSAGE,show_me, Employee

def display_on_module():
    print("display on module")

print(nhan_vien.MESSAGE.get("Phone"))
nhan_vien._show_me()

# emp = Employee("Hoang", 32, "Leader")
# print(emp.name)
#
# for link in sys.path:
#     print("link các modules trong python %s " % link)