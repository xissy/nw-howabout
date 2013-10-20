
howaboutServices.factory 'PlayInfoSharedService', [
  '$rootScope'
  'PlayInfo'
  ($rootScope, PlayInfo) ->
    sharedService =
      streamUrl: null
      lyrics: null
      track: null

      playTrack: (track) ->
        playInfo = PlayInfo.get
          trackTitle: track.trackTitle
          artistName: track.artistName
        ,
          =>
            @lyrics = playInfo.lyrics
            @track = track

            GS.Grooveshark.getStreamingUrl playInfo.groovesharkSongID, (err, streamUrl) =>
              if err? or not streamUrl?
                # TODO: youtube streaming.
              else
                @streamUrl = streamUrl
                @broadcastPlayInfo()

      broadcastPlayInfo: ->
        $rootScope.$broadcast 'onPlayInfoBroadcast'
      
]
