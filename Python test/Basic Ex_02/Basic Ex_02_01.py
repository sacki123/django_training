def tinhtoan(para1, para2):
    """
    Hàm tìm ra số cho 7 và không chia hết cho 5
    :param param1: số nguyên 
    :param param2: số nguyên
    :return: trả ra các số trong khoảng từ para1 đến para 2 chia hết cho 7 và không chia hết cho 5
    """
    lst = list()
    for index in range(para1, para2 + 1):
        if index % 7 == 0 and index % 5 != 0:
            lst.append(str(index))
    return lst  
a = tinhtoan(6, 28)
print("-".join(a) )      
