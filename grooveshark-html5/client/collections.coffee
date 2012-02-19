@Songs = class Songs extends Backbone.Collection
  method: 'getResultsFromSearch'
  type: 'Songs'

  fetch: (options) ->
    # Shove query & search type into 'parameters' object
    if options?.query
      options.parameters =
        query: options.query
        type: @type
      delete options.query
    super(options)

  parse: (response) ->
    response.result.result


@Albums = class Albums extends Songs
  type: 'Albums'