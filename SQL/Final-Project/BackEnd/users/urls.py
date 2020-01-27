from django.urls import path
from . import views

urlpatterns = [
    path('insert/', views.add_user, name='add_user'),
    path('address/insert', views.add_address, name='add_address'),
]
