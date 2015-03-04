###
RackMonkey - Criteo
(c) 2014
###
define [], ->
    "use strict"
    ###*
    # @ngdoc service
    # @name app-services.authService
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
        "$cookieStore"
        (
            $log
            $cookieStore
        ) ->

            token = undefined
            path = undefined
            prefs = undefined


            ###*
            # @ngdoc function
            # @name setPrefs
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @setPrefs = (myprefs)->
                prefs = myprefs

            ###*
            # @ngdoc function
            # @name getPrefs
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @getPrefs = () ->
                prefs


            ###*
            # @ngdoc function
            # @name getToken
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @getToken = ->
                if token is undefined
                    cookie = undefined
                    try
                        cookie = $cookieStore.get 'token'
                    catch err
                        token
                    if cookie isnt undefined
                        token = cookie
                token

            ###*
            # @ngdoc function
            # @name setToken
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @setToken = (mytoken) ->
                token = mytoken
                $cookieStore.put 'token', mytoken
                @

            ###*
            # @ngdoc function
            # @name removeToken
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @removeToken = () ->
                token = undefined
                $cookieStore.remove 'token'
                @

            ###*
            # @ngdoc function
            # @name getPath
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @getPath = ->
                path

            ###*
            # @ngdoc function
            # @name setPath
            # @methodOf app-services.authService
            # @function
            # @description TODO
            ###
            @setPath = (mypath) ->
                path = mypath
                @

            return
    ]
