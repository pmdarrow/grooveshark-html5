@SearchView = class SearchView extends Backbone.View
  el: $('#search')
  template: _.template($('#search-template').html())

  render: ->
    @$el.html(@template())
    @testQuery()

  testQuery: ->
    songs = new Songs()
    songs.fetch(
      query: 'Gotye'
      success: =>
        searchResults = new SearchResultsView(
          el: $('#search-results')
          collection: songs
        )
        searchResults.render()
    )


class SearchResultsView extends Backbone.View

  render: ->
    @collection.each((model) =>
      result = new SongSearchResult(model: model)
      @$el.append(result.render().el)
    )
    return @


class SongSearchResult extends Backbone.View
  tagName: 'li'
  className: 'search-result'

  render: ->
    @$el.text(@model.get('SongName'))
    return @


class AlbumSearchResult extends SongSearchResult

  render: ->
    @$el.text(@model.get('Name'))
    return @