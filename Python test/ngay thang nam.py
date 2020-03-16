import datetime
input_year=input("Hãy nhập vào số năm bạn muốn: ")
my_year1=datetime.date(int(input_year),1,8)
my_year2=datetime.date(int(input_year),1,9)
my_year3=datetime.date(int(input_year),1,10)
my_year4=datetime.date(int(input_year),1,11)
my_year5=datetime.date(int(input_year),1,12)
my_year6=datetime.date(int(input_year),1,13)
my_year7=datetime.date(int(input_year),1,14)
if my_year1.weekday()==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year1)
if int(my_year2.weekday())==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year2)
if my_year3.weekday()==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year3)    
if my_year4.weekday()==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year4)   
if my_year5.weekday()==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year5)
if my_year6.weekday()==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year6)   
if my_year7.weekday()==0:
    print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_year7)  

