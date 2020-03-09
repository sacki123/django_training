import os
import json
import random
import jaconv
from datetime import datetime
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
            temp = create_birth_day()
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
            temp = jaconv.z2h(create_zipcode(to_length - from_length), digit=True, ascii=True)  
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
    return ad

def create_zipcode(value):
    zc = fake.zipcode()
    zc = zc[0:value]
    return zc

def create_birth_day():
    date = fake.date_of_birth(tzinfo=None, minimum_age=20, maximum_age=95)
    if date >= datetime(1926,12,26) and date < datetime(1989,1,8):
        gengo = "3"
        year = str(date.year - 1926 + 1)
        if date.month < 10:
            month = "0" + str(date.month)
        else:
            month = str(date.month)
        if date.day < 10:
            day = "0" + str(date.day)
        else:
            day = str(date.day)
    elif date >= datetime(1989,1,8) and date < datetime(2019,5,1):
        gengo = "4"
        year = str(date.year - 1989 + 1)
        if date.month < 10:
            month = "0" + str(date.month)
        else:
            month = str(date.month)
        if date.day < 10:
            day = "0" + str(date.day)
        else:
            day = str(date.day)    
    birth_day = gengo + year + month + day    
    return birth_day

def convert_kanji_kata(kanji):
    ka= kakasi()
    ka.setMode('J', 'K')
    conv = ka.getConverter()
    return conv.do(kanji)

# def create_zentaku(_type, from_len, to_length):
