###
centreon
(c) 2015
###
define [], ->
    "use strict"
    ###*
    # @ngdoc service
    # @name app-factories.authInterceptorFactory
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
        "$rootScope"
        "$q"
        "$location"
        "$log"
        "authService"
        (
            $rootScope
            $q
            $location
            $log
            authService
        ) ->

            ###*
            # @ngdoc function
            # @name request
            # @methodOf app-factories.authInterceptorFactory
            # @function
            # @param {Object} config the config
            # @description intercepts each request and insert the token
            ###
            request: (config) ->
                config.headers = config.headers || {}
                if authService.getToken() isnt undefined
                    config.headers.Authorization = 'Bearer ' +
                        authService.getToken()
                config

            ###*
            # @ngdoc function
            # @name response
            # @methodOf app-factories.authInterceptorFactory
            # @function
            # @param {Object} response the response
            # @description returns the response.
            ###
            response: (response) ->
                response

            ###*
            # @ngdoc function
            # @name responseError
            # @methodOf app-factories.authInterceptorFactory
            # @function
            # @param {Object} response the response object
            # @description if the fired error is 401, user is redirected
            # to login step.
            ###
            responseError: (response) ->
                if response.status is 401
                    authService.removeToken()
                    if $location.path() is '/login'
                        $rootScope.$broadcast 'API_ERROR',
                            status : 401
                            data: response.data.error
                    else
                        $location.path '/login'
                response
    ]
