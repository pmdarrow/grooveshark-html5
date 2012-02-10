from django.http import HttpResponse
import requests

GROOVESHARK_URL = "http://html5.grooveshark.com/"
COOKIE_KEY = "PHPSESSID"

def get_session_id(request):
    r = requests.get(GROOVESHARK_URL)
    return HttpResponse(r.cookies[COOKIE_KEY])