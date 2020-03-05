def sotunhien(para):
    """
    Hàm in ra một list
    :param param1: số nguyên là tham số truyền vào 
    :return: trả về một list
    """
    dic = dict()
    for index in range(1, para + 1):
        dic[index] = index * index
    return dic  
che = True
while che == True:  
    ip = input(" Nhập vào một số tự nhiên: ")
    if ip.isdigit() == False:
        print("Bạn phải nhập vào một số tự nhiên")
    else:
        che = False   
        dic = sotunhien(int(ip))
        print(dic) 
