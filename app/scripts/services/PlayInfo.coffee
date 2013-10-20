
howaboutServices.factory 'PlayInfo', [
  '$resource'
  ($resource) ->
    $resource "#{apiHost}/playInfo/:trackTitle/:artistName",
      trackTitle: '@trackTitle'
      artistName: '@artistName'
    ,
      get:
        method: 'GET'
        
]
