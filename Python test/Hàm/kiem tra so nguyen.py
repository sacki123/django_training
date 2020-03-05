def songuyento(n):
    if n > 2:    
        for index in range(2,n):
            if n % index == 0:
                check = True
                break
            else: 
                check = False    
        if check == False:
            print("Đây là số nguyên tố")
        else: 
            print("Đây không phải là số nguyên tố")    
    elif n == 2:
        print("Đây là số nguyên tố")    
    elif n == 1:  
        print("Đây không phải là số nguyên tố")   
songuyento(102)
        