
howaboutApp.controller 'MainController', [
  '$scope'
  '$route'
  '$http'
  'Track'
  'RecommendedTrack'
  'PlayInfoSharedService'
  'PlaylistSharedService'
  ($scope, $route, $http, Track, RecommendedTrack, playInfoSharedService, playlistSharedService) ->

    $scope.tracks = []
    $scope.playlist = playlistSharedService.playlist
    $scope.tabScrollTopMap = {}

    $scope.getPlaylistIndex = ->
      playlistSharedService.playingIndex


    # adjust scrollTop whenever click a tab based on relatedTarget and target tabs.
    $('#fixed-tabs a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
      $scope.tabScrollTopMap[e.relatedTarget.hash] = $(document).scrollTop()
    $('#fixed-tabs a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
      $scope.tabScrollTopMap[e.target.hash] = 0  if not $scope.tabScrollTopMap[e.target.hash]?
      $(document).scrollTop $scope.tabScrollTopMap[e.target.hash]


    $scope.$on 'onBroadcastPlayInfo', ->
      lyricsHtml = playInfoSharedService.lyrics?.replace /\n/g, '<br />'

      track = playInfoSharedService.track
      $('#lyrics-track').text "#{track.trackTitle} - #{track.artistName}"
      $scope.tabScrollTopMap['#lyrics-tab'] = 0
      $(document).scrollTop 0  if $('#lyrics-tab').hasClass 'active'

      if lyricsHtml?
        $('#lyrics').html lyricsHtml
      else
        $('#lyrics').text '이 곡은 가사가 없습니다.'


    $scope.onPlayerLoaded = ->


    addPosterImageUrl = (track) ->
      if track.bugsAlbumId?
        posterImageUrl = "http://image.bugsm.co.kr/album/images/224/#{parseInt track.bugsAlbumId / 100}/#{track.bugsAlbumId}.jpg"
      else
        posterImageUrl = ''

      track.posterImageUrl = posterImageUrl
      track


    loadMoreRandomTracks = ->
      tracks = Track.listRandom ->
        for track, index in tracks
          do (track) ->
            $scope.tracks.push addPosterImageUrl track
        $scope.isTrackLoading = false

    loadMoreRandomTracks()


    $scope.onClickTrack = (track) ->
      $scope.track = track
      $scope.isTrackLoading = true
      $(document).scrollTop 0
      $scope.tracks = []

      tracks = RecommendedTrack.list
        trackId: "#{track.trackTitle}:#{track.artistName}"
      ,
        ->
          newTracks = []
          for track, index in tracks
            do (track) ->
              newTracks.push addPosterImageUrl track

          $scope.tracks = newTracks
          $scope.isTrackLoading = false


    $scope.onClickListen = (track) ->
      playlistSharedService.addNext track
      playlistSharedService.playNext()

    $scope.onClickAddNext = (track) ->
      playlistSharedService.addNext track

    $scope.onClickAddLast = (track) ->
      playlistSharedService.addLast track

    
    saveDialog = $('#saveDialog')
    saveDialog.change (e) ->
      saveFilePath = $(this).val()
      playInfoSharedService.downloadTrack $scope.savingTrack, saveFilePath


    $scope.onClickDownload = (track) ->
      $scope.savingTrack = track
      
      saveDialog.val null
      saveDialog.trigger 'click'


    $scope.onSubmitSearch = (searchString) ->
      if not searchString? or searchString.length < 2
        $('#modalBodyMessage').text '검색어가 너무 짧습니다.'
        $('#alertDialog').modal 'show'
        return

      $('#fixed-tabs a:first').tab 'show'

      $scope.track =
        isSearch: true
        searchString: searchString
      $scope.isTrackLoading = true
      $(document).scrollTop 0
      
      $scope.tracks = []

      tracks = Track.search
        q: searchString
      ,
        ->
          newTracks = []
          for track, index in tracks
            do (track) ->
              newTracks.push addPosterImageUrl track

          $scope.tracks = newTracks
          $scope.isTrackLoading = false
          $scope.searchString = ''


    $scope.onClickPlayIndex = (index) ->
      playlistSharedService.playIndex index

    $scope.onClickDeleteIndex = (index) ->
      playlistSharedService.deleteIndex index

    $scope.onClickSearchByTrack = (track) ->
      $('#fixed-tabs a:first').tab 'show'
      if track isnt $scope.track
        $scope.onClickTrack track

]
