###
app
(c) 2015
###
define [
    'angular'
    'directives/NavDirective'
], (
    angular
    NavDirective
) ->
    "use strict"
    angular
        .module 'app-directives', ['app-factories']
        .directive 'navDirective', NavDirective
