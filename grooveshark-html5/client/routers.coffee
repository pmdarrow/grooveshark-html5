class @SearchRouter extends Backbone.Router
  routes:
    '': 'searchSongs'
    'search/songs':  'searchSongs'
    'search/albums': 'searchAlbums'

  initialize: (options) ->
    @api = options.api

  searchSongs: () ->
    @searchView?.undelegateEvents()
    @searchView = new SongSearchView
      api: @api
      collection: new Songs
    @searchView.render()

  searchAlbums: () ->
    @searchView?.undelegateEvents()
    @searchView = new AlbumSearchView
      api: @api
      collection: new Albums
    @searchView.render()