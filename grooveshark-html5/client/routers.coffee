class @SearchRouter extends Backbone.Router
  routers:
    'search/songs':  'searchSongs'
    'search/albums': 'searchAlbums'

  searchSongs: (query) ->
    searchView = new SearchView collection: new Songs
    searchView.render()

  searchAlbums: (query) ->
    searchView = new SearchView collection: new Albums
    searchView.render()