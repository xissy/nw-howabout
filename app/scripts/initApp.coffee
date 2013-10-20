
# app configuration
howaboutApp.config [
  '$routeProvider'
  '$locationProvider'
  ($routeProvider, $locationProvider) ->
    $routeProvider
    .when '/',
      templateUrl: 'views/main.html'
      controller: 'MainController'
    .otherwise
      redirectTo: '/'

]

# boostrapping
angular.bootstrap document, [ 'howaboutApp' ]

# SoundManager
isSoundManagerReady = false

initSoundManager = ->
  soundManager.setup
    preferFlash: false
    onready: ->
      isSoundManagerReady = true
    ontimeout: ->
      alert 'Failed to initialize SoundManager.'

initSoundManager()
