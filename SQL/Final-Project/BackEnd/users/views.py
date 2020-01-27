from django.shortcuts import render
from django.http import HttpResponse
from django.db import connection, IntegrityError
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
from rest_framework import status


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
        return HttpResponse(e, status=status.HTTP_400_BAD_REQUEST)


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
        return HttpResponse(e, status=status.HTTP_400_BAD_REQUEST)


