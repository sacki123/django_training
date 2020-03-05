ip_str = input("Nhập vào chuỗi: ")
output = ""
dem = len(str(ip_str))
if dem < 2:
    print("Chuỗi mới là: %s" % output)
else:
    output = ip_str[0:2] + ip_str[dem - 2:dem]  
    print("Chuỗi mới là: %s" % output)  

