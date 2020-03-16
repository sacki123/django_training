s = "google.com"
s1=[1,5,8,3,5,1,19,34,25,100]
lst = list()
count = 0
for index, cha in enumerate(s):
    if cha not in lst:
        lst.append(cha)
        for index in range(len(s)):
            if cha == s[index]:
                count = count + 1
        print("Số ký tự %s có trong chuỗi là: %d" % (cha, count) )
        count = 0

