tpl1 = ('a', 'b', 'c', 'd')
tpl2 = ('e',)
tpl3 = tpl1 + tpl2
print(tpl3)
lst = [1,2,3,4]
print(tuple(lst))
print(list(tpl3))
lst2 = ["Google",(10,20), 15, (40, 50, 60), ["a", "và", "e"], (70, 80, 90, 100)]
for index, value in enumerate(lst2):
    if isinstance(value, tuple):
        lst1 = list(lst2[index])
        lst1[-1] = 200
        lst2[index] = tuple(lst1)
print(lst2)

