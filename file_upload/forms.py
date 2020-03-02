from django import forms
class file_upload_form(forms.Form):
    title = forms.CharField(max_length=100)
    title1 = forms.CharField(max_length=100)
    files = forms.FileField()