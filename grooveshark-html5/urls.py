from django.conf.urls.defaults import patterns, include, url

urlpatterns = patterns('',
    url(r'^session_grabber/', include('session_grabber.urls')),
)
