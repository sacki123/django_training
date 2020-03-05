tu1 = ('Nam', '19', '80')
tu2 = ('Nguyệt', '18', '91')
tu3 = ('Hoàng', '20', '90')
tu4 = ('Nguyệt', '17', '91')
tu5 = ('Nguyệt', '17', '93')
tu6 = ('Nguyên', '21', '85')
tu7 = ('Dẹp', '22', '80')
lst = list(zip(tu1, tu2, tu3, tu4, tu5, tu6, tu7))
index = 0
index1 = 0
print(lst)
lst = list(zip(*lst))
print(lst)
lst_tg = list()
for index, value in enumerate(lst):
    for index1, value1 in enumerate(lst):
        if value[0] < value1[0]:
            lst_tg = lst[index]
            lst[index] = lst[index1]
            lst[index1] = lst_tg
print(lst)
index2 = 0
index3 = 0
dem = len(lst)
for index2 in range(dem):
    for index3 in range(index2+1, dem):
        if lst[index2][0] == lst[index3][0]:
            if int(lst[index2][1]) < int(lst[index3][1]):
                lst_tg = lst[index2]
                lst[index2] = lst[index3]
                lst[index3] = lst_tg
index2 = 0
index3 = 0                
for index2 in range(dem-1):
    for index3 in range(index2 + 1, dem):
        if lst[index2][0] == lst[index3][0] and int(lst[index2][1]) == int(lst[index3][1]):
            if int(lst[index2][2]) < int(lst[index3][2]):
                lst_tg = lst[index2]
                lst[index2] = lst[index3]
                lst[index3] = lst_tg
print(lst)
