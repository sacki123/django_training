

# for value in range(10):
#     print("Số : %d" % value)
lst_number = ["Nam" , "Nguyệt", "Hoàng", "Đẹp"]
# index = 0
# for name in lst_number:
#     index = index + 1
#     print("Số thứ tự %d : Tên : %s" %(index,name))
for index, value in enumerate(lst_number):
    print("Số thứ tự %d : Tên : %s" %(index + 1,value))
# index2 = 0  
# while index2 < len(lst_number):
#     if index2 == 2:
#         #index2 += 1 
#         #pass
#         print("Số bên trong %d : Tên : %s" %(index2 + 1,lst_number[index2]))   
#         index2 += 1 
#     print("Số thứ tự %d : Tên : %s" %(index2 + 1,lst_number[index2]))   
#     index2 += 1 
# Continue
# while index2 < len(lst_number):
#     if index2 == 2:
#         index2 += 1 
#         continue
#         print("Số bên trong %d : Tên : %s" %(index2 + 1,lst_number[index2]))   
#     print("Số thứ tự %d : Tên : %s" %(index2 + 1,lst_number[index2]))   
#     index2 += 1 
