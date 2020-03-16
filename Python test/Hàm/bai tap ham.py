string = "hello world and practice makes perfect and hello again"
def upper(para):
    para = para.upper()
    return para
def delete(para):
    lst = list()
    lst = para.split()
    lst1 = list()
    # lst2 = list()
    for index in range(len(lst) - 1):
        for index1 in range(index + 1, len(lst)):
            if lst[index] == lst[index1]:
                lst1.append(lst[index])  
    for index2 in range(len(lst) -1, -1, -1):
        if lst[index2] in lst1:
            del lst[index2]
    # for value in lst:
    #     if value not in lst1:
    #         lst2.append(value)
    # return(lst2)
    return(lst)
def sort(para):
    lst = delete(para)
    lst.sort()
    return lst 
print("Chuỗi sau khi chuyển thành hoa: ",upper(string))  
print("Chuỗi sau khi xóa các chữ giống nhau: ",delete(string))  
print("Chuỗi sau khi sắp xếp: ",sort(string))