from django.urls import path
from . import views

urlpatterns = [
    path('menu/insert', views.add_item_to_menu, name='add_item_to_menu')
]
