
howaboutApp.controller 'MainController', [
  '$scope'
  '$route'
  '$http'
  'Track'
  'RecommendedTrack'
  'PlayInfoSharedService'
  ($scope, $route, $http, Track, RecommendedTrack, playInfoSharedService) ->
    console.log $route

    $scope.$on 'onPlayInfoBroadcast', ->
      lyricsHtml = playInfoSharedService.lyrics?.replace /\n/g, '<br />'

      if lyricsHtml?
        track = playInfoSharedService.track
        $scope.tabScrollTopMap['#lyricsTab'] = 0
        $('#lyrics-track').text "#{track.trackTitle} - #{track.artistName}"
        $('#lyrics').html lyricsHtml
      else
        $('#lyrics-track').text ''
        $('#lyrics').text ''


    $scope.onPlayerLoaded = ->


    addPosterImageUrl = (track) ->
      if track.bugsAlbumId?
        posterImageUrl = "http://image.bugsm.co.kr/album/images/224/#{parseInt track.bugsAlbumId / 100}/#{track.bugsAlbumId}.jpg"
      else
        posterImageUrl = ''

      track.posterImageUrl = posterImageUrl
      track


    # adjust scrollTop whenever click a tab based on relatedTarget and target tabs.
    $scope.tabScrollTopMap = {}
    $('#fixed-tabs a[data-toggle="tab"]').on 'show.bs.tab', (e) ->
      $scope.tabScrollTopMap[e.relatedTarget.hash] = $(document).scrollTop()
    $('#fixed-tabs a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
      $scope.tabScrollTopMap[e.target.hash] = 0  if not $scope.tabScrollTopMap[e.target.hash]?
      $(document).scrollTop $scope.tabScrollTopMap[e.target.hash]


    $scope.tracks = []

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
      playInfoSharedService.playTrack track

    $scope.onClickAddNext = (track) ->
      $scope.tracks = []

    $scope.onClickAddLast = (track) ->
      $scope.tracks = []

    
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
        return alert '검색어가 너무 짧습니다.'

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

]
