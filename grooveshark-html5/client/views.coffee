# Represents the main song & album search
@SearchView = class SearchView extends Backbone.View
  el: $('#search')
  template: _.template($('#search-template').html())

  events:
    'keypress #search-input': 'search'

  render: ->
    @$el.html(@template())

  search: (event) ->
    # Execute search when the enter key is pressed
    if event.keyCode is 13
      collection = new Songs()
      collection.fetch(
        query: $(event.target).val()
        success: => @displaySearchResults(collection)
      )

  displaySearchResults: (collection) ->
    # TODO: Probably shouldn't be creating a new search results view here every time.
    # Looks like I'm probably not doing things the Backbone way. Should probably
    # just update the collection and the view will update automatically.
    @searchResults = new SearchResultsView(
      el: $('#search-results')
      collection: collection
    )
    @searchResults.render()


# Represents a list of search results returned from the Grooveshark API
class SearchResultsView extends Backbone.View

  render: ->
    @$el.empty()
    @collection.each((model) =>
      result = new SongSearchResult(model: model)
      @$el.append(result.render().el)
    )
    return @


# Represents an individual song search result
class SongSearchResult extends Backbone.View
  tagName: 'li'
  className: 'search-result'

  render: ->
    console.log @model
    @$el.text(@model.get('ArtistName') + ' - ' + @model.get('SongName'))
    return @


# Represents an individual album search result
class AlbumSearchResult extends SongSearchResult

  render: ->
    @$el.text(@model.get('Name'))
    return @