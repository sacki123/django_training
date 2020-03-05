def giaithua(para):
    """
    Hàm tính giai thừa của một số nguyên 
    :param param1: số nguyên truyền vào
    :return: Hàm trả về giai thừa của số nguyên
    """
    mul = 1
    if para == 0:
        return 0
    else:
        for index in range(1, para + 1):
            mul = mul * index
        return mul
a = giaithua(8)
print(a)


            