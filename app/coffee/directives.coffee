###
app
(c) 2015
###
define [
    'angular'
    'directives/NavDirective'
    'directives/DropDownFilterDirective'
], (
    angular
    NavDirective
    DropDownFilterDirective
) ->
    "use strict"
    angular
        .module 'app-directives', ['app-factories']
        .directive 'navDirective', NavDirective
        .directive 'dropDownFilterDirective', DropDownFilterDirective
