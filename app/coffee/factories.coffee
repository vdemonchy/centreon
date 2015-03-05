###
app
(c) 2015
###
define [
    "angular"
    "factories/AuthInterceptorFactory"
    "factories/ErrorInterceptorFactory"
    "angular-resource"
], (
    angular,
    AuthInterceptorFactory
    ErrorInterceptorFactory
) ->
    "use strict"
    angular
        .module 'app-factories', []
        .factory 'authInterceptorFactory', AuthInterceptorFactory
        .factory 'errorInterceptorFactory', ErrorInterceptorFactory
