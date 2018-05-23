import os

from django.conf import settings
from django.http.response import HttpResponse
from rest_framework import viewsets
from stocks.models import Stock
from stocks.serializer import StockSerializer


class StockViewSet(viewsets.ModelViewSet):
    queryset = Stock.objects.all()
    serializer_class = StockSerializer
    print("hioge")
    print("hioge")
    print("hioge")
    print("hioge")
    print("hioge")
    print("hioge")
    print("hioge")
    print("hioge")
    print("hioge")
    filter_fields = ("id", "title", 'stock_count')


def index(_):
    html = open(
            os.path.join(settings.STATICFILES_DIRS[0], "vue_grid.html")).read()
    return HttpResponse(html)
