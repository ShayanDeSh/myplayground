from django.http import HttpResponse, JsonResponse
from django.db import connection, IntegrityError, DataError, transaction
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from rest_framework import status
from rest_framework.utils import json


@require_http_methods(["POST"])
@csrf_exempt
def add_user(request):
    try:
        parsed_body = json.loads(request.body)
        personal_id = parsed_body.get('personal_id')
        first_name = parsed_body.get('first_name')
        last_name = parsed_body.get('last_name')
        phone_number = parsed_body.get('phone_number')
        age = parsed_body.get('age')
        with connection.cursor() as cursor:
            cursor.execute("INSERT INTO customers values (%s, %s, %s, %s, %s)",
                           [personal_id, first_name, last_name, phone_number, age])
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        print(e)
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(["POST"])
@csrf_exempt
def add_address(request):
    try:
        parsed_body = json.loads(request.body)
        landline = parsed_body.get('landline')
        address_name = parsed_body.get('address_name')
        address = parsed_body.get('address')
        personal_id = parsed_body.get('personal_id')
        with connection.cursor() as cursor:
            cursor.execute(
                "INSERT INTO address (landline, address_name, address, personal_id) values (%s, %s, %s, %s)",
                [landline, address_name, address, personal_id])
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)
    except DataError as e:
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(['DELETE'])
@csrf_exempt
def delete_user(request):
    try:
        print(request.body)
        personal_id = json.loads(request.body).get('personal_id')
        cursor = connection.cursor()
        cursor.execute(
            "delete from customers where personal_id = %s", [personal_id]
        )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(['PUT'])
@csrf_exempt
def update_user(request):
    try:
        parsed_body = json.loads(request.body)
        first_name = parsed_body.get("first_name")
        last_name = parsed_body.get("last_name")
        phone_number = parsed_body.get("phone_number")
        age = parsed_body.get("age")
        personal_id = parsed_body.get("personal_id")
        with connection.cursor() as cursor:
            cursor.execute(
                "update customers "
                "set first_name = %s, last_name = %s, phone_number = %s, age = %s "
                "where personal_id = %s",
                [first_name, last_name, phone_number, age, personal_id]
            )
        return HttpResponse(status.HTTP_202_ACCEPTED)
    except IntegrityError as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)


def get_report(request, personal_id):
    with connection.cursor() as cursor:
        cursor.execute(
            "select * from sale_factor natural join requested_items where personal_id = %s order by factor_id",
            [personal_id]
        )
        columns = [col[0] for col in cursor.description]
        factors = [
            dict(zip(columns, row))
            for row in cursor.fetchall()
        ]

        cursor.execute(
            "select sum(price) as t_price from sale_factor natural join requested_items where personal_id = %s ",
            [personal_id]
        )

        total_price = cursor.fetchone()[0]

        cursor.execute(
            "WITH count_it as "
            "(select item_name, count(*) as num "
            "from sale_factor natural join requested_items where personal_id = %s"
            " group by item_name) "
            "select  num, item_name from count_it where num = (select max(num) from count_it)",
            [personal_id]
        )
        fav = cursor.fetchone()
        favorite = {
            "item_name": fav[1],
            "repetition": fav[0]
        }
        report = {
            "factors": factors,
            "favorite": favorite,
            "total_price": total_price
        }
    return JsonResponse(report)


@require_http_methods(['POST'])
@csrf_exempt
@transaction.atomic
def exc_query(request):
    try:
        query = json.loads(request.body).get('query')
        splited_query = query.split()
        table_name = splited_query[2]
        print(splited_query[0])
        if splited_query[0].lower() == 'create' or splited_query[0].lower() == 'drop':
            with connection.cursor() as cursor:
                if splited_query[0].lower() != 'drop':
                    cursor.execute(
                        'insert into restore values (%s, %s)', [table_name, query]
                    )
                cursor.execute(
                    query
                )
        return HttpResponse(status.HTTP_201_CREATED)
    except Exception as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)


@require_http_methods(['GET'])
@csrf_exempt
def restore(request, table_name):
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                'select query from restore where table_name = %s', [table_name]
            )
            query = cursor.fetchone()[0]
            cursor.execute(
                query
            )
    except Exception as e:
        return HttpResponse(e, status.HTTP_406_NOT_ACCEPTABLE)
