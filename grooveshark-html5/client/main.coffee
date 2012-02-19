$ ->
  # Create an instance of the Grooveshark API
  api = new GroovesharkApi()

  # Tell Backbone to sync using the Grooveshark API
  Backbone.sync = api.sync

  # Authenticate and make some test requests
  api.authenticate(->
    searchView = new SearchView()
    searchView.render()
  )