import os
import pickle
import sys
file1 = open("1","wb")
# print(os.path.dirname(__file__))
# os.path.join(os.path.dirname, './File')
path = os.path.join(os.path.dirname(__file__), './a/File Sample.txt')
print(path)
fileopen = open(path,"r+")
print(fileopen)
for index in fileopen:    
    print(index)
string = fileopen.readlines()
print(len(string))
position = fileopen.tell()
print(position)
fileopen.seek(10)
position = fileopen.tell()
print(position)
class t():
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def getname(self):
        return self.name
    def getage(self):
        return self.age
# t1 = t("Hoàng",32)
# print(t1.getname())
# print(t1.getage())
# pickle.dump(t1, file1) 
# file1.close() 
# file1 = open("1","wb+") 
# s1 = pickle.load(file1)    
# file1.close() 
# print(s1.getname())
# fileopen.close()
# position = fileopen.tell()
# print(position)
# fileopen.seek(0,0)
# string1 = fileopen.read()
# print(string1)
# fileopen.seek(0,0)
# string2 = fileopen.read(11)
# print(string2)
# position = fileopen.tell()
# print(position)
# os.mkdir("Mới")
# os.rmdir("Mới")
# os.getcwd()
# os.chdir("/Mới/newdir")
# os.rename("Test.txt","File Sample.txt")