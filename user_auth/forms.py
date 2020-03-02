from django import forms

class RegisterForm(forms.Form):
    username = forms.CharField(max_length=100,label='Username')
    password = forms.CharField(widget=forms.PasswordInput)
    email = forms.EmailField(label='Email')