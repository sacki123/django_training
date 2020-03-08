import os
import json
import random
import jaconv
from pykakasi import kakasi
from faker import Faker, Factory
fake = Faker('ja_JP')
f = Factory.create('ja_JP')
DS = os.path.sep

def create_data(_line, config):
    index = 2
    str_line = _line[0:2]
    kanji_name = fake.name()
    kana_name = jaconv.z2h(convert_kanji_kata(kanji_name), digit=True, ascii=True) 
    for key, value in config.items():
        if index == value["from"]:
            temp = dummy_data(_line, value["type"], value['from'], value['to'], value['value'], kanji_name, kana_name)
            str_line += temp
            index = value['to']
        else:
            str_line += _line[index:value['from']]
            temp = dummy_data(_line, value["type"], value['from'], value['to'], kanji_name, kana_name)  
            str_line += temp
            index = value['to']
    if index < len(_line):
        str_line += _line[index:len(_line)] 
    return
    
def dummy_data(_line, _type, from_length, to_length, value, kanji=None, kana=None):
    temp = ""
    if _type == 9:
        for i in _line[from_length:to_length]:
            if i == " ":
                temp += " "
            else:
                temp += random.randint(1,9)    
    if _type == "X":
        if value == 'num':
            for i in _line[from_length:to_length]:
                if i == "u3000":
                    temp += "u3000"
                else:
                    temp += jaconv.h2z(random.randint(1,9), digit=True, ascii=True)
        if value == 'KANA':
            temp = kana  
    if _type == "N":
        if value == "KANJI":
            temp = kanji
        if value == "address":
            temp = fake.address()        

    return temp

def convert_kanji_kata(kanji):
    ka= kakasi()
    ka.setMode('J', 'K')
    conv = ka.getConverter()
    return conv.do(kanji)

# def create_zentaku(_type, from_len, to_length):
