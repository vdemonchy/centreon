module.exports = (config) ->
    config.set

        basePath: ""

        frameworks: [
            "jasmine"
            "requirejs"
        ]

        files: [
            {
                pattern: "web/js/test/unit/test-main.js"
                included: true
            }
            {
                pattern: "web/bundles/**/*.js"
                included: false
            }
            {
                pattern: "web/js/**/*.js"
                included: false
            }
            {
                pattern: "web/js/test/unit/**/*.specs.js"
                included: false
            }
        ]

        exclude: [
            "web/js/main.js"
        ]

        preprocessors :
            'web/js/controllers/**/*.js' : 'coverage'
            'web/js/directives/**/*.js' : 'coverage'
            'web/js/factories/**/*.js' : 'coverage'
            'web/js/filters/**/*.js' : 'coverage'
            'web/js/services/**/*.js' : 'coverage'

        reporters: ['progress', 'junit', 'coverage']

        junitReporter :
            outputFile: 'web/reports/test-results.xml'

        coverageReporter :
            type : 'html'
            dir : 'web/reports/'
            file: 'coverage.xml'
            subdir: '.',

        port: 8082
        colors: true
        logLevel: config.LOG_INFO
        autoWatch: true
        browsers: ["PhantomJS"]
        captureTimeout: 60000
        singleRun: true

    return
