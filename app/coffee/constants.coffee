###
app - Criteo
(c) 2015
###
define [
    'angular'
    'config'
],(
    angular
    Config
) ->
    "use strict"
    angular
        .module 'app-constants', []
        .constant 'config', Config
