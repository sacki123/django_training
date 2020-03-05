# a="abcABCCD"
# index = len(a)
# for index in range(index - 1, -1, -1):
#     print("Index: %d - character:  %s" % (index,a[index]))
lst_B = list()
lst_A = ["A", "B", "C"]
lst_F = ["c", "d", "a"]
lst_C = ["A", "B", "C",['a','b','c'], 1, 2, 3.1]
# print(lst_C)
# for index, value in enumerate(lst_A):
#     print("Index: %d - Value:  %s" % (index, value))
for data in lst_C:
    if isinstance(data, list): 
	    for x in data:
		    print(x)
lst_D = lst_A + lst_C
lst_D[3] = "E"
lst_D[1:4] = ["X", "Y"]
#print(lst_D)
lst_E = list(zip(lst_A, lst_F))
print(lst_E)
print(list(zip(*lst_E)))
