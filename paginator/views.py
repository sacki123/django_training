from django.shortcuts import render
from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from .models import Customer
# Create your views here.
def listing(request):
    customer_list = Customer.objects.all()
    n = 'name'
    for record in customer_list:
        t = record.__dict__.get(n)
    paginator = Paginator(customer_list,5)
    page_number = request.GET.get('page')
    try:
        customers = paginator.page(page_number)
    except PageNotAnInteger:
        customers = paginator.page(1)
    except EmptyPage:
        customers = paginator.page(paginator.num_pages)
    return render(request,'paginator/list.html',{'customers':customers})        