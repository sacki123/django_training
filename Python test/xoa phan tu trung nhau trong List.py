lst = ['a', 45, 'a', 45, 16, 'a', 84]
s = []
for index in range(len(lst) - 1, -1, -1):
    if lst[index] in s:
        del lst[index]
    else:
        s.append(lst[index])
print(lst) 
