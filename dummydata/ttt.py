import json
import os
import sys
import glob
import traceback
from collections import OrderedDict
from logging import getLogger

import logic

JS = "柔整"
SK = "鍼灸"
DS = os.path.sep
log = getLogger(__name__)    
if __name__ == "__main__":
    path_input = os.path.join(os.path.dirname(__file__), "INPUT")
    path_output = os.path.join(os.path.dirname(__file__), "OUTPUT")
    path_tcd = os.path.join(os.path.dirname(__file__), 'TCD')
    path_js = os.path.join(path_input, JS)
    path_sk = os.path.join(path_input, SK)
    file_js = os.listdir(path_js)
    file_sk = os.listdir(path_sk)
    dummy_data = []
    with open(os.path.join(path_tcd, JS + DS + 'config.json'), encoding='utf-8') as f:
        JS_config = json.load(f)
    with open(os.path.join(path_tcd, SK + DS + 'config.json'), encoding='utf-8') as f:   
        SK_config = json.load(f)
    if len(file_js) > 0:
        for index in file_js:
            with open(os.path.join(path_js, index), encoding="shift-jis") as f:
                for line_ in f:
                    line = logic.create_data(line_, JS_config)
                    dummy_data.append(line)
            logic.create_file(os.path.join(path_output, JS), dummy_data, index)       

