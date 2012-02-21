# Represents the main song & album search
class @SearchView extends Backbone.View
  el: $('#search')
  events:
    'keypress #search-input': 'search'

  initialize: ->
    # Re-render the collection when new search results have been fetched.
    @collection.bind 'reset', @render

  render: ->
    # Render search results
    searchResults = @$ '#search-results'
    @collection.each (model) =>
      result = new SongSearchResult model: model
      @$el.append result.render().el

  search: (event) ->
    # Execute search when the enter key is pressed
    if event.keyCode is 13
      collection.fetch
        query: $(event.target).val()


# Represents an individual song search result
class SongSearchResult extends Backbone.View
  tagName: 'li'
  className: 'search-result'

  render: ->
    @$el.text "#{@model.get 'ArtistName'} - #{@model.get 'SongName'}"
    @


# Represents an individual album search result
class AlbumSearchResult extends SongSearchResult

  render: ->
    @$el.text "#{@model.get 'ArtistName'} - #{@model.get 'Name'}"
    @