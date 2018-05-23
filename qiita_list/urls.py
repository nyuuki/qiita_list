from django.conf.urls import include, url
from stocks.urls import urlpatterns as qiitalist_url

urlpatterns = [
    url(r'^qiita/', include(qiitalist_url)),
]
