import json
import os
import sys
import glob
import traceback
from logging import getLogger

path_input = os.path.join(os.path.dirname(__file__), "json.json")
with open(path_input, encoding="utf-8") as f:
    p = json.load(f)
    print(p)
# JS = "柔整"
# SK = "鍼灸"
# log = getLogger(__name__)    
# if __name__ == "__main__":
#     path_input = os.path.join(os.path.dirname(__file__), "INPUT")
#     path_output = os.path.join(os.path.dirname(__file__), "OUTPUT")
#     path_js = os.path.join(path_input, JS)
#     path_sk = os.path.join(path_input, SK)
#     file_js = os.listdir(path_js)
#     file_sk = os.listdir(path_sk)
#     if len(file_js) > 0:
#         for index in file_js:
#             with open(os.path.join(path_js, index), encoding="shift-jis") as f:
#                 for i in f:
#                     print(i)
                    

