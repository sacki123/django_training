print("Chào các anh em")
print("Hoàng Pro")
a=101
b=20
c=a//b
print (c)
print (a and b)
d,*e,f=1,2,3,4
print("d=%s" % d)
print("e=%s" % e)
print("f=%s" % f)
if a>8:
    print("Biến a = %d"%a)
if b>10:
    print("Biến b=%d" %b)
   
#gt=input("Nhập vào giới tính: ")
tuoi=input("Nhập vào tuổi: ")
# if str(gt)=="Nam":
#     if int(tuoi) <=20:
#         print("Nam thanh niên")
#     else: 
#         print("Đàn ông trưởng thành")
# elif str(gt)=="Nữ":
#     if int(tuoi) <=20:
#         print("Nữ thanh niên")
#     else: 
#         print("Phụ nữ trưởng thành")  

if int(tuoi)<=18:
    print("Cháu còn bé lắm")
elif int(tuoi)>=19 and int(tuoi)<=25:
    print("Bạn đang còn trẻ")           
elif int(tuoi)>=26 and int(tuoi)<=40:
    print("Chúng tôi sẽ xét bạn kỹ hơn. xin đợi một lát")
    if int(tuoi)>=26 and int(tuoi)<=30:    
        print("Bạn lập gia đình nhanh đi thôi")
    elif int(tuoi)>=31 and int(tuoi)<=40:    
        print("Bạn Ế rồi")
else:
    print("Bạn già rồi")      