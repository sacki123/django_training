import logging as lg
import sys
import os
lg.info('Đây là message info')
lg.debug('Đây là message Debug')
lg.warning("Đây là message Warning")
lg.error("Đây là message error")
lg.critical("Đây là message critical")
t = {"a":1,"b":2}
print(t)
print(sys.argv[0])
print(os.path.abspath(__file__))