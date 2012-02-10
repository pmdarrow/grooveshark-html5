$ ->
  class GroovesharkAPI

    settings =
      endPoint: "https://html5.grooveshark.com/more.php"
      referrer: "http://html5.grooveshark.com/"
      secret: "boomGoesTheDolphin"
      sessionGrabber: "/session_grabber/get_session_id/"

    header =
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
      uuid: ""
      session: ""

    constructor: ->
      header.uuid = uuid.v4().toUpperCase()

    getSessionId: (callback) ->
      $.get(settings.sessionGrabber, (response) ->
        header.session = response
        callback(Crypto.MD5(response))
      )

    getCommunicationToken: ->
      @getSessionId((sessionId) ->
        payload =
          header: header
          method: "getCommunicationToken"
          parameters:
            secretKey: sessionId
        $.post(settings.endPoint, payload, (response) ->
          alert response
        )
      )

  api = new GroovesharkAPI()
  api.getCommunicationToken()