class @SearchRouter extends Backbone.Router
  routes:
    '': 'searchSongs'
    'search/songs':  'searchSongs'
    'search/albums': 'searchAlbums'

  searchSongs: () ->
    @searchView?.undelegateEvents()
    @searchView = new SongSearchView collection: new Songs
    @searchView.render()

  searchAlbums: () ->
    @searchView?.undelegateEvents()
    @searchView = new AlbumSearchView collection: new Albums
    @searchView.render()