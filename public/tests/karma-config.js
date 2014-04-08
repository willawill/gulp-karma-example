module.exports = function(config) {
  return config.set({
    basePath: '../',
    frameworks: ['mocha', 'chai'],
    files: [],
    exclude: [],
    client: {
      mocha: {
        ui: 'bdd'
      }
    },
    reporters: ['progress'],
    port: 9876,
    colors: true,
    logLevel: config.LOG_INFO,
    autoWatch: true,
    browsers: ['Chrome'],
    captureTimeout: 20000,
    singleRun: false,
    reportSlowerThan: 500,
    plugins: ['karma-mocha', 'karma-chai', 'karma-phantomjs-launcher', 'karma-chrome-launcher', 'karma-firefox-launcher']
  });
};

/*
//# sourceMappingURL=karma-config.js.map
*/
