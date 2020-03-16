dct = {'Ten': 'Hoang', 'Tuoi': 7, 'Ten': 'Nam'}
print(dct)
data1 = {
    "ID": 100,
    "Name": "John",
    "Job": "DEV"
}
data2 = {
    "ID": 200,
    "Name": "Mark",
    "Job": "Accountant"
}
#Truy cập phần tử
print("ID : %s - Name : %s" % (data1["ID"], data1["Name"]))
#print("Key không tồn tại : %s " % (data1["ABC"])
if  not data1.get("ABC"):
    print("Key không tồn tại ")
else:
    print("Giá trị là: ", data1["ABC"])  
    for key, value in data1.items():
       print("{} : {}".format(key, value))
  