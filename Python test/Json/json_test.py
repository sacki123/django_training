import json
import os
x = {'name': 'Hoang dai ca', 'age' : 32, 'male' : 'male'}
with open (os.path.dirname(__file__)+"/file_json.json", "w+") as j:
    json.dump(x,j,indent=4)
with open (os.path.dirname(__file__)+"/file_json.json", "a+") as i:
    d = json.load(i.read())
print(d)
