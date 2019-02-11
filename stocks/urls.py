from django.conf.urls import include, url
from rest_framework import routers

from stocks.views import StockViewSet, index, plotly_view

router = routers.DefaultRouter()
router.register(r'stock', StockViewSet)

urlpatterns = [
    url(r'api/', include(router.urls)),
    url(r'plotly_view', plotly_view, name='plotly_view'),
    url(r'', index, name='index'),
]
