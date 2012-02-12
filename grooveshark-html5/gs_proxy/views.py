from django.http import HttpResponse, HttpResponseBadRequest
from django.utils import simplejson
import requests

BASE_URL = 'html5.grooveshark.com'
API_URL = 'https://%s/more.php' % BASE_URL
SITE_URL = 'http://%s/' % BASE_URL
SESSION_COOKIE = 'PHPSESSID'

def get_session_id(request):
    r = requests.get(SITE_URL)
    return HttpResponse(r.cookies[SESSION_COOKIE])

def api_proxy(request, method):
    if request.method != 'POST':
        return HttpResponseBadRequest()

    data = simplejson.loads(request.raw_post_data)

    headers = {
        'Accept': request.META['HTTP_ACCEPT'],
        'Accept-Encoding': request.META['HTTP_ACCEPT_ENCODING'],
        'Accept-Language': request.META['HTTP_ACCEPT_LANGUAGE'],
        'Accept-Charset': request.META['HTTP_ACCEPT_CHARSET'],
        'User-Agent': request.META['HTTP_USER_AGENT'],
        'Content-Type': request.META['CONTENT_TYPE'],
        'Content-Length': request.META['CONTENT_LENGTH'],
        'Cookie': '%s=%s' % (SESSION_COOKIE, str(data['header']['session'])),
        'Host': BASE_URL,
        'Origin': SITE_URL,
        'Referrer': SITE_URL
    }

    url = '%s?%s' % (API_URL, method)
    r = requests.post(url, data=request.raw_post_data, headers=headers)
    return HttpResponse(r.text)