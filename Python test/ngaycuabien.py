import datetime
input_year=input("Hãy nhập vào số năm bạn muốn kiểm tra: ")
my_year1=datetime.date(int(input_year),9,1)
day_bien=0
index=1
# while index<3:
#     if  my_year1.weekday()==6:
#         day_bien=my_year1.day
#         my_year1=my_year1.replace(day=int(day_bien+1))
#         index = index+1
#     else: 
#            day_bien=my_year1.day
#            my_year1=my_year1.replace(day=int(day_bien+1))
# print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year1)
while index<2:
    if  my_year1.weekday()==6:
        day_bien=my_year1.day
        my_year1=my_year1.replace(day=int(day_bien+8))
        index=index+1
    else:
        day_bien=my_year1.day
        my_year1=my_year1.replace(day=int(day_bien+1))
print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year1)  
print("\a\a\a")        




