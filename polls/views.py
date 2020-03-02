from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse, Http404, HttpResponseRedirect
from django.template import loader
from django.urls import reverse
from django.views import generic
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
    try:
        latest_question_list = question.objects.order_by('-time_pub')[:5]
        output =",".join([q.question_text for q in latest_question_list])
    except question.DoesNotExist:
        raise Http404("Đã xảy ra lỗi")   
    return HttpResponse(output)

def index3(request, question_id):
    try:
        latest_question_list = question.objects.get(pk=question_id)
        output = {
            latest_question_list: latest_question_list
        }
    except question.DoesNotExist:
        raise Http404("Đã xảy ra lỗi nghiêm trọng")   
    return render(request,"polls/index1.html",output)

def vote(request, question_id):
    question1 = get_object_or_404(question, pk=question_id)
    try:
        selected_choice = question1.choice_set.get(pk=request.POST['choice'])
    except (KeyError, choice.DoesNotExist):
        return render(request, 'polls/detail.html', {
            'question': question1,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.vote += 1
        selected_choice.save()
    return HttpResponseRedirect(reverse('polls:results', args=(question1.id,)))
    # return render(request,"polls/results.html",{'question':question1})
def results(request, question_id):
    question1 = get_object_or_404(question, pk=question_id) 
    return render(request, 'polls/results.html', {'question': question1})
class Viewdetail(generic.DetailView):
    model = question
    template_name = "polls/detail.html"
class Viewresult(generic.DetailView):
    model = question
    template_name = "polls/results.html"
class Viewlist(generic.ListView):
    model = question
    template_name = "polls/index.html"
    context_object_name = "latest_question_list"
    def get_queryset(self):
        return question.objects.all()

