from django.urls import path, re_path
from django.conf.urls import url
from . import views
app_name = "polls"
urlpatterns = [
    path('hoang/', views.index),
    path(r'3', views.ham),
    re_path(r'^(?P<question_id>[1-9]+)/$',views.vote,name='vote'),
    # re_path(r'^(?P<question_id>[1-9]+)/results/$',views.results,name='results'),
    # url(r'^(?P<question_id>[1-9]+)/detail/$',views.detail,name='detail'),
    re_path(r'^(?P<pk>[1-9]+)/viewresults/$',views.Viewresult.as_view(),name='results'),
    url(r'^(?P<pk>[1-9]+)/viewdetail/$',views.Viewdetail.as_view(),name='detail'),
    re_path(r'^listview/$',views.Viewlist.as_view(),name='index'),
    
]