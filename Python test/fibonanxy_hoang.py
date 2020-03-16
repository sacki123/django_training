index = 1
t1 = 1
t2 = 1
total = 1
check = True
while check == True:
    count = input("Hãy nhập số lượng phần tử của dãy Fibonanxy: ") 
    if count.isdigit():
        check = False
        if int(count) == 1:
            print("1")
        elif int(count) == 2:
            print("1-1")
        else:    
            fb = ['1','1']
            for index in range(int(count)-2):
                total = int(t1) + int(t2)
                fb.append(str(total))
                t1 = t2
                t2 = total 
            print("Dãy Fibonaxi là: "+ "-".join(fb))
    else:
        print("Hãy nhập số tự nhiên ")
     


