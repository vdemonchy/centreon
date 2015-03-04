gulp        = require 'gulp'
gutil       = require 'gulp-util'
coffee      = require 'gulp-coffee'
coffeelint  = require 'gulp-coffeelint'
changed     = require 'gulp-changed'
less        = require 'gulp-less'
nodemon     = require 'gulp-nodemon'
rename      = require 'gulp-rename'
tar         = require "gulp-tar"
gzip        = require 'gulp-gzip'
path        = require 'path'
del         = require 'del'
karma       = require('karma').server
protractor  = require("gulp-protractor").protractor
html2js     = require 'gulp-ng-html2js'
concat      = require 'gulp-concat'
ngdocs      = require "gulp-ngdocs"
rjs         = require "gulp-requirejs"
livereload  = require "gulp-livereload"
plumber     = require "gulp-plumber"
notify      = require "gulp-notify"
gulpif      = require "gulp-if"
runSequence = require "run-sequence"
uglify      = require 'gulp-uglify'
argv        = require 'yargs'
    .default 'target', 'local'
    .default 'watch', false
    .argv

require('events').EventEmitter.prototype._maxListeners = 100
#
# gzip
#
gulp.task "gzip", [], ->
    d = new Date()
    c_date = d.getDate()
    c_month = d.getMonth() + 1
    c_year = d.getFullYear()
    c_date = '0' + c_date if c_date <= 9
    c_month = '0' + c_month if c_month <= 9
    now = c_year + "-" + c_month + "-" + c_date
    gulp
        .src 'web/**/*'
        .pipe plumber()
        .pipe tar 'app-ui-' + now + '.' + argv.target + '.tar'
        .pipe gzip()
        .pipe gulp.dest '.'
#
# ngdocs
#
gulp.task "ngdocs", [], ->
    options =
        dest: 'web/docs'
        html5Mode: true
        startPage : '/api'
        title: "app UI docs"
    gulp
        .src "./web/js/**/*.js"
        .pipe plumber()
        .pipe ngdocs.process options
        .pipe gulp.dest options.dest
#
# test
#
gulp.task "test", ['coffee', 'config', 'html2js'], (done)->
    karma.start
        configFile: __dirname + "/karma.config.js"
        singleRun: true
    , done()

#
# protractor
#
gulp.task "e2e", [], (done)->
    gulp
        .src "web/js/e2e/**/*.e2e.js"
        .pipe plumber()
        .pipe protractor({
            configFile: "web/js/test/e2e/protractor.conf.js",
            args: [
                '--seleniumServerJar',
                'node_modules/selenium-server/lib/runner/selenium-server-standalone-2.44.0.jar',
                '--chromeDriver',
                'node_modules/chromedriver/bin/chromedriver'
            ]
        })
        .on 'error', (err)->
            gutil.log(err);
            gutil.beep();
            @.emit 'end'

#
# html2js
#
gulp.task "html2js", [], (done)->
    gulp
        .src('app/tpl/**/*.tpl.html')
        .pipe plumber()
        .pipe(
            html2js({
                moduleName: "templates-app",
                prefix: "tpl/"
            })
        )
        .pipe concat 'templates.js'
        .pipe changed './web/js/', { hasChanged: changed.compareSha1Digest }
        .pipe gulp.dest 'web/js/'
        .pipe gulpif argv.watch, livereload()

#
# coffee lint
#
gulp.task "lint", [], ->
    gulp
        .src([
            'app/coffee/**/*.coffee'
            '!app/coffee/bootstrap-tpl.coffee'
            '!app/coffee/main.coffee'
            '!app/coffee/test/**/*'
            '!app/coffee/**/_*.coffee'
        ])
        .pipe plumber()
        .pipe(coffeelint(
            opt:
                'indentation' :
                    "value": 4
                    "level": "error"

                'no_trailing_whitespace' :
                    'level' : 'error'

                'max_line_length' :
                    'level' : 'warn'
        ))
        .pipe coffeelint.reporter()

