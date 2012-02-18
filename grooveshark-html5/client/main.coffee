$ ->
  # Create an instance of the Grooveshark API
  api = new GroovesharkApi()

  # Tell Backbone to sync using the Grooveshark API
  Backbone.sync = api.sync

  # Authenticate and make some test requests
  api.authenticate(->
    songs = new Songs()
    songs.fetch(
      query: 'Gotye'
      success: -> console.log JSON.stringify(songs.pluck 'SongName')
    )

    albums = new Albums()
    albums.fetch(
      query: 'Keane'
      success: -> console.log JSON.stringify(albums.pluck 'Name')
    )
  )