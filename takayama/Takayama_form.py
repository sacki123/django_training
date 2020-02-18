from django import forms

class Takayama_form(forms.Form):

    formID1 = forms.IntegerField(label='保険者番号')
    formID2 = forms.IntegerField(label='保険種別TCD')
    formID3 = forms.IntegerField(label='保険者都道府県番号')
    formID4 = forms.CharField(label='表示名')
    formID5 = forms.CharField(label='メモ')
    formID6 = forms.CharField(label='作成者')
    formID7 = forms.IntegerField(label='削除フラグ')
    formID8 = forms.IntegerField(label='作成日')
