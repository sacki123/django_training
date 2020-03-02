from django import forms
class Loginform(forms.Form):
    user = forms.CharField(max_length=50)
    password = forms.CharField(widget=forms.PasswordInput())