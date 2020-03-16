def sum(param1, param2):
    """
    Mô tả tác dụng chung của hàm
    :param param1: mô tả chung thông tin của phần tử truyền vào
    :param param2:
    :return: Hàm trả ra cái gì
    """
    total = param1 + param2
    return total
a = sum(10, 20)    
def div(param1, param2):
    if param2 != 0: 
        kq = param1 / param2
        return kq
    else:
        return print("Số bị chia không được bằng 0")
def mul(param1, param2):  
    kq = param1 * param2
    return kq 
def sub(param1, param2):  
    kq = param1 - param2
    return float(kq)    
def tonghop(param1, param2, param3):
    kq = param1 * param2
    kq1 = sub(kq, param3)
    return kq1
b = div(20, 2)   
e= tonghop(2, 5, 7)
c = mul(2, 6)
d = sub(6, 7)
print("Phép nhân là: %0.1f" % c)
print("Phép chia là: %0.1f" % b)
print("Phép trừ là: %0.1f" % d)
print("Tổng hợp là: %0.1f" % e)
def sum1(param1, param2 = 5):
    total = param1 + param2
    return total
f = sum1(6,7)    
print(f)    