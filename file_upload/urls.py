from django.urls import re_path,include
from . import views
urlpatterns = [
    re_path(r'^',views.file_upload_view),
]
