from django.http import HttpResponse
from django.db import connection, IntegrityError
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from rest_framework import status
from rest_framework.utils import json


@require_http_methods(["POST"])
@csrf_exempt
def add_user(request):
    try:
        personal_id = request.POST.get('personal_id')
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        phone_number = request.POST.get('phone_number')
        age = request.POST.get('age')
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
        landline = request.POST.get('landline')
        address_name = request.POST.get('address_name')
        address = request.POST.get('address')
        personal_id = request.POST.get('personal_id')
        with connection.cursor() as cursor:
            cursor.execute(
                "INSERT INTO address (landline, address_name, address, personal_id) values (%s, %s, %s, %s)",
                [landline, address_name, address, personal_id])
        return HttpResponse(status=status.HTTP_201_CREATED)
    except IntegrityError as e:
        return HttpResponse(e, status=status.HTTP_409_CONFLICT)


@require_http_methods(['DELETE'])
@csrf_exempt
def delete_user(request):
    try:
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
