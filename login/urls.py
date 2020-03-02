from django.urls import re_path
from django.conf.urls import url
from . import views
app_name = 'login'
urlpatterns = [
    url(r'^$',views.loginView,name='login'),
    url(r'logout/',views.logoutView,name='logout'),
    url(r'greeting/',views.formView),
    
]
