lst = []
d = 5
def thay():
    global d
    lst.append("a")
    print(lst)
    d = 1
    print(d)

thay()
print(lst)
print(d)