from django.urls import path
from django.conf.urls import url
from . import views
urlpatterns = [
    path('hoang/', views.index),
    url(r'3', views.ham),
    url(r'^(?P<question_id>[1-9]+)/detail/$',views.detail),
    url(r'detail/',views.detail),
    url(r'1/',views.index1),
    url(r'2/',views.index1)
]