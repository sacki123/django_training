import datetime
input_year=input("Hãy nhập vào số năm bạn muốn: ")
my_year1=datetime.date(int(input_year),1,1)
my_yearbien=datetime.date(int(input_year),9,1)
my_yearkinhlao=datetime.date(int(input_year),5,1)
my_yearthethao=datetime.date(int(input_year),1,1)
#NGÀY LỄ TRƯỞNG THÀNH
daytruongthanh=0
indextt=1
while indextt<2:
    if  my_year1.weekday()==6:
        daytruongthanh=my_year1.day
        my_year1=my_year1.replace(day=int(daytruongthanh+1))
        indextt = indextt+1
    else: 
           daytruongthanh=my_year1.day
           my_year1=my_year1.replace(day=int(daytruongthanh+1))
print("Ngày lễ trưởng thành của năm %s" %input_year + " là ngày %s" % my_year1)
#NGÀY CỦA BIỂN
daybien=0
indexbien=1
while indexbien<2:
    if  my_yearbien.weekday()==6:
        daybien=my_yearbien.day
        my_yearbien=my_yearbien.replace(day=int(daybien+8))
        indexbien = indexbien+1
    else: 
           daybien=my_yearbien.day
           my_yearbien=my_yearbien.replace(day=int(daybien+1))
print("Ngày của Biển của năm %s" %input_year + " là ngày %s" % my_yearbien)
#NGÀY KÍNH LÃO
#daykinhlao=0
indexkinhlao=1
while indexkinhlao<2:
    if  my_yearkinhlao.weekday()==6:
        daykinhlao=my_yearkinhlao.day
        my_yearkinhlao=my_yearkinhlao.replace(day=int(daykinhlao+9))
        indexkinhlao = indexkinhlao+1
    else: 
           daykinhlao=my_yearkinhlao.day
           my_yearkinhlao=my_yearkinhlao.replace(day=int(daykinhlao+1))
daykinhlao=my_yearkinhlao.day
my_yearkinhlao=my_yearkinhlao.replace(day=int(daykinhlao+1))
print("Ngày kính lão của năm %s" %input_year + " là ngày %s" % my_yearkinhlao)
#NGÀY THỂ DỤC THỂ THAO
daythethao=0
indexthethao=1
while indexthethao<10:
    if  my_yearthethao.weekday()==0:
        print("Ngày thể dục thể thao của năm %s" %input_year + " là ngày %s" % my_yearthethao)
        break
    else: 
        daythethao=my_yearthethao.day
        my_yearthethao=my_yearthethao.replace(day=int(daythethao+1))
        indexthethao = indexthethao+1
       
