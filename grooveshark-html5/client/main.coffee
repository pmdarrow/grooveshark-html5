$ ->
  class GroovesharkAPI

    settings =
      endpoint: "https://html5.grooveshark.com/more.php"
      referrer: "http://html5.grooveshark.com/"
      revToken: "boomGoesTheDolphin"
      sessionGrabber: "http://localhost:8000/get_session_id/"

    requestParams =
      client: "mobileshark"
      clientRevision: "20120112"
      privacy: 0
      country:
        "ID": 1
        "CC1": 0
        "CC2": 0
        "CC3": 0
        "CC4": 0
        "IPR": 1

    constructor: ->
      @uuid = uuid.v4()

    getSessionId: (callback) ->
      $.get(settings.sessionGrabber, callback)

    getCommunicationToken: ->
      @getSessionId((data) -> alert(data))

  api = new GroovesharkAPI()
  api.getCommunicationToken()