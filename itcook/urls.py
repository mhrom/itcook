from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.views.generic import TemplateView
admin.autodiscover()


urlpatterns = patterns('',
    url(r'^$', 'articles.views.home', name='home'),
    url(r'^tools/', 'articles.views.tools', name='tools'),
    url(r'^articles/archive/(?P<year>[\d]+)/(?P<month>[\d]+)/$', 'articles.views.date_archive', name='articles-date-archive'),
    url(r'^articles/archive/(?P<slug>[-\w]+)/$', 'articles.views.category_archive', name='articles-category-archive'),
    url(r'^articles/(?P<slug>[-\w]+)/$', 'articles.views.single', name='articles-single'),
    url(r'^articles/$', 'articles.views.index', name='articles-index'),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^comments/', include('django.contrib.comments.urls')),
    url(r'^ckeditor/', include('ckeditor.urls')),
)
