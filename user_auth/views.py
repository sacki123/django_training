from django.shortcuts import render
from django.http import HttpResponse
from .forms import RegisterForm
# Create your views here.
def register(request):
    if request.method == "POST":
        response = HttpResponse()
        response.write("<h1>Thank for registering</h1></br>")
        response.write("Your user: " + request.POST['username'] + "</br>")
        response.write("Your email: " + request.POST['email']+"</br>")
        return response
    registerForm = RegisterForm()
    return render(request,'user_auth/register.html',{'form':registerForm})  