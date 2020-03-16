s=[1,2,3]
s0=[1,4,3]
s1=[5,11,8]
s3 = list(zip(s,s0,s1))
print(s3)
s3 = list(zip(*s3))
print(s3)
print(s3[0][1])
# print(len(s3))
