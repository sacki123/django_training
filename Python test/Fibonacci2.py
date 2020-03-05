n = input("Nhập số lượng phần tử của dãy Fibonacci : " )
n = int(n)
n1 = 1
n2 = 1
count = 0

# kiểm tra số nhập vào

if n <= 0:
    print("Hãy nhập số tự nhiên: " )
#elif n==str:6
 #   print("Nhập sai")
elif n == 1:
    print("Dãy Fibonacci chạy đến lần thứ: ",n,)
    print(n1)
else:
    print("Dãy Fibonacci khi chạy đến lần thứ",n, "là: ")
    while count < n:
        if count == n-1:
            print(n1,)
        else:    
            print(n1,end=' - ')
        ntt = n1 + n2
        # cập nhật giá trị
        n1 = n2
        n2 = ntt
        count += 1