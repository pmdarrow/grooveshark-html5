from django.conf.urls.defaults import patterns, include, url

urlpatterns = patterns('',
    url(r'^get_session_id/$', 'session_grabber.views.get_session_id'),
)
