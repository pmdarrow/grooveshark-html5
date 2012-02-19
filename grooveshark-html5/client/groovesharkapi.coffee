class @GroovesharkApi
  settings:
    token: ''
    secret: 'boomGoesTheDolphin'
    endPoints:
      getSessionId: '/proxy/get_session_id/'
      apiProxy: '/proxy/api/'

  header:
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
    @header.uuid = uuid.v4().toUpperCase()

  getRequestToken: (method) ->
    # Generate 6 random hex characters
    letters = '0123456789ABCDEF'.split('')
    rand = (letters[Math.round(Math.random() * 15)] for i in [1..6]).join('')

    # Create a SHA1 hash of the method, token and secret
    sha = Crypto.SHA1 [method, @settings.token, @settings.secret, rand].join(':')
    return rand + sha

  getSessionIdHash: (success, error) ->
    $.ajax
      url: @settings.endPoints.getSessionId,
      success: (response) =>
        @header.session = response
        success Crypto.MD5 response
      error: error

  makeRequest: (method, parameters, success, error, requireToken=true) ->
    if requireToken
      @header.token = @getRequestToken method

    payload =
      header: @header
      method: method
      parameters: parameters

    $.ajax
      type: 'POST'
      url: @settings.endPoints.apiProxy + method + '/'
      data: JSON.stringify payload
      success: success
      error: error
      dataType: 'json'
      contentType: 'text/plain'

  authenticate: (success, error) ->
    @getSessionIdHash((sessionIdHash) =>
      parameters = secretKey: sessionIdHash
      @makeRequest 'getCommunicationToken', parameters, (response) =>
        @settings.token = response.result
        success()
      , error, false
    )

  # Used as a drop-in replacement for Backbone.sync function
  sync: (method, collection, options) =>
    @makeRequest collection.method, options.parameters,
      options.success, options.error