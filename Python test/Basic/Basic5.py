ip = input("Nhập 1 (JPY - VND) -- Nhập 2 (VND - JPY) -- Thoát chương trình chọn phím bất kỳ :")
if ip == 1:
    injpy = input("Nhập vào số tiền JPY : ")
    print("Số tiền %s JPY sang VND là : %d VND" % (injpy,int(injpy)*200))
if ip == 2:
    invnd = input("Nhập vào số tiền VND : ")
    print("Số tiền %s VND sang JPY là : %d JPY" % (invnd,int(invnd)/200))
if (ip != 1 and ip != 2) or isinstance(ip,str):
    print("XIN CHÀO VÀ HẸN GẶP LẠI") 
        