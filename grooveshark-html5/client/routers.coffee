class @SearchRouter extends Backbone.Router
  routes:
    '': 'searchSongs'
    'search/songs':  'searchSongs'
    'search/albums': 'searchAlbums'

  searchSongs: () ->
    searchView = new SongSearchView collection: new Songs
    searchView.render()

  searchAlbums: () ->
    searchView = new AlbumSearchView collection: new Albums
    searchView.render()