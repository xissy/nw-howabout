path = require 'path'


module.exports = (grunt) ->
  for key of grunt.file.readJSON('package.json').devDependencies
    if key isnt 'grunt' and key.indexOf('grunt') is 0
      grunt.loadNpmTasks key
  
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    coffee:
      options:
        bare: true
      dev:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'app/scripts/'
          src: [ '**/*.coffee' ]
          dest: '.tmp/scripts/'
          ext: '.js'
        ]
      dist:
        options:
          sourceMap: true
        files: [
          expand: true
          cwd: 'app/scripts/'
          src: [ '**/*.coffee' ]
          dest: 'dist/scripts/'
          ext: '.js'
        ]

    jade:
      options:
        pretty: true
      dev:
        files: [
          expand: true
          cwd: 'app/'
          src: [
            '*.jade'
            'views/**/*.jade'
          ]
          dest: '.tmp/'
          ext: '.html'
        ]
      dist:
        files: [
          expand: true
          cwd: 'app/'
          src: [
            '*.jade'
            'views/**/*.jade'
          ]
          dest: 'dist/'
          ext: '.html'
        ]

    less:
      dev:
        options:
          yuicompress: false
        files: [
          expand: true
          cwd: 'app/styles/'
          src: [ '**/*.less' ]
          dest: '.tmp/styles/'
          ext: '.css'
        ]
      dist:
        options:
          yuicompress: true
        files: [
          expand: true
          cwd: 'app/styles/'
          src: [ '**/*.less' ]
          dest: 'dist/styles/'
          ext: '.css'
        ]

    copy:
      dev_html:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: '.tmp'
          src: [
            '*.html'
            'views/*.html'
          ]
        ]
      dev_resources:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: '.tmp'
          src: [
            'package.json'
            '*.{ico,png,txt}'
            'bower_components/**/*'
            'images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}'
            'styles/fonts/*'
          ]
        ]
      dist:
        files: [
          expand: true
          dot: true
          cwd: 'app'
          dest: 'dist'
          src: [
            'package.json'
            '*.{ico,png,txt}'
            'bower_components/**/*'
            'images/{,*/}*.{gif,webp,svg}'
            'styles/fonts/*'
            '*.html'
            'views/*.html'
          ]
        ]
      dist_font:
        files: [
          expand: true
          dot: true
          cwd: 'app/bower_components/font-awesome/font/'
          dest: 'dist/font/'
          src: [
            '**/*'
          ]
        ]

    cdnify:
      dist:
        html: [ 'dist/*.html' ]

    useminPrepare:
      html: [ 'dist/*.html' ]
      options:
        dest: 'dist/'

    usemin:
      html: [ 'dist/*.html' ]
      options:
        dirs: [ 'dist/' ]

    htmlmin:
      dist:
        options:
          removeCommentsFromCDATA: true
          # https://github.com/yeoman/grunt-usemin/issues/44
          collapseWhitespace: true
          collapseBooleanAttributes: true
          # removeAttributeQuotes: true
          removeRedundantAttributes: true
          useShortDoctype: true
          removeEmptyAttributes: true
          removeOptionalTags: true
        files: [
          expand: true
          cwd: 'dist/'
          src: [ '*.html', 'views/*.html' ]
          dest: 'dist/'
        ]

    imagemin:
      dist:
        files: [
          expand: true
          cwd: 'app/images/'
          src: '{,*/}*.{png,jpg,jpeg}'
          dest: 'dist/images/'
        ]

    clean: 
      dev: [ '.tmp/' ]
      dist: [ 'dist/' ]

    nodewebkit:
      options:
        build_dir: 'webkitbuilds'
        mac: true
        win: true
        linux32: false
        linux64: false
      src: [ 'dist/**/*' ]


  grunt.registerTask 'default', [
    'build'
  ]

  grunt.registerTask 'build', [
    'build:dev'
    'build:dist'
  ]

  grunt.registerTask 'build:dev', [
    'clean:dev'
    'coffee:dev'
    'jade:dev'
    'less:dev'
    'copy:dev_html'
    'copy:dev_resources'
  ]

  grunt.registerTask 'build:dist', [
    'clean:dist'
    'coffee:dist'
    'jade:dist'
    'less:dist'
    'copy:dist'
    'copy:dist_font'
    'useminPrepare'
    'concat'
    'uglify'
    'cssmin'
    'usemin'
    'htmlmin:dist'
    'cdnify'
    'imagemin:dist'
  ]

  grunt.registerTask 'build:webkit', [
    'build:dist'
    'nodewebkit'
  ]
