###
app
(c) 2015
###
define [
    'angular'
    'services/AuthService'
    'services/I18nService'
    'angular-resource'
], (
    angular
    AuthService
    I18nService
) ->
    "use strict"
    angular
        .module 'app-services', ['ngResource']
        .service 'authService', AuthService
        .service 'i18nService', I18nService
