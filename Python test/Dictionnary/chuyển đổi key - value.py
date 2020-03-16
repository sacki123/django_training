m= {'a':1, 'b':2, 'c':3,'d':4}
value = list(m.values())
key = list(m.keys())
print(key)
print(value)
lst = dict(zip(value,key))
print(lst)
new_dic = dict()
for index, value1 in enumerate(value):
    new_dic[value1] = key[index]

# print(list(zip(*lst)))
for key, value in m.items():
    new_dic[value] = key
print(new_dic)
print(len(new_dic))
print(new_dic.items())
# for key, value in m.:
#     print(new_dic[key])