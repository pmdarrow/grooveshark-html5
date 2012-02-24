$ ->
  # Create an instance of the Grooveshark API
  api = new GroovesharkApi

  # Tell Backbone to sync using the Grooveshark API
  Backbone.sync = api.sync

  # Authenticate and render some views
  api.authenticate(->
    searchRouter = new SearchRouter
    Backbone.history.start()
    searchRouter.navigate 'search/songs', trigger: true
  )