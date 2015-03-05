###
RackMonkey - Criteo
(c) 2014
###
define [
    "angular"
    "modules/i18n/factories/I18nFactory"
    "angular-resource"
], (
    angular,
    I18nFactory
) ->
    "use strict"
    angular
        .module 'app-i18n-factories', []
        .factory 'i18nFactory', I18nFactory
