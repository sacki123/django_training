from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader
from .models import question, choice

# Create your views here.
def index(request):
    return HttpResponse("Hello Word")
def ham(request):
    return HttpResponse("<h1>Khó VL</h1><p> Cố thôi chứ biết làm sao</p>")
def detail(request, question_id):
    return HttpResponse("Question text la: %s" % question_id)
def index1(request):
    latest_question_list = question.objects.order_by('-time_pub')[:5]
    template = loader.get_template('polls/index.html')
    context = {
        'latest_question_list': latest_question_list,
    }
    return HttpResponse(template.render(context, request))
def index2(request):
    latest_question_list = question.objects.order_by('-pub_date')[:5]
    output =join([q.question_text for q in latest_question_list])
    return HttpResponse(output)