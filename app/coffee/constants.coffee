###
app - Criteo
(c) 2015
###
define [
    'angular'
    'config'
    'constants/states'
],(
    angular
    Config
    States
) ->
    "use strict"
    angular
        .module 'app-constants', []
        .constant 'config', Config
        .constant 'states', States
