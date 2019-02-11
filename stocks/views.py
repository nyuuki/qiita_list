import os
import json

from django.conf import settings
from django.http.response import HttpResponse
from django.shortcuts import render
from rest_framework import viewsets
import plotly
import plotly.graph_objs as go

from stocks.models import Stock
from stocks.serializer import StockSerializer


class StockViewSet(viewsets.ModelViewSet):
    queryset = Stock.objects.all()
    serializer_class = StockSerializer
    filter_fields = ("id", "title", 'stock_count')


def index(_):
    html = open(
            os.path.join(settings.STATICFILES_DIRS[0], "vue_grid.html")).read()
    return HttpResponse(html)


def plotly_view(request):
    x_list = list()
    y_list = list()
    for stock in Stock.objects.all():
        x_list.append(stock.title)
        y_list.append(stock.stock_count)
    
    figure = go.Figure(
            data=[go.Bar(x=x_list, y=y_list)],
            layout=go.Layout(title='second graph'))
    graph_json = json.dumps(figure, cls=plotly.utils.PlotlyJSONEncoder)
    return render(request, "stocks/plotly.html",
                  {"graph_json":graph_json})
