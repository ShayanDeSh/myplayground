import datetime
from django.http import HttpResponse
from django.db import connection, IntegrityError, transaction, InternalError
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
                "insert into stores (store_name, active) values (%s, %s)",
                [store_name, True]
            )
            return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(["POST"])
@csrf_exempt
@transaction.atomic
def add_order(request):
    try:
        parsed_body = json.loads(request.body)
        items = parsed_body['items']
        personal_id = parsed_body.get('personal_id')
        address_id = parsed_body.get('address_id')
        delivery_id = parsed_body.get('delivery_id')
        cursor = connection.cursor()
        cursor.execute(
            "insert into sale_factor (date, personal_id, address_id, delivery_id) "
            "values (%s, %s, %s, %s) RETURNING factor_id",
            [datetime.date.today(), personal_id, address_id, delivery_id]
        )
        factor_id = cursor.fetchone()[0]
        for item in items:
            cursor.execute(
                "select current_price from menu where item_name = %s", [item['item_name']]
            )
            price = 0
            row = cursor.fetchone()
            if row !=  None:
                price = row[0]
            cursor.execute(
                "insert into requested_items values (%s, %s, %s, %s)",
                [factor_id, item['item_name'], item['number'], price]
            )
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_406_NOT_ACCEPTABLE)
    except InternalError as e:
        return HttpResponse(e, status=status.HTTP_406_NOT_ACCEPTABLE)
    except Exception as e:
        return HttpResponse(e, status=status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(["POST"])
@csrf_exempt
def add_buy(request):
    try:
        parsed_boyd = json.loads(request.body)
        items = parsed_boyd.get('items')
        store_id = parsed_boyd.get('store_id')
        cursor = connection.cursor()
        cursor.execute(
            "insert into buy_factor (date, store_id)"
            " values (%s, %s) RETURNING buy_factor_id",
            [datetime.date.today(), store_id]
        )
        buy_factor_id = cursor.fetchone()[0]
        for item in items:
            cursor.execute(
                "insert into bought_stuffs values (%s, %s, %s)",
                [buy_factor_id, item['item_name'], item['price']]
            )
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)

@require_http_methods(['PUT'])
@csrf_exempt
def update_delivery_man(request):
    try:
        parsed_body = json.loads(request.body)
        first_name = parsed_body.get("first_name")
        last_name = parsed_body.get("last_name")
        phone_number = parsed_body.get("phone_number")
        delivery_id = parsed_body.get("delivery_id")
        with connection.cursor() as cursor:
            cursor.execute(
                "update delivery set first_name = %s, last_name = %s, phone_number = %s "
                "where delivery_id = %s", [first_name, last_name, phone_number, delivery_id]
            )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(['DELETE'])
@csrf_exempt
def delete_delivery_man(request):
    try:
        delivery_id = json.loads(request.body).get('delivery_id')
        cursor = connection.cursor()
        cursor.execute(
            "delete from delivery where delivery_id = %s", [delivery_id]
        )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(status.HTTP_406_NOT_ACCEPTABLE)

@require_http_methods(['PUT'])
@csrf_exempt
def update_shopping_store(request):
    try:
        parsed_body = json.loads(request.body)
        store_name = parsed_body.get("store_name")
        active = parsed_body.get("active")
        store_id = parsed_body.get("store_id")
        with connection.cursor() as cursor:
            cursor.execute(
                "update stores set store_name = %s, active = %s"
                "where store_id = %s", [store_name, active, store_id]
            )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(['DELETE'])
@csrf_exempt
def delete_shopping_store(request):
    try:
        store_id = json.loads(request.body).get('store_id')
        cursor = connection.cursor()
        cursor.execute(
            "delete from stores where store_id = %s", [store_id]
        )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(['PUT'])
@csrf_exempt
def update_menu_item(request):
    try:
        parsed_body = json.loads(request.body)
        p_item_name = parsed_body.get("p_item_name")
        item_name = parsed_body.get("item_name")
        price = parsed_body.get("price")
        with connection.cursor() as cursor:
            cursor.execute(
                "update menu set item_name = %s, price = %s where item_name = %s", [item_name, price, p_item_name]
            )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(['DELETE'])
@csrf_exempt
def delete_item_from_menu(request):
    item_name = json.loads(request.body).get('item_name')
    print(item_name)
    cursor = connection.cursor()
    cursor.execute(
        "delete from menu where item_name = %s", [item_name]
    )
    return HttpResponse(status.HTTP_202_ACCEPTED)
