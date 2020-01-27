from django.urls import path
from . import views

urlpatterns = [
    path('menu/insert', views.add_item_to_menu, name='add_item_to_menu'),
    path('delivery/insert', views.add_delivery_man, name='add_delivery_man'),
    path('stores/insert', views.add_shopping_store, name='add_shopping_store'),
    path('orders/insert', views.add_order, name='add_order'),
]
