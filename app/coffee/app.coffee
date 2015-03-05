###
app - Criteo
(c) 2015
###
define [
    'angular'
    'routes'
    'angular-animate'
    'angular-route'
    'angular-resource'
    'angular-cookies'
    'angular-sanitize'
    'angular-bootstrap'
    'angular-local-storage'
    'templates-app'
    'angular-google-chart'
    'controllers'
    'providers'
    'services'
    'factories'
    'directives'
    'filters'
    'constants'
    'values'
    'bootstrap-tpl'
    'modules/i18n/i18n'
    'modules/dashboard/dashboard'
],(
    angular
    routes
) ->
    "use strict"
    name = 'app'
    angular
        .module name, [
            'ngRoute'
            'ngResource'
            'ngSanitize'
            'ngCookies'
            'ngAnimate'
            'ui.bootstrap'
            'app-controllers'
            'app-providers'
            'app-services'
            'app-factories'
            'app-directives'
            'app-filters'
            'app-constants'
            'app-values'
            'templates-app'
            'ui.bootstrap.tpls'
            'LocalStorageModule'
            'app-dashboard'
            'app-i18n'
        ]
        .config routes
        .config [
            '$locationProvider'
            ($locationProvider) ->
                $locationProvider.html5Mode
                    enabled: true
                    requireBase: false
        ]
        .config [
            "$httpProvider"
            ($httpProvider) ->
              $httpProvider.interceptors.push 'errorInterceptorFactory'
              $httpProvider.interceptors.push 'authInterceptorFactory'
        ]
    $body = angular.element('body')
    angular.bootstrap $body, [name]
