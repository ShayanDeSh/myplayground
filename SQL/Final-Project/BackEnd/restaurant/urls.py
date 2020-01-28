from django.urls import path
from . import views

urlpatterns = [
    path('menu/insert', views.add_item_to_menu, name='add_item_to_menu'),
    path('menu/update', views.update_menu_item, name='update_item_to_menu'),
    path('menu/delete', views.delete_item_from_menu, name='delete_item_to_menu'),
    path('delivery/insert', views.add_delivery_man, name='add_delivery_man'),
    path('delivery/update', views.update_delivery_man, name='update_delivery_man'),
    path('delivery/delete', views.delete_delivery_man, name='delete_delivery_man'),
    path('stores/insert', views.add_shopping_store, name='add_shopping_store'),
    path('stores/update', views.update_shopping_store, name='update_shopping_store'),
    path('stores/delete', views.delete_shopping_store, name='delete_shopping_store'),
    path('orders/insert', views.add_order, name='add_order'),
    path('buy/insert', views.add_buy, name='add_buy')
]
