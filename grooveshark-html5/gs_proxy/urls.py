from django.conf.urls.defaults import patterns, include, url

urlpatterns = patterns('gs_proxy.views',
    url(r'^get_session_id/$', 'get_session_id'),
    url(r'^api/(?P<method>[a-zA-Z]+)/$', 'api_proxy')
)
