class @App extends Backbone.View

  initialize: (options) ->
    # Create an instance of the Grooveshark API
    @api = new GroovesharkApi

    # Tell Backbone to sync using the Grooveshark API
    Backbone.sync = @api.sync

  run: ->
    # Authenticate and render some views
    @api.authenticate =>
      searchRouter = new SearchRouter api: @api
      Backbone.history.start()

$ ->
  app = new App
  app.run()

