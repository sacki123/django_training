from django.shortcuts import render
from django.http import HttpResponse
from .forms import file_upload_form 
# Create your views here.
def file_upload_view(request):
    if request.POST == "POST":
        form = file_upload_form(request.POST,request.FILES)
        if form.is_valid():
            upload(request.FILES['file'])
            return HttpResponse("<h1>UPload Thành Công</h1>")
        else:
            return HttpResponse("<h1>UPload Không Thành Công</h1>")
    form = file_upload_form()
    return render(request,'file_upload/file_upload.html',{'form':file_upload_form})  
def upload(f):
    files = open(f.name,'wb+')
    for chunk in f.chunks():
        f.write(chunk)        