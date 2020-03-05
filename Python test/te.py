import re
string = """Binni1ng    BBBBBeeeeeeeeBeprogrammers make mistakes writing programs 
because of inexperience in programming in gen-eral or because of
 unfamiliarity with a programming language. Seasoned programmers 
 'make:dsafasfa:fdgd' mistakes due to carelessness or because the proposed Solutionnnnnnnnnnnn
 1213abc@gmail.com 
  1213abc@gmail.com
 "bcdef@hotmail.com.vn"
 edfghsfsaf@outlook.com.net
 serefg@sdsf.de
 hoang@sdtr.com
"""
s = "caabbbabcccsdfeab"
# tg = re.findall(r"[a-z]{1,}",string,) + re.findall(r"[A-Z]{1,}",string,)
# tg = re.findall(r"Be*",string,)
tg = re.findall(r".+",string,)
# tg = re.findall(r'[a-zA-Z0-9]\w{2,}@\w{3,}[\w.]{1,}',string)
print(tg)
# test = re.findall('[a-z]{1,}',string)
# print (test)
# i = 1
# while True:
#     kq = re.findall(r'\w{'+str(i)+'}', string)
#     if len(kq) == 0:
#         break
#     i = i + 1
# i = i - 1
# print(re.findall(r'\w{'+str(i)+'}', string))        



# print(string)
# match = re.match('\W',string)
# if match:
#     print(match.group())
# else:
#     print("Không tìm thấy")    
# regex = r'^[a-zA-Z0-9]*$'
# content = ''
# matchObj = re.search(regex, content)
# print(matchObj.group())