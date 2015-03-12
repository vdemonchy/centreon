###
app-dashboard - Criteo
(c) 2015
###
define [
    'angular'
    'modules/dashboard/routes'
    'angular-animate'
    'angular-route'
    'angular-resource'
    'angular-cookies'
    'angular-sanitize'
    'angular-bootstrap'
    'angular-local-storage'
    'modules/dashboard/controllers'
    'modules/dashboard/factories'
],(
    angular
    routes
) ->
    "use strict"
    name = 'app-dashboard'
    angular
        .module name, [
            'ngRoute'
            'ngResource'
            'ngSanitize'
            'ngCookies'
            'ngAnimate'
            'ui.bootstrap'
            'templates-app'
            'ui.bootstrap.tpls'
            'LocalStorageModule'
            'app-dashboard-controllers'
            'app-dashboard-factories'
        ]
        .config routes