#
# requirejs
#
gulp.task "rjs", [], ->
    rjs({
        baseUrl : 'web/js/',
        mainConfigFile : 'web/js/main.js',
        urlArgs: "ts=" + (new Date()).getTime()
        waitSeconds : 10
        name : 'main',
        out : 'main.js'
        paths:
            'jquery': '../bundles/jquery/dist/jquery'
            'angular': '../bundles/angular/angular'
            'angular-animate': '../bundles/angular-animate/angular-animate'
            'angular-route': '../bundles/angular-route/angular-route',
            'angular-resource'  : '../bundles/angular-resource/angular-resource'
            'angular-cookies'  : '../bundles/angular-cookies/angular-cookies'
            'angular-sanitize': '../bundles/angular-sanitize/angular-sanitize'
            'angular-bootstrap' : '../bundles/angular-bootstrap/ui-bootstrap'
            'angular-local-storage' : '../bundles/angular-local-storage/dist/angular-local-storage'
            'angular-google-chart' : '../bundles/angular-google-chart/ng-google-chart'
            'templates-app' : '../js/templates'
            'pretty-json' : '../bundles/ng-prettyjson/dist/ng-prettyjson.min'
    })
    .pipe plumber()
    .pipe uglify()
    .pipe gulp.dest './web/js/'

#
# clean
#
gulp.task "cleancoffee", [], (cb) ->
    del ['web/js/*'], cb

gulp.task "cleanless", [], (cb) ->
    del ['web/css/*'], cb

#
# less
#
gulp.task "less", [], ->
    gulp
        .src "./app/less/index.less"
        .pipe changed './web/css/', { hasChanged: changed.compareSha1Digest }
        .pipe(less(paths: [path.join(__dirname, "less", "includes")]))
        .on 'error', (err) ->
            gutil.log(err);
            gutil.beep();
            @.emit 'end'
        .pipe gulp.dest "./web/css/"
        .pipe gulpif argv.watch, livereload()

#
# coffee
#
gulp.task "coffee", [], ->
    gulp
        .on "error", gutil.log
        .src "karma.config.coffee"
        .pipe plumber()
        .pipe coffee bare: true
        .on 'error', (err) ->
            gutil.log(err);
            gutil.beep();
            @.emit 'end'
        .pipe changed './', { hasChanged: changed.compareSha1Digest }
        .pipe gulp.dest "./"
        .pipe gulpif argv.watch, livereload()

    gulp
        .on "error", gutil.log
        .src "./server/*.coffee"
        .pipe plumber()
        .pipe coffee bare: true
        .pipe changed './server/', { hasChanged: changed.compareSha1Digest }
        .pipe gulp.dest "./server/"

    gulp
        .on "error", gutil.log
        .src "./app/coffee/**/*.coffee"
        .pipe plumber()
        .pipe coffee bare: true
        .pipe changed './web/js/', { hasChanged: changed.compareSha1Digest }
        .pipe gulp.dest "./web/js/"
        .pipe gulpif argv.watch, livereload()

#
# config
#
gulp.task "config", ['coffee'], (done)->
    gulp
        .src "./web/js/constants/config/_" + argv.target + ".js"
        .pipe plumber()
        .pipe rename 'config.js'
        .pipe changed './web/js/', { hasChanged: changed.compareSha1Digest }
        .on "error", gutil.log
        .pipe gulp.dest './web/js/'
        .pipe gulpif argv.watch, livereload()
        ###
        .once 'end', ()->
            process.exit()
        ###

#
# serve
#
gulp.task "serve", ['config'], ()->
    nodemon(
        script: "server/server.js"
        #ext: "js"
        ignore: ['./web/', './node_modules/']
        #options: '--watch -i client/*'
    )
    .on "change", []
    .on "restart", ->

#
# watch coffee
#
gulp.task "watch", ['serve'], ()->
    livereload.listen()
    gulp.watch './app/coffee/**/*.coffee', ['coffee']
    gulp.watch './app/less/**/*.less', ['less']
    gulp.watch './app/tpl/**/*.tpl.html', ['html2js']
#
# default
#
gulp.task 'default', (done) ->
    if argv.watch
        runSequence ['cleancoffee', 'cleanless'], ['lint', 'less', 'html2js', 'config'], 'watch'
    else
        runSequence ['cleancoffee', 'cleanless'], ['lint', 'less', 'html2js', 'config']

gulp.task "build", ['lint', 'less', 'html2js', 'config'], (done)->
    done() if done
    process.exit()

gulp.task "release", [], (done)->
    runSequence ['cleancoffee', 'cleanless'], ['lint', 'less', 'html2js', 'config'], ['rjs'], ['gzip']
