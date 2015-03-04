###
app
(c) 2015
###
require.config
    #urlArgs: "ts=" + (new Date()).getTime()
    waitSeconds : 10
    paths:
        'jquery': '/bundles/jquery/dist/jquery'
        'angular': '/bundles/angular/angular'
        'angular-animate': '/bundles/angular-animate/angular-animate'
        'angular-route': '/bundles/angular-route/angular-route',
        'angular-resource'  : '/bundles/angular-resource/angular-resource'
        'angular-cookies'  : '/bundles/angular-cookies/angular-cookies'
        'angular-sanitize': '/bundles/angular-sanitize/angular-sanitize'
        'angular-bootstrap' : '/bundles/angular-bootstrap/ui-bootstrap'
        'angular-local-storage' : '/bundles/angular-local-storage/dist/angular-local-storage'
        'angular-google-chart' : '/bundles/angular-google-chart/ng-google-chart'
        'templates-app' : '/js/templates'
        'pretty-json' : '/bundles/ng-prettyjson/dist/ng-prettyjson.min'
    shim:
        'angular':
            deps: ['jquery']
            exports: 'angular'
        'angular-animate' : ['angular']
        'angular-route': ['angular'],
        'angular-resource'  : ['angular']
        'angular-cookies'  : ['angular']
        'angular-sanitize' : ['angular']
        'angular-bootstrap' : ['angular']
        'angular-local-storage' : ['angular']
        'templates-app' : ['angular']
        'angular-google-chart' : ['angular']
        'pretty-json' : ['angular']
    deps: ['app']
