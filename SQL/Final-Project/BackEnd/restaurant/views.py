import datetime

from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection, IntegrityError
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from rest_framework import status
from rest_framework.utils import json


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
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(["POST"])
@csrf_exempt
def add_delivery_man(request):
    try:
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        phone_number = request.POST.get('phone_number')
        delivery_id = request.POST.get('delivery_id')
        with connection.cursor() as cursor:
            cursor.execute(
                "insert into delivery values (%s, %s, %s, %s)",
                [first_name, last_name, phone_number, delivery_id]
            )
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(["POST"])
@csrf_exempt
def add_shopping_store(request):
    try:
        store_name = request.POST.get('store_name')
        with connection.cursor() as cursor:
            cursor.execute(
                "insert into stores (store_name) values (%s)",
                [store_name]
            )
            return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(["POST"])
@csrf_exempt
def add_order(request):
    parsed_body = json.loads(request.body)
    items = parsed_body['items']
    personal_id = parsed_body['personal_id']
    address_id = parsed_body['address_id']
    cursor = connection.cursor()
    cursor.execute(
        "insert into sale_factor (date, personal_id, address_id) values (%s, %s, %s) RETURNING factor_id",
        [datetime.date.today(), personal_id, address_id]
    )
    factor_id = cursor.fetchone()[0]
    for item in items:
        cursor.execute(
            "select current_price from menu where item_name = %s", [item['item_name']]
        )
        price = cursor.fetchone()[0]
        cursor.execute(
            "insert into requested_items values (%s, %s, %s, %s)",
            [factor_id, item['item_name'], item['number'], price]
        )
    return HttpResponse(status=status.HTTP_201_CREATED)
