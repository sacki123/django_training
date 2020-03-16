lst = [
    {
        'key 01': {'subkey': 1}
    }, 
    {
        'key 02': {'subkey': 10}
    }, 
    {
        'key 03': {'subkey': 5}
    }
]
dic_tg = dict()
for index in range(len(lst)-1):
    for index2 in range(index + 1, len(lst)):
        val = list(lst[index].values())
        val2 = list(lst[index2].values())
        val3 = list(val[0].values())
        val4 = list(val2[0].values())
        if int(val3[0]) < int(val4[0]):
            dic_tg = lst[index]
            lst[index] = lst[index2]
            lst[index2] = dic_tg
print(lst)            

