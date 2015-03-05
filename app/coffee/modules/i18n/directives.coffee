###
RackMonkey - Criteo
(c) 2014
###
define [
    'angular'
    'modules/i18n/directives/I18nDirective'
], (
    angular
    I18nDirective
) ->
    "use strict"
    angular
        .module 'app-i18n-directives', []
        .directive 'i18n', I18nDirective

