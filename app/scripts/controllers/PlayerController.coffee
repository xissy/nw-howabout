
howaboutApp.controller 'PlayerController', [
  '$scope'
  '$route'
  '$http'
  'PlayInfoSharedService'
  'PlaylistSharedService'
  ($scope, $route, $http, playInfoSharedService, playlistSharedService) ->

    $scope.$on 'onBroadcastPlayInfo', ->
      musicPlayer.url = playInfoSharedService.streamUrl
      musicPlayer.play()


    $scope.$on 'onBroadcastStartLoadingSong', ->
      musicPlayer.pause()
      showLoading()


    showPlayButton = ->
      $('#playButtonIcon').removeClass('icon-stop icon-pause icon-spinner icon-spin').addClass('icon-play')
      $('#player-progress').removeClass('active')

    showPauseButton = ->
      $('#playButtonIcon').removeClass('icon-stop icon-play icon-spinner icon-spin').addClass('icon-pause')
      $('#player-progress').addClass('active')

    showStopButton = ->
      $('#playButtonIcon').removeClass('icon-play icon-pause icon-spinner icon-spin').addClass('icon-stop')
      $('#player-progress').addClass('active')

    showLoading = ->
      $('#playButtonIcon').removeClass('icon-play icon-pause icon-stop').addClass('icon-spinner icon-spin')
      $('#player-progress').removeClass('active')


    musicPlayer = soundManager.createSound
      id: 'musicPlayer'
      volumn: 100
      autoPlay: false
      loops: 1
      onload: ->
        setPlayButtonIcon getPlayState()
      onplay: ->
        setPlayButtonIcon getPlayState()
      onpause: ->
        setPlayButtonIcon getPlayState()
      onresume: ->
        setPlayButtonIcon getPlayState()
      onstop: ->
        setPlayButtonIcon getPlayState()
      onfinish: ->
        setPlayButtonIcon getPlayState()
        $scope.$apply ->
          $scope.durationTimeString = '0:00'
          $scope.positionTimeString = '0:00'
        playlistSharedService.playNext()
      whileloading: ->
        null
      whileplaying: ->
        duration = musicPlayer.duration
        durationSecs = duration / 1000
        durationSec = parseInt durationSecs % 60
        durationSec = "0#{durationSec}"  if durationSec < 10

        position = musicPlayer.position
        positionSecs = position / 1000
        positionSec = parseInt positionSecs % 60
        positionSec = "0#{positionSec}"  if positionSec < 10

        progressPercent = parseInt positionSecs * 100 / durationSecs

        $scope.$apply ->
          $scope.durationTimeString = "#{parseInt durationSecs / 60}:#{durationSec}"
          $scope.positionTimeString = "#{parseInt positionSecs / 60}:#{positionSec}"
          $scope.progressPercentStyle =
            width: "#{progressPercent}%"


    getPlayState = ->
      if musicPlayer.playState is 0
        return 'stopped'
      
      if musicPlayer.paused
        return 'paused'

      return 'playing'

    setPlayButtonIcon = (playState) ->
      switch playState
        when 'playing'
          showPauseButton()
        when 'paused'
          showPlayButton()
        when 'stopped'
          showPlayButton()
        

    $scope.onClickPlay = ->
      switch getPlayState()
        when 'playing'
          musicPlayer.pause()
        when 'paused'
          musicPlayer.play()
        else
          playlistSharedService.playNext()

    $scope.onClickPrev = ->
      playlistSharedService.playPrev()

    $scope.onClickNext = ->
      playlistSharedService.playNext()

]
