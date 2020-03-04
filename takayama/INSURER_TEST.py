import uuid
from django.db import models

class INSURER_TEST(models.Model):
    class Meta:
        app_label = 'zm'
        db_table = 'INSURER_TEST'
        verbose_name = '保険者_test'
        ordering = ['create_date']

    rid = models.UUIDField(verbose_name='RID',name='rid',primary_key=True,default=uuid.uuid4,editable=False,blank=False)
    did = models.UUIDField(verbose_name='DID',name='did', default=uuid.uuid4,editable=False,blank=False)
    revision = models.IntegerField(verbose_name='リビジョン',default=0)
    insurance_category_tcd = models.IntegerField(verbose_name='保険種別TCD', default=0)
    apply_start_date = models.DateField(verbose_name='適用開始年月日',default='1900-01-01')
    apply_end_date = models.DateField(verbose_name='適用終了年月日', default='9999-12-31')
    insurer_number = models.IntegerField(verbose_name='保険者番号',default=0)
    insurer_name = models.TextField(verbose_name='保険者名', max_length=255)
    insurer_name_kana = models.TextField(verbose_name='保険者名カナ',max_length=255)
    insurer_pref_number = models.IntegerField(verbose_name='保険者都道府県番号',default=0)
    phone_number = models.IntegerField(verbose_name='電話番号',default=0)
    zip_code = models.TextField(verbose_name='郵便番号', max_length=10)
    insurer_law_number = models.IntegerField(verbose_name='保険者法別番号',default=0)
    memo = models.TextField(verbose_name='メモ', default='')
    display_name = models.TextField(verbose_name='表示名')
    delete_flag = models.IntegerField(verbose_name='削除フラグ', default=0)
    create_user = models.TextField(verbose_name='作成者', max_length=100)
    create_date = models.DateField(verbose_name='作成日')
    update_user = models.TextField(verbose_name='更新者',max_length=100)
    update_date = models.DateField(verbose_name='更新日')
