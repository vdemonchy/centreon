###
app
(c) 2015
###
define [
    "angular"
    "factories/AuthInterceptorFactory"
    "factories/ErrorInterceptorFactory"
    "factories/I18nFactory"
    "angular-resource"
], (
    angular,
    AuthInterceptorFactory
    ErrorInterceptorFactory
    I18nFactory
) ->
    "use strict"
    angular
        .module 'app-factories', ['ngResource', 'app-services']
        .factory 'authInterceptorFactory', AuthInterceptorFactory
        .factory 'errorInterceptorFactory', ErrorInterceptorFactory
        .factory 'i18nFactory', I18nFactory
