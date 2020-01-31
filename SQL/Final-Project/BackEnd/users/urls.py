from django.urls import path
from . import views

urlpatterns = [
    path('insert/', views.add_user, name='add_user'),
    path('delete/', views.delete_user, name='add_user'),
    path('update/', views.update_user, name='add_user'),
    path('address/insert/', views.add_address, name='add_address'),
    path('report/<str:personal_id>', views.get_report, name='get_report'),
    path('query', views.exc_query, name='exc_query'),
    path('restore/<str:table_name>', views.restore, name='restore')
]
