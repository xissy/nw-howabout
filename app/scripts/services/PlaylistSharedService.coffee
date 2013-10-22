
howaboutServices.factory 'PlaylistSharedService', [
  '$rootScope'
  'PlayInfoSharedService'
  ($rootScope, playInfoSharedService) ->

    sharedService =
      playlist: []
      playingIndex: -1


      playIndex: (index) ->
        @playingIndex = index
        @play()


      playPrev: ->
        if @playingIndex - 1 >= 0
          @playingIndex--
          @play()


      playNext: ->
        if @playlist.length > @playingIndex + 1
          @playingIndex++
          @play()


      play: ->
        if @playlist.length is 0
          return

        @playingIndex = 0  if @playingIndex is -1

        playInfoSharedService.playTrack @playlist[@playingIndex]

        @broadcastStartLoadingSong()


      addNext: (track) ->
        # insert to playlist array.
        @playlist.splice @playingIndex + 1, 0, track


      addLast: (track) ->
        @playlist.push track


      deleteIndex: (index) ->
        @playlist.splice index, 1
        
        if @playingIndex is index
          @playingIndex = -1
        else if @playingIndex > index
          @playingIndex--


      broadcastStartLoadingSong: ->
        $rootScope.$broadcast 'onBroadcastStartLoadingSong'

]
