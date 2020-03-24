import os
import sys
import json
import urllib
import tempfile
from openpyxl import Workbook
from django.http import HttpResponse
from zm.common.model import getClass
db_name = 'INSURER_TEST'
mimetype = {'excel': 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 
			'json': 'text/plain'}
		
def Export_file_view(request):
	tempdir = tempfile.gettempdir()
	file_id = request.GET.getlist('target')
	json_path = os.path.join(tempdir, file_id[0] + '.json')
	with open (json_path) as f:
		json_file = json.load(f)
	select_col = json_file['select_col']
	rid = json_file['rid']
	file_type = json_file['type']
	try:	
		obj = getClass(db_name)
		fields = obj._meta.fields
		item = obj.objects.values().get(rid = rid)
		response = HttpResponse(content_type = mimetype[file_type] + '; charset=UTF-8-sig')	
		if file_type == 'json':
			data = {}
			json_data = []
			for key in select_col:
				if key == 'choice' or key == 'rid':
					continue
				elif key in item:
					data[key] = str(item.get(key))
			json_data.append(data)	
			file_name = urllib.parse.quote('Insurer_test.json'.encode('UTF-8'))
			response['Content-Disposition'] = "attachment; filename*=UTF-8''"+ file_name
			response.write(json.dumps(data, ensure_ascii=False, indent=2))
		if file_type == 'excel':
			data_header = []
			data_row = []
			for column in select_col:
				if column == 'choice' or column == 'rid':
					continue
				data_row.append(item[column])
			for key in fields:
				if key.verbose_name == 'RID' or key.verbose_name == 'DID':
					continue
				if key.name in select_col:	
					data_header.append(key.verbose_name)
			file_name = urllib.parse.quote('Insurer_test.xlsx'.encode('UTF-8'))
			response['Content-Disposition'] = "attachment; filename*=UTF-8''"+ file_name
			wb = Workbook()
			ws = wb.active
			ws.append(data_header)
			ws.append(data_row)
			wb.save(response)	
	except Exception as e:
		return e
	finally:
		os.remove(json_path)
	return response
