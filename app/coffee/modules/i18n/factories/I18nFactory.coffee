###
RackMonkey - Criteo
(c) 2014
###
define [], ->
    "use strict"
    ###*
    # @ngdoc service
    # @name app-factories.i18nFactory
    # @description
    #
    # Angular app factory.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$log"
        "$http"
        "$q"
        "i18nService"
        "config"
        (
            $log,
            $http,
            $q
            i18nService
            config
        ) ->

            ###*
            # @ngdoc function
            # @name setBundles
            # @methodOf app-factories.i18nFactory
            # @function
            # @param {String} mylang the lang
            # @description loads the bundles definitions, according to the lang
            # which have been defined in i18nService.
            ###
            getBundles: (mylang = undefined) ->
                defer = $q.defer()
                old = i18nService.getLang()
                newlang = mylang or old or config.DEFAULT_BUNDLES
                if newlang is old
                    defer.resolve newlang
                else
                    $http
                        .get newlang
                        .then (response) ->
                            unless response?.status isnt 200
                                i18nService.setLang newlang
                                i18nService.setBundles response.data
                                defer.resolve newlang
                defer.promise
    ]
