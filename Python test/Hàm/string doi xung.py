def doi_xung(s):
    dem = len(s) - 1
    for index in range(int(len(s) / 2)):
        if s[index] == s[dem - index]:
            check = True
        else: 
            check = False
            break
    if check:
        print("Chuỗi đối xứng")
    else: 
        print("Chuỗi không đối xứng")  
doi_xung("123321")  
def (self, parameter_list):
    pass