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
  ]

  grunt.registerTask 'build:webkit', [
    'build:dist'
    'nodewebkit'
  ]
