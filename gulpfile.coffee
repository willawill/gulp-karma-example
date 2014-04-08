gulp = require 'gulp'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
compass = require 'gulp-compass'
connect = require 'gulp-connect'
cached = require 'gulp-cached'
clean = require 'gulp-clean'
rjs = require 'gulp-requirejs'
karma = require('karma').server
karmaRunner = require('karma').runner
requirejs = require 'requirejs'
runSequence = require 'run-sequence'


#Public used


gulp.task 'default', ->
  runSequence 'clean', 'dev', 'watch', 'test-watch'


gulp.task 'test', ->
  runSequence 'clean', 'coffee', 'lint', 'copy', 'test-once'


gulp.task 'build', ->
  runSequence 'clean', 'coffee', 'lint', 'copy', 'build-js'


#Private


gulp.task 'dev', ['coffee', 'lint', 'copy', 'connect']


gulp.task 'clean', ->
  gulp.src('./public/', {read: false})
  .pipe(clean({force: true}))


gulp.task 'lint', ->
  gulp.src('./dev/**/*.coffee')
  .pipe(cached('lint'))
  .pipe(coffeelint(
    no_unnecessary_fat_arrows:
      level: 'ignore'
    max_line_length:
      value: 100
  ))
  .pipe(coffeelint.reporter())


gulp.task 'coffee', ->
  gulp.src('./dev/**/*.coffee')
  .pipe(cached('coffee'))
  .pipe(coffee(
    bare: true
    sourceMap: true
  ).on('error', handleError))
  .pipe(gulp.dest('./public/'))
  .pipe(connect.reload())


gulp.task 'test-once', ->
  karma.start({
    configFile: __dirname + '/public/tests/karma-config.js'
    singleRun: true
    browsers: ['PhantomJS']
  }, (exitCode) ->
    console.log('Karma has exited with ' + exitCode);
    process.exit(exitCode);
  )


gulp.task 'test-watch', ->
  karma.start({
    configFile: __dirname + '/public/tests/karma-config.js'
  }, (exitCode) ->
    console.log('Karma has exited with ' + exitCode);
    process.exit(exitCode);
  )


gulp.task 'test-run', ->
  karmaRunner.run({
    configFile: __dirname + '/public/tests/karma-config.js'
  }, (exitCode) ->
    console.log('Karma has exited with ' + exitCode);
  )


gulp.task 'connect', ->
  connect.server {
    port: 8080
    livereload: on
  }
  

filesList = [
  'dev/**/*.css'
  'dev/**/*.hbs'
  'dev/**/*.js'
  'dev/**/*.png'
  'dev/**/*.gif'
  'dev/**/*.jpg'
  'dev/**/*.ttf'
  'dev/**/*.woff'
  'dev/**/*.eot'
  'dev/**/*.svg'
  'index.html'
  'dev/**/assets'
  'dev/**/*.json'
]

gulp.task 'copy', ->
  gulp.src(filesList)
  .pipe(cached('files'))
  .pipe(gulp.dest('./public/'))
  .pipe(connect.reload())


gulp.task 'watch', ->
  gulp.watch ['./dev/**/*.coffee', '!./dev/tests/**/*.coffee'], ['coffee', 'lint']
    
  gulp.watch ['./dev/tests/**/*.coffee'], ->
    runSequence 'coffee', 'lint', 'test-run'

  gulp.watch filesList, ['copy']


gulp.task 'build-js', ->
  requirejs.optimize {
    baseUrl: '.'
    appDir: 'public/app'
    dir: 'app_builds/en'
    mainConfigFile: 'public/app/config.js'
    waitSeconds: 60
    optimize: 'uglify2'
    removeCombined: true
    preserveLicenseComments: false
    useStrict: true
    modules: [
      name: 'config'
      exclude: ['json!properties']
    ]
  }


handleError = (err) ->
  console.log err.toString()
  @emit 'end'

