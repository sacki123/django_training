import json
import os
import traceback
from logging import getLogger

import logic

JS = "柔整"
SK = "鍼灸"
DS = os.path.sep
log = getLogger(__name__)    
if __name__ == "__main__":
    try:
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
            for js_index in file_js:
                dummy_data.clear()
                with open(os.path.join(path_js, js_index), encoding="cp932") as js_file:
                    for js_line in js_file:
                        line = logic.create_data(js_line, "JS", JS_config)
                        dummy_data.append(line)
                logic.create_file(os.path.join(path_output, JS), dummy_data, js_index, JS)  
        if len(file_sk) > 0:
            for sk_index in file_sk:
                dummy_data.clear()
                with open(os.path.join(path_sk, sk_index), encoding="cp932") as sk_file:
                    for sk_line in sk_file:
                        line = logic.create_data(sk_line, "SK", SK_config)
                        dummy_data.append(line)
                logic.create_file(os.path.join(path_output, SK), dummy_data, sk_index, SK)              
    except:    
        log.error(traceback.format_exc())