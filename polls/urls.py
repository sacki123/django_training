from django.urls import path, re_path
from django.conf.urls import url
from . import views
app_name = "polls"
urlpatterns = [
    path('hoang/', views.index),
    path(r'3', views.ham),
    re_path(r'^(?P<question_id>[1-9]+)/$',views.vote,name='vote'),
    re_path(r'^(?P<question_id>[1-9]+)/results/$',views.results,name='results'),
    url(r'^(?P<question_id>[1-9]+)/detail/$',views.detail,name='detail'),
    url(r'detail/',views.detail),
    url(r'1/',views.index1),
    url(r'2/',views.index2)
    
]