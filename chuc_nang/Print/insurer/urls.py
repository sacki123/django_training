from django.urls import path, re_path
from django.conf.urls import url,include
from django.conf import settings
from zm.page.master.masterview import MasterView
from zm.page.master.masterexport import masterFileExportView
from zm.page.insurer.views import InsurerJsonSearchView

#from zm.page.master.masterfile import master_upload_file_view

urlpatterns = [
    re_path(r'^insurer_search/(?P<uri>.*)', InsurerJsonSearchView.as_view(), name='search')
]