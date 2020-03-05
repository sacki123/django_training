lst_a = [15, "ABC", 30.2, {"A":20}]
# lst_b=list()
# ip = input("Hãy nhập vào số lượng phần tử của list: ")
# ip1 = input("Hãy nhập phần tử thứ 1 của list: ")
total = 0
# for value in range(len(lst_a)):
for index,value in enumerate(lst_a):
    # if isinstance(lst_a[value], int) or isinstance(lst_a[value], float):
    if isinstance(value, int) or isinstance(value, float):
        total = total + float(value)     
print("Tổng các phần tử là số trong List là: %0.1f" % total)        