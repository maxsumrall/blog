#global module:false

"use strict"

#mozjpeg = require('imagemin-mozjpeg');

module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-htmlmin"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-imagemin"
  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-connect"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-exec"
  grunt.loadNpmTasks "grunt-contrib-cssmin"

  grunt.initConfig

    exec:
      jekyll:
        cmd: "jekyll build --trace"

    watch:
      options:
        livereload: true
      source:
        files: [
          "assets/**/*"
          "images/**/*"
          "_config.yml"
          "*.html"
        ]
        tasks: [
          "exec:jekyll"
        ]

    connect:
      server:
        options:
          port: 4000
          base: '_site'
          livereload: true

    htmlmin:
      dist:
        options:
          removeComments: true,
          collapseWhitespace: true

        files:
          '_site/index.html': '_site/index.html'

    uglify:
      my_target:
        files:
          '_site/assets/js/main.js': ['_site/assets/js/main.js']

    imagemin:
      static:
        options:
          optimizationLevel: 3
          svgoPlugins: [removeViewBox: false ]
#          use: [mozjpeg()]
        files:
          '_site/images/gmu.png': '_site/images/gmu.png',
          '_site/images/kintivo.png': '_site/images/kintivo.png',
          '_site/images/lnu.jpg': '_site/images/lnu.jpg',
          '_site/images/neo4j.png': '_site/images/neo4j.png',
          '_site/images/nsf.jpg': '_site/images/nsf.jpg',
          '_site/images/tue.jpg': '_site/images/tue.jpg'
          '_site/images/me-400.jpg': '_site/images/me-400.jpg'
          '_site/images/hej.png': '_site/images/hej.png'
          '_site/images/paths.png': '_site/images/paths.png'


    cssmin:
      options:
        shorthandCompacting: false
        roundingPrecision: -1
      target:
        files:
          '_site/assets/css/main.css': ['_site/assets/css/main.css']
          '_site/assets/css/animate.css': ['_site/assets/css/animate.css']


  grunt.registerTask "build", [
    "exec:jekyll"
    "uglify"
    "imagemin"
    "cssmin"
  ]

  grunt.registerTask "serve", [
    "build"
    "connect:server"
    "watch"
  ]

  grunt.registerTask "default", [
    "serve"
  ]