module.exports = (config) ->
  config.set({
    # base path, that will be used to resolve files and exclude
    basePath: '../'

    frameworks: ['jasmine', 'mocha', 'chai'],

    files: [
      {pattern: 'app/**/*.js', included: true, served: true, watched: false}
      {pattern: 'tests/**/*.js', included: true, served: true, watched: false}
    ],

    # list of files to exclude
    exclude: [
    ],

    client: {
      mocha: {
        ui: 'bdd'
      }
    },

    # use dots reporter, as travis terminal does not support escaping sequences
    # possible values: 'dots', 'progress'
    # CLI --reporters progress
    reporters: ['progress'],

    # web server port
    # CLI --port 9876
    port: 9876,

    # enable / disable colors in the output (reporters and logs)
    # CLI --colors --no-colors
    colors: true,

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN ||
    # config.LOG_INFO || config.LOG_DEBUG
    # CLI --log-level debug
    logLevel: config.LOG_INFO,

    # enable / disable watching file and executing tests whenever any file changes
    # CLI --auto-watch --no-auto-watch
    autoWatch: true,

    # If browser does not capture in given timeout [ms], kill it
    # CLI --capture-timeout 5000
    captureTimeout: 20000,

    # Auto run tests on start (when browsers are captured) and exit
    # CLI --single-run --no-single-run
    singleRun: false,

    # report which specs are slower than 500ms
    # CLI --report-slower-than 500
    reportSlowerThan: 500,

    plugins: [
      'karma-mocha',
      'karma-chai',
      'karma-phantomjs-launcher',
      'karma-chrome-launcher',
      'karma-jasmine',
      'karma-firefox-launcher'
    ]
  })
