###
RackMonkey - Criteo
(c) 2014
###
define [], ->
    "use strict"
    ###*
    # @ngdoc service
    # @name app-services.i18nService
    # @description
    #
    # Angular app service.
    #
    # <h2>Settings</h2>
    # <pre>
    # <style type="text/css">
    # </style>
    # </pre>
    ###
    [
        "$log"
        "$sce"
        (
            $log,
            $sce
        ) ->

            bundles = undefined
            lang = undefined

            ###*
            # @ngdoc function
            # @name getLang
            # @methodOf app-services.i18nService
            # @function
            # @description returns the defined lang for application.
            ###
            @getLang = ->
                lang

            ###*
            # @ngdoc function
            # @name setlang
            # @methodOf app-services.i18nService
            # @function
            # @description defines the default lang, available for application.
            ###
            @setLang = (mylang) ->
                lang = mylang
                @

            ###*
            # @ngdoc function
            # @name getBundles
            # @methodOf app-services.i18nService
            # @function
            # @description returns the bundles definitions for default lang.
            ###
            @getBundles = ->
                bundles

            ###*
            # @ngdoc function
            # @name setBundles
            # @methodOf app-services.i18nService
            # @function
            # @description defines the lang collections for application.
            ###
            @setBundles = (mybundles) ->
                bundles = mybundles
                @

            ###*
            # @ngdoc function
            # @name isLabel
            # @methodOf app-services.i18nService
            # @function
            # @description returns true or false, depending if the provided
            # key exist
            # in bundles definitions.
            ###
            @isLabel = (key) ->
                unless bundles is undefined
                    return true if bundles[key]
                false

            ###*
            # @ngdoc function
            # @name getLabel
            # @methodOf app-services.i18nService
            # @function
            # @description returns the label value of the provided key.
            # if the key doesn't exist, then the key is returned
            # surrounded by '??'
            ###
            @getLabel = (key) ->
                unless bundles is undefined
                    if bundles[key]
                        return $sce.trustAsHtml bundles[key]
                $sce.trustAsHtml "??" + key + "??"

            ###*
            # @ngdoc function
            # @name getTextLabel
            # @methodOf app-services.i18nService
            # @function
            # @description returns the label value of the provided key.
            # value can be text only, if html, a security exception
            # will be fired.
            ###
            @getTextLabel = (key) ->
                unless bundles is undefined
                    if bundles[key]
                        return bundles[key]
                "??" + key + "??"


            ###*
            # @ngdoc function
            # @name getDynamicLabel
            # @methodOf app-services.i18nService
            # @function
            # @description returns the label value, interpolated with the
            # provided datas.
            ###
            @getDynamicLabel = (key, datas) ->
                originalKey = @getLabel(key).toString()
                newKey = originalKey.replace(/\{\{(.+?)\}\}/g, (match, name) ->
                    if datas[name]?
                        datas[name]
                    else
                        match
                )
                $sce.trustAsHtml newKey

            return
    ]
