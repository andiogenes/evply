from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
	path('save', views.save, name='save'),
	path('load/<str:fileName>', views.load, name='load'),
	path('list', views.list, name='list'),
]