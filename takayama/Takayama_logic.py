
#!/usr/bin/python
# -*- coding: utf-8 -*-
'''
全柔協次世代システムプロジェクト

保険者

2019/12/16 a5er2django@ExS 自動作成
'''

__author__   = 'ExS'
__status__   = 'develop'
__version__  = '0.0.0_0'
__date__	 = '2019/12/16'

# ------------------------------------------------------------
## Import Section
# ------------------------------------------------------------
# python
import uuid

# django
from django.db import models
from zm.models import model

# exs_main
from exs_main import mikan_model

#zm
from zm import zm_model


# ------------------------------------------------------------
## Variable Section
# ------------------------------------------------------------
 
# ------------------------------------------------------------
## Function Section
# ------------------------------------------------------------

# ------------------------------------------------------------
## Class Section
# ------------------------------------------------------------
class Takayama_model(models.Model):
	class Meta:
		app_label    = model.APP_LABEL
		db_table     = 'Takayama_model'
		verbose_name = '保険者'
		ordering = ['create_date']

	is_revision = True
	#name_format = '{{insurer_name}} | {{insurer_law_number}} {{insurer_pref_number}} {{insurer_number}}'

	rid = mikan_model.MikanModel.CreateFiled('MikanUUIDField','rid','RID',primary_key=True,default=uuid.uuid4,editable=False,type_name='hidden',required=False)
	did = mikan_model.MikanModel.CreateFiled('MikanUUIDField','did','DID',null=True,type_name='hidden',range=None,required=False)
	revision = mikan_model.MikanModel.CreateFiled('IntegerField','revision','リビジョン',null=True,default=0,type_name='number',range=None,required=False)
	apply_start_date = mikan_model.MikanModel.CreateFiled('DateField','apply_start_date','適用開始年月日',null=True,default='1900-01-01',type_name='date',range=True,required=False)
	apply_end_date = mikan_model.MikanModel.CreateFiled('DateField','apply_end_date','適用終了年月日',null=True,default='9999-12-31',type_name='date',range=True,required=False)
	insurer_number = mikan_model.MikanModel.CreateFiled('TextField','insurer_number','保険者番号',null=True,type_name='text',range=None,required=False)
	insurer_name = mikan_model.MikanModel.CreateFiled('TextField','insurer_name','保険者名',null=True,type_name='text',autokana='insurer_name_kana',range=None,required=False)
	insurer_name_kana = mikan_model.MikanModel.CreateFiled('TextField','insurer_name_kana','保険者名カナ',null=True,type_name='text',range=None,required=False)
	phone_number_1 = mikan_model.MikanModel.CreateFiled('TextField','phone_number_1','電話番号1',null=True,type_name='text',range=None,required=False)
	zip_code = mikan_model.MikanModel.CreateFiled('TextField','zip_code','郵便番号',null=True,type_name='zipcode',range=None,required=False)
	display_name = mikan_model.MikanModel.CreateFiled('TextField','display_name','表示名',null=True,type_name='hidden',range=None,required=False)
	delete_flag = mikan_model.MikanModel.CreateFiled('IntegerField','delete_flag','削除フラグ',null=True,default=0,type_name='checkbox',range=None,required=False)
	create_user = mikan_model.MikanModel.CreateFiled('TextField','create_user','作成者',null=True,type_name='text',range=None,required=False)
	create_date = mikan_model.MikanModel.CreateFiled('DateTimeField','create_date','作成日',null=True,auto_now_add=True,type_name='datetime',range=True,required=False)
	update_user = mikan_model.MikanModel.CreateFiled('TextField','update_user','更新者',null=True,type_name='text',range=None,required=False)
	update_date = mikan_model.MikanModel.CreateFiled('DateTimeField','update_date','更新日',null=True,auto_now=True,type_name='datetime',range=True,required=False)