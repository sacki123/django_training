from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.
from .forms import Loginform
def loginView(request):
    user="Wrong user or pass"
    if request.method == 'POST':
        login_form = Loginform(request.POST)
        if login_form.is_valid():
            if login_form.cleaned_data['user'] == 'admin':
                if login_form.cleaned_data['password'] == '123':
                    user = login_form.cleaned_data['user']
                    request.session['user'] = user
                    request.session.set_expiry(300)
    else:
        login_form = Loginform()
    return render(request,'login/main.html',{'user':user})                    

def formView(request):
    form = Loginform()
    if 'user' in request.session:
        user = request.session['user']
        return render(request,'login/main.html',{'user':user})
    else:
        return render(request,'login/login.html',{'form':form})

def logoutView(request):
    try:
        del request.session['user']
    except:
        pass
    return HttpResponse("BYE BYE")    