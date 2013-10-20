
howaboutServices.factory 'RecommendedTrack', [
  '$resource'
  ($resource) ->
    $resource "#{apiHost}/tracks/recommend/:trackId/track",
      trackId: '@id'
    ,
      list:
        method: 'GET'
        isArray: true
        params:
          limit: '500'
          
]