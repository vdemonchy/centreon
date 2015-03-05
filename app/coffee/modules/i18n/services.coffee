###
RackMonkey - Criteo
(c) 2014
###
define [
    "angular"
    "modules/i18n/services/I18nService"
    "angular-resource"
], (
    angular,
    I18nService
) ->
    "use strict"
    angular
        .module 'app-i18n-services', []
        .service 'i18nService', I18nService
