from django.urls import include, path, re_path
from stocks.urls import urlpatterns as qiitalist_url
from django.contrib import admin

urlpatterns = [
    re_path('^qiita/', include(qiitalist_url)),
    path('admin/', admin.site.urls),
]
