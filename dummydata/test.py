from faker import Faker, Factory
import jaconv
from datetime import datetime, date
from pykakasi import kakasi, wakati
from gimei import Gimei
fake = Faker('ja_JP')

# date = fake.date_between_dates(date_start="1920/1/1", date_end="2019,1,1")

# date = fake.date_of_birth(tzinfo=None, minimum_age=20, maximum_age=95)
# if date >= datetime(1926,12,26) and date <= datetime(1989,1,8):      
#     print("OK")

g = Gimei()
t=g.name
kanji = t.kanji
kana = t.katakana
print(kanji)
print(kana)


# ka = kakasi()
# ka.setMode('J', 'K')
# cov = ka.getConverter()
# k = cov.do(kanji_first)
# k1 = cov.do(kanji_last)
# print(k)
# print(k1)
# print("Chuyen sang hiragana")
# ka.setMode('K', 'H')
# cov = ka.getConverter()
# print(cov.do(k))
# ka.setMode('J', 'H')
# cov = ka.getConverter()
# print(cov.do(kanji))
# # g = Gimei()
# # fake = Faker('ja_JP')
# # f = Factory.create('ja_JP')
# # kanji1 = g.name.first.kanji
# # kanji2 = g.name.last.kanji
# # kana1 = g.name.first.katakana
# # kana2 = g.name.last.katakana
# # t = "abc   d  "
# # F = t[4:9]
# # print(t.count("e"))
# # print("0"*5)

# # for i in t:
# #     print(i)
# # print("Day so%sla" %F)

# # s = "35363229"
# # h = "ａ３５３６３２２９"
# # try:
# #     if isinstance(int(h[1]), int):
# #         print("so")
# #     else:
# #         print('chuoi')    
# # except Exception as e:
# #     print('chuoi')
# #     pass


# s = jaconv.h2z(t, digit=True, ascii=True)
# print(s)

# print(kanji1)
# print(kanji2)
# print(kana1)
# print(kana2)