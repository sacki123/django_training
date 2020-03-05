a="abcABCCD"
index = len(a)
for index in range(index - 1, -1, -1):
    print("Index: %d - character:  %s" % (index,a[index]))
b ="A" + a[0]
print(b)
a=a.lower()
print(a)