$ ->
  class GroovesharkApi

    settings =
      token: ''
      secret: 'boomGoesTheDolphin'
      endPoints:
        getSessionId: '/proxy/get_session_id/'
        apiProxy: '/proxy/api/'

    header =
      client: 'mobileshark'
      clientRevision: '20120112'
      privacy: 0
      country:
        'ID': 1
        'CC1': 0
        'CC2': 0
        'CC3': 0
        'CC4': 0
        'IPR': 1
      uuid: ''
      session: ''

    constructor: ->
      header.uuid = uuid.v4().toUpperCase()

    _makeApiRequest: (method, data, success, error) ->
      $.ajax(
        type: 'POST'
        url: settings.endPoints.apiProxy + method + '/'
        data: JSON.stringify(data)
        success: success
        error: error
        dataType: 'json'
        contentType: 'text/plain'
      )

    _getSessionIdHash: (callback) ->
      $.get(settings.endPoints.getSessionId, (response) ->
        header.session = response
        callback(Crypto.MD5(response))
      )

    _getCommunicationToken: (callback) ->
      method = 'getCommunicationToken'
      @_getSessionIdHash((sessionIdHash) =>
        payload =
          header: header
          method: method
          parameters:
            secretKey: sessionIdHash
        @_makeApiRequest(method, payload, (response) ->
          settings.token = response.result
          callback()
        )
      )

    _getRequestToken: (method) ->
      method = 'test'
      # Generate 6 random hex characters
      letters = '0123456789ABCDEF'.split('')
      rand = (letters[Math.round(Math.random() * 15)] for i in [1..6]).join('')
      
      # Create a SHA1 hash of the method, token and secret
      sha = Crypto.SHA1([method, settings.token, settings.secret, rand].join(':'))
      return rand + sha



  api = new GroovesharkApi()
  api._getCommunicationToken(api._getRequestToken)