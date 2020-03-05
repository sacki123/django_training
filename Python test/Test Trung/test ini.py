import configparser
import os
import sys
config = configparser.ConfigParser()
DIR_NAME = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'default.ini')
print(DIR_NAME)
config.read(DIR_NAME)
for value in config:
    print(value)
