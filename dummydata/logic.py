import os
import json
import random
import jaconv
import datetime
from collections import OrderedDict
from gimei import Gimei
from pykakasi import kakasi
from faker import Faker, Factory
fake = Faker('ja_JP')
f = Factory.create('ja_JP')
DS = os.path.sep

def create_file(path_output, values, index):
    with open(os.path.join(path_output,'dummy_' + index), 'w', encoding='shift-jis') as f:
        for line in values:
            f.write(line)

def create_data(_line, config):
    index = 2
    str_line = _line[0:2]
    kanji_name, kana_name = create_kanji_kana_name()
    for dict_ in config:
        key = list(dict_.keys())
        value = dict_[key[0]]
        if index == value["from"]:
            temp = dummy_data(_line, value["type"], value['from'], value['to'], value['value'], kanji_name, kana_name)
            str_line += temp
            index = value['to']
        else:
            str_line += _line[index:value['from']]
            temp = dummy_data(_line, value["type"], value['from'], value['to'], value['value'], kanji_name, kana_name)  
            str_line += temp
            index = value['to']
    if index < len(_line):
        str_line += _line[index:len(_line)] 
    return str_line

def dummy_data(_line, _type, from_length, to_length, value, kanji=None, kana=None):
    temp = ""
    if _type == 9:
        if value == 'date':
            date_of_birth = fake.date_of_birth(tzinfo=None, minimum_age=20, maximum_age=95)
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
                    temp += jaconv.z2h(str(random.randint(1,9)), digit=True, ascii=True)
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
    return name_kanji, name_kana

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
        zc = " " * (to_length -from_length)
    else:
        zc = fake.zipcode()
        zc = zc[0:to_length-from_length]
    return zc

def create_birth_day(date):
    birth_day = ""
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

def convert_kanji_kata(kanji):
    ka= kakasi()
    ka.setMode('J', 'K')
    conv = ka.getConverter()
    return conv.do(kanji)

