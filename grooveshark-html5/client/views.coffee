'''
Represents the main song search
'''
class @SongSearchView extends Backbone.View
  el: $('#search')
  events:
    'keypress #search-input': 'search'

  initialize: (options) ->
    # Re-render the collection when new search results have been fetched.
    @collection.on 'reset', @render, @
    @api = options.api
    @resultClass = SongSearchResult

  render: ->
    # Render search results
    searchResults = @$ '#search-results'
    searchResults.empty()
    @collection.each (model) =>
      result = new @resultClass
        api: @api
        model: model
      searchResults.append result.render().el
    @

  search: (event) ->
    # Execute search when the enter key is pressed
    if event.keyCode is 13
      @collection.fetch
        query: $(event.target).val()


'''
Represents the main album search
'''
class @AlbumSearchView extends SongSearchView

  initialize: (options) ->
    super options
    @resultClass = AlbumSearchResult


'''
Represents an individual song search result
'''
class @SongSearchResult extends Backbone.View
  tagName: 'li'
  className: 'search-result'

  events:
    'click': 'playSong'

  initialize: (options) ->
    @api = options.api

  render: ->
    @$el.text "#{@model.get 'ArtistName'} - #{@model.get 'SongName'}"
    @

  playSong: ->
    @api.getStreamUrl @model.get('SongID'), (url, duration) ->
      window.location.href = url


'''
Represents an individual album search result
'''
class @AlbumSearchResult extends SongSearchResult

  render: ->
    @$el.text "#{@model.get 'ArtistName'} - #{@model.get 'Name'}"
    @