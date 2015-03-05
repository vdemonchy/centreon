###
app
(c) 2015
###
define [
    'angular'
    'services/AuthService'
    'angular-resource'
], (
    angular
    AuthService
) ->
    "use strict"
    angular
        .module 'app-services', []
        .service 'authService', AuthService
