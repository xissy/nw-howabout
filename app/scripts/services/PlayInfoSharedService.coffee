GS = require 'grooveshark-streaming'
ytdl = require 'ytdl'
request = require 'request'
fs = require 'fs'


howaboutServices.factory 'PlayInfoSharedService', [
  '$rootScope'
  'PlayInfo'
  ($rootScope, PlayInfo) ->

    getStreamUrl = (track, callback) ->
      playInfo = PlayInfo.get
        trackTitle: track.trackTitle
        artistName: track.artistName
      ,
        ->
          @lyrics = playInfo.lyrics
          @track = track

          if not playInfo.groovesharkSongID?
            return ytdl.getInfo playInfo.youtubeMovieUrl, (err, youtubeInfo) ->
              return callback err  if err?
              return callback new Error 'no youtubeInfo.formats'  if not youtubeInfo?.formats?

              for format in youtubeInfo.formats
                if format.itag is '18'
                  streamUrl = format.url
                  break

              if not streamUrl?
                return callback new Error 'no youtube itag 18 streamUrl'

              callback null, streamUrl

          GS.Grooveshark.getStreamingUrl playInfo.groovesharkSongID, (err, streamUrl) ->
            return callback err  if err?
            return callback new Error 'no grooveshark streamUrl'  if not streamUrl?

            callback null, streamUrl

    sharedService =
      streamUrl: null
      lyrics: null
      track: null

      playTrack: (track) ->
        getStreamUrl track, (err, streamUrl) =>
          if err?
            return alert "무료 음원을 찾을 수 없습니다.\n#{track.trackTitle} - #{track.artistName}"
          
          @streamUrl = streamUrl
          @broadcastPlayInfo()


      downloadTrack: (track, filePath) ->
        getStreamUrl track, (err, streamUrl) ->
          if err?
            return alert "무료 음원을 찾을 수 없습니다.\n#{track.trackTitle} - #{track.artistName}"
          
          streamRequest = request
            url: streamUrl
          fileStream = fs.createWriteStream filePath
          streamPipe = streamRequest.pipe fileStream
          
          fileStream.on 'finish', ->
            console.log "다운로드가 완료되었습니다.\n#{track.trackTitle} - #{track.artistName}"
            alert "다운로드가 완료되었습니다.\n#{track.trackTitle} - #{track.artistName}"
          fileStream.on 'error', ->
            console.log "다운로드가 실패하였습니다.\n#{track.trackTitle} - #{track.artistName}"
            alert "다운로드가 실패하였습니다.\n#{track.trackTitle} - #{track.artistName}"


      broadcastPlayInfo: ->
        $rootScope.$broadcast 'onPlayInfoBroadcast'
      
]
