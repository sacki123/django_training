import re
ip_user = input("User Name: ")
ip_pas = input("Nhập Password: ")
check = True
while check:
    if re.search(r'[a-z]',ip_pas,) and \
        re.search(r'[A-Z]',ip_pas,) and \
        re.search(r'\W',ip_pas,) and \
        re.search(r'[0-9]',ip_pas,) and \
        len(ip_pas) >= 6 and \
        len(ip_pas) <= 12: 
        check = False
    else:    
        ip_pas = input("Nhập Password: ")
    
    # if ip_pas.isdigit():
    # #     check = True
    # if ip_pas.isalnum(): 
    #     check = True
    # elif ip_pas.isalpha():   
    #     check = True    
    # elif len(ip_pas) < 6 or len(ip_pas) > 12:
    #     check = True
    # elif ip_pas.isupper():
    #     check = True
    # elif ip_pas.islower():
    #     check = True 
    # else:
    #     check = False      
    # if re.search(r'(^[a-zA-Z0-9]*$)',ip_pas) and re.search(r'(\W)',ip_pas) :
    #     check = False
