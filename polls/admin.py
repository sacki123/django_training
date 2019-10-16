from django.contrib import admin

# Register your models here.
from .models import question, choice, Blog, Author, Entry
admin.site.register(question)
admin.site.register(choice)
admin.site.register(Blog)
admin.site.register(Author)
admin.site.register(Entry)