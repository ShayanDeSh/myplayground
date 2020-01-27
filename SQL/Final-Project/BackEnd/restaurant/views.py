from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection, IntegrityError
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from rest_framework import status


@require_http_methods(["POST"])
@csrf_exempt
def add_item_to_menu(request):
    try:
        item_name = request.POST.get('item_name')
        current_price = request.POST.get('current_price')
        with connection.cursor() as cursor:
            cursor.execute(
                "INSERT INTO menu values (%s, %s)",
                [current_price, item_name])
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_400_BAD_REQUEST)
