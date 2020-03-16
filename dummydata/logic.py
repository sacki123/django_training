import os
import json
import random
import datetime
import jaconv
from gimei import Gimei
from faker import Faker, Factory
fake = Faker('ja_JP')
f = Factory.create('ja_JP')
DS = os.path.sep

def create_file(path_output, values, index, type_file):
    date_now = datetime.datetime.now().strftime("%y%m%d%H%M%S")
    with open(os.path.join(path_output, date_now + type_file + index), 'w', encoding='cp932') as f:
        for line in values:
            f.write(line)

def create_data(_line, type_file, config_file):
    kanji_name, kana_name = create_kanji_kana_name()
    if type_file == "JS":
        new_line = process_create(_line, config_file, kanji_name, kana_name)
    elif type_file == "SK":
        isha_name = create_kanji_kana_name()[0]    
        new_line = process_create(_line, config_file, kanji_name, kana_name, isha_name)
    return new_line

def process_create(_line, config_file, kanji_name, kana_name, isha_name = None):    
    str_line = ""
    index = 0
    for dict_ in config_file:
        key = list(dict_.keys())
        value = dict_[key[0]]
        if index == value["from"]:
            temp = dummy_data(_line, value["type"], value['from'], value['to'], value['value'], kanji_name, kana_name, isha_name)
            str_line += temp
            index = value['to']
        else:
            str_line += _line[index:value['from']]
            temp = dummy_data(_line, value["type"], value['from'], value['to'], value['value'], kanji_name, kana_name, isha_name)  
            str_line += temp
            index = value['to']
    if index < len(_line):
        str_line += _line[index:len(_line)] 
    return str_line

def dummy_data(_line, _type, from_length, to_length, value, kanji, kana, isha_name=None):
    temp = ""
    if _type == 9:
        if value == 'date':
            date_of_birth = fake.date_of_birth(tzinfo=None, minimum_age=20, maximum_age=90)
            temp = create_birth_day(date_of_birth)
        elif value == 'num':    
            for ch in _line[from_length:to_length]:
                if ch == " ":
                    temp += " "
                else:
                    temp += str(random.randint(1,9))    
    elif _type == "X":
        if value == 'num':
            for ch in _line[from_length:to_length]:
                if ch == " ":
                    temp += " "
                else:
                    temp += jaconv.z2h(str(random.randint(0,9)), digit=True, ascii=True)
        elif value == 'kana':
            temp = kana  
        elif value == 'zipcode':
            temp = create_zipcode(_line, from_length, to_length) 
    elif _type == "N":
        if value == "kanji":
            temp = kanji
        elif value == "address":
            if (_line[from_length:to_length][0] == "\u3000"):
                temp = "\u3000" * (to_length - from_length)
            else:    
                temp = create_address("address", to_length-from_length)  
        elif value == 'num':
            for ch in _line[from_length:to_length]:
                if ch == "\u3000":
                    temp += "\u3000"
                else:
                    temp += jaconv.h2z(str(random.randint(1,9)), digit=True, ascii=True) 
        elif value == 'isha_name':     
            temp = isha_name       
        elif value == 'isha_name_new':
            temp = filter_isha_name(_line, isha_name, from_length, to_length)            
    return temp

def create_kanji_kana_name():
    g = Gimei()
    name = g.name
    name_kanji = name.kanji
    name_kana = jaconv.z2h(name.katakana, digit=True, ascii=True)
    if len(name_kanji) < 10:
        loop = 10 - len(name_kanji)
        name_kanji = name_kanji + (loop * "\u3000")  
    if len(name_kana) < 20:
        loop = 20 - len(name_kana)
        name_kana = name_kana + (loop * " ")
    return jaconv.h2z(name_kanji, digit=True, ascii=True), name_kana

def create_address(address, value ):
    ad = fake.address()
    if len(ad) < value:
        loop = value - len(ad)
        ad = ad + (loop * "\u3000") 
    elif len(ad) > value:
        ad = ad[0:value]        
    return jaconv.h2z(ad, digit=True, ascii=True)

def create_zipcode(_line, from_length, to_length):
    if _line[from_length:to_length].count(" ") > 1:
        zc = " " * (to_length - from_length)
    else:
        zc = fake.zipcode()
        if to_length - from_length == 7:
            zc = zc.replace('-', "")
            zc = zc[0:7]
    return zc

def create_birth_day(date):
    birth_day = ""
    gen = ""
    y = ""
    m = ""
    d = ""
    if date >= datetime.date(1926,12,26) and date < datetime.date(1989,1,8):
        gen = "3"
        y = validate_date(date.year - 1926 + 1)
        m = validate_date(date.month)
        d = validate_date(date.day)
    elif date >= datetime.date(1989,1,8) and date < datetime.date(2019,5,1):
        gen = "4"
        y = validate_date(date.year - 1989 + 1)
        m = validate_date(date.month)
        d = validate_date(date.day) 
    birth_day = birth_day.join([gen,y,m,d])
    return birth_day

def validate_date(value):
    if value < 10:
        value = "0" + str(value)
    else:
        value = str(value)
    return value

def filter_isha_name(line, isha_name, from_length, to_length):
    if line[from_length:to_length][0] == "\u3000":
        name = "\u3000" * (to_length - from_length)
    elif line[from_length:to_length] == line[288:298]:
        name = isha_name
    elif line[from_length:to_length] != line[288:298]:   
        name = create_kanji_kana_name()[0]   
    return jaconv.h2z(name, digit=True, ascii=True)     