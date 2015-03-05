###
RackMonkey admin - Criteo
(c) 2015
###
define [
    'angular'
    'angular-animate'
    'angular-route'
    'angular-resource'
    'angular-cookies'
    'angular-sanitize'
    'angular-bootstrap'
    'angular-local-storage'
    'modules/i18n/directives'
    'modules/i18n/factories'
    'modules/i18n/services'
],(
    angular
) ->
    "use strict"
    name = 'app-i18n'
    angular
        .module name, [
            'ngRoute'
            'ngResource'
            'ngSanitize'
            'ngCookies'
            'ngAnimate'
            'app-i18n-directives'
            'app-i18n-factories'
            'app-i18n-services'
        ]
